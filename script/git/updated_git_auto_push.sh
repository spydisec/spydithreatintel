#!/usr/bin/env bash
# updated_git_auto_push.sh - Automated Git sync using centralized configuration.
# Pulls, adds specific files, commits, and pushes changes with push retries.
# Will push if branch is ahead, even if no new commits were made in this run.
# Relies on EXTERNAL locking (e.g., flock in cron) for serialization.

# --- Source Configuration ---
COMMON_SH_PATH="$(dirname "$0")/../common.sh"
if [[ ! -f "$COMMON_SH_PATH" ]]; then
  if [[ -f "/home/spydisec/spydiblocklist/script/common.sh" ]]; then
      COMMON_SH_PATH="/home/spydisec/spydiblocklist/script/common.sh"
  else
      echo "ERROR: common.sh not found via relative path or absolute fallback." >&2; exit 1;
  fi
fi
source "$COMMON_SH_PATH" || { echo "ERROR: Unable to source common.sh from $COMMON_SH_PATH" >&2; exit 1; }

# --- Load Configuration ---
SLACK_WEBHOOK_URL=$(get_config "slack.webhook_url")
REPO_DIR="$GIT_REPO_DIR"
BRANCH="$GIT_BRANCH"
LOG_FILE="$AUTO_PUSH_LOG"
MAX_LOG_SIZE_MB=$(get_config "git.auto_push_max_log_size_mb")

# --- Push Retry Configuration ---
MAX_PUSH_ATTEMPTS=10
PUSH_RETRY_DELAY=20

# Ensure critical directories/files are configured
if [ -z "$REPO_DIR" ] || [ "$REPO_DIR" = "null" ]; then handle_error "Git repository directory (git.repo_dir) not defined in config"; fi
if [ -z "$LOG_FILE" ] || [ "$LOG_FILE" = "null" ]; then handle_error "Git auto push log file (git.auto_push_log) not defined in config"; fi
if [ -z "$BRANCH" ] || [ "$BRANCH" = "null" ]; then handle_error "Git branch (git.branch) not defined in config"; fi
if [ -z "$MAX_LOG_SIZE_MB" ] || [ "$MAX_LOG_SIZE_MB" = "null" ]; then MAX_LOG_SIZE_MB=10; echo "Warning: git.auto_push_max_log_size_mb not set, defaulting to 10MB."; fi

# --- Helper Functions ---
log_message() {
    # Ensure log dir exists
    mkdir -p "$(dirname "$LOG_FILE")"
    # Append timestamp and message to log file AND display on console
    echo "$(date +"%Y-%m-%d %H:%M:%S") - [$2] $1" | tee -a "$LOG_FILE" # Added optional level arg cosmetic
}

send_slack_notification() {
    # Check for placeholder or missing URL
    if [ -z "$SLACK_WEBHOOK_URL" ] || [ "$SLACK_WEBHOOK_URL" = "null" ] || [[ "$SLACK_WEBHOOK_URL" == *"YOUR_SLACK"* ]]; then
        log_message "[Slack] Webhook URL not configured or is placeholder. Skipping Slack notification." "WARN"
        return 0
    fi
    # Basic escaping for JSON payload
    local message_text_escaped=$(echo "$1" | sed 's/"/\\"/g' | sed "s/'/\\'/g" | sed ':a;N;$!ba;s/\n/\\n/g') # Escape quotes and newlines
    # Use markdown code block in Slack for better readability
    local payload="{\"text\": \"Git Sync Alert ($HOSTNAME):\\n\`\`\`${message_text_escaped}\`\`\`\"}"
    log_message "[Slack] Sending notification..." "DEBUG"
    # Send notification with timeout
    if curl --silent --fail -X POST -H 'Content-type: application/json' --data "$payload" "$SLACK_WEBHOOK_URL" --max-time 20; then
        log_message "[Slack] Notification sent successfully." "DEBUG"
    else
        log_message "[Slack] ERROR: Failed to send notification." "ERROR"
    fi
}

handle_error() {
    local error_message="$1"
    local exit_code="${2:-1}" # Default exit code 1 if not provided

    log_message "ERROR: ${error_message}" "ERROR"

    # Construct final message (without diagnosis)
    local final_error_report="Original Error: ${error_message}"

    # Attempt notification before exiting
    send_slack_notification "$final_error_report" "error"

    # No trap needed as external flock handles coordination

    exit "$exit_code"
}

rotate_log() {
    if [ ! -f "$LOG_FILE" ]; then return; fi
    # Use stat for size check
    local log_size_bytes=$(stat -c%s "$LOG_FILE" 2>/dev/null || echo 0)
    # Correct calculation
    local max_log_size_bytes=$(( MAX_LOG_SIZE_MB * 1024 * 1024 ))

    if [ "$log_size_bytes" -ge "$max_log_size_bytes" ]; then
        local timestamp=$(date +"%Y%m%d_%H%M%S")
        local rotated_log="${LOG_FILE}.${timestamp}"
        log_message "Log file size ($((log_size_bytes / 1024 / 1024))MB) exceeds limit (${MAX_LOG_SIZE_MB}MB). Rotating to ${rotated_log}" "WARN"
        # Force move
        mv -f "$LOG_FILE" "$rotated_log" || log_message "ERROR: Failed to rotate log file." "ERROR"
        # Compress in background
        gzip "$rotated_log" &
    fi
}

check_git() {
    if ! command -v git &> /dev/null; then handle_error "Git command not found. Please install Git."; fi
    if [ ! -d "$REPO_DIR/.git" ]; then handle_error "Not a Git repository: '$REPO_DIR'"; fi
}

# --- Main Script Logic ---
log_message "======= Starting Git synchronization script (using external lock) =======" "INFO"
rotate_log
check_git
log_message "Navigating to repository: $REPO_DIR" "INFO"
cd "$REPO_DIR" || handle_error "Failed to change directory to '$REPO_DIR'" 1

# --- Check for Git LFS ---
if ! git lfs version &>/dev/null; then
    log_message "Git LFS is not installed! Please install git-lfs for large file support." "ERROR"
    exit 2
fi

# Ensure LFS hooks are installed (safe to run repeatedly)
git lfs install --local

# --- Fetch and Check Remote Status First ---
log_message "Fetching changes from remote origin..." "INFO"
if ! git fetch origin "$BRANCH"; then
    handle_error "Git fetch failed. Check connection and remote repository status." 5
fi
log_message "Fetch complete." "INFO"

# --- Check Git State and Pull/Rebase (if necessary) ---
LOCAL=$(git rev-parse @ 2>/dev/null)
REMOTE=$(git rev-parse "origin/$BRANCH" 2>/dev/null)
BASE=$(git merge-base @ "origin/$BRANCH" 2>/dev/null)
FETCH_EXIT=$? # Capture exit status of previous commands
PULL_WAS_NEEDED=true # Flag to track if pull was required

# Check if state determination failed
if [ $FETCH_EXIT -ne 0 ] || [ -z "$LOCAL" ] || [ -z "$REMOTE" ] || [ -z "$BASE" ]; then
    log_message "Warning: Could not determine repository state reliably (rev-parse/merge-base failed). Attempting basic pull." "WARN"
    if ! git pull --autostash origin "$BRANCH"; then
         handle_error "Basic 'git pull' failed after state check failure." 6
    fi
    PULL_WAS_NEEDED=true
    # Re-fetch state info after successful basic pull
    LOCAL=$(git rev-parse @ 2>/dev/null); REMOTE=$(git rev-parse "origin/$BRANCH" 2>/dev/null); BASE=$(git merge-base @ "origin/$BRANCH" 2>/dev/null)

# Check state based on fetched info
elif [ "$LOCAL" = "$REMOTE" ]; then
    log_message "Local branch '$BRANCH' is already up-to-date." "INFO"
elif [ "$LOCAL" = "$BASE" ]; then
    # Local is behind remote
    log_message "Local branch '$BRANCH' is behind. Attempting fast-forward pull..." "INFO"
    PULL_WAS_NEEDED=true
    if ! git pull --ff-only --autostash origin "$BRANCH"; then
         log_message "Fast-forward pull failed/not possible, attempting rebase pull..." "WARN"
         if ! git pull --rebase --autostash origin "$BRANCH"; then
             local status_output=$(git status --short | sed 's/^/    /')
             handle_error "git pull --rebase failed. Manual intervention likely required.\nGit status:\n${status_output}" 7
         fi
    fi
    log_message "Pull/Rebase successful." "INFO"
    # Re-fetch state info after successful pull/rebase
    LOCAL=$(git rev-parse @ 2>/dev/null); REMOTE=$(git rev-parse "origin/$BRANCH" 2>/dev/null); BASE=$(git merge-base @ "origin/$BRANCH" 2>/dev/null)

elif [ "$REMOTE" = "$BASE" ]; then
    # Local is ahead of remote
    log_message "Local branch '$BRANCH' is ahead. No pull needed before push." "INFO"
else
    # Branches have diverged
    log_message "Local branch '$BRANCH' has diverged. Attempting rebase..." "WARN"
    PULL_WAS_NEEDED=true
    if ! git pull --rebase --autostash origin "$BRANCH"; then
        local status_output=$(git status --short | sed 's/^/    /')
        handle_error "git pull --rebase failed (diverged state). Manual intervention REQUIRED.\nGit status:\n${status_output}" 8
    fi
    log_message "Rebase successful." "INFO"
     # Re-fetch state info after successful pull/rebase
    LOCAL=$(git rev-parse @ 2>/dev/null); REMOTE=$(git rev-parse "origin/$BRANCH" 2>/dev/null); BASE=$(git merge-base @ "origin/$BRANCH" 2>/dev/null)
fi

# --- Add Specific Files ---
log_message "Adding specific tracked files to staging area..." "INFO"
# CRITICAL: Ensure this list is accurate and complete!
# NOTE: Large files (malicious_domains.txt, perm_domainlist.txt, spamscamabuse_domains.txt)
#       are excluded here and uploaded to Cloudflare R2 instead (see R2 upload section below)
git add \
    iplist/master_malicious_iplist.txt \
    iplist/filtered_malicious_iplist.txt \
    iplist/removedips/removed_ips.db \
    domainlist/malicious/domain_ioc_maltrail_new.txt \
    domainlist/malicious/phishing_domains.txt \
    domainlist/ads/advtracking_domains.txt \
    iplist/C2IPs/master_c2_iplist.txt \
    iplist/ip_ioc_maltrail_feed_new.txt \
    iplist/referenced_malicious_ips.txt \
    iplist/low/low_confidence.txt \
    iplist/medium/medium_confidence_limited.txt \
    iplist/medium/medium_confidence_unlimited.txt \
    iplist/high/high_confidence_limited.txt \
    iplist/high/high_confidence_unlimited.txt \
    README.md \
    domainlist/SOURCES.md \
    whitelist/wl_iplist/cdnips.txt \
    whitelist/wl_iplist/forcedwhitelistips.txt \
    whitelist/wl_domainlist/osintwhitelisteddomains.txt \
    whitelist/wl_domainlist/mypiholewhitelisteddomains.txt \
    iplist/honeypot/honeypot_extracted_feed.txt \
    iplist/honeypot/osinthoneypotfeed.txt \
    iplist/threatfoxallips.txt \
    iplist/threatfoxhighconfidenceips.txt
ADD_EXIT_CODE=$?
if [ $ADD_EXIT_CODE -ne 0 ]; then
    handle_error "git add command failed with exit code $ADD_EXIT_CODE." 9
fi

# --- Commit If Changes Staged ---
NEW_COMMIT_MADE=false # Flag to track if we made a commit in this run
if git diff --staged --quiet; then
    log_message "No changes staged for commit in this run." "INFO"
else
    COMMIT_TIME=$(date +"%Y-%m-%d %H:%M:%S UTC")
    COMMIT_MESSAGE="Automatic Update: ${COMMIT_TIME}"
    log_message "Staged changes detected. Committing with message: '$COMMIT_MESSAGE'" "INFO"
    # Configure git user locally for this commit
    git config user.name "SpydiTI"
    git config user.email "spyditi@proton.me"

    if ! git commit -m "$COMMIT_MESSAGE"; then
        handle_error "git commit failed. Check repository status." 10
    fi
    log_message "Commit successful." "INFO"
    NEW_COMMIT_MADE=true
    # Refresh LOCAL commit ID after making a new one
    LOCAL=$(git rev-parse @ 2>/dev/null)
fi

# --- Determine if Push is Needed ---
NEEDS_PUSH=false
# Use rev-list count for a reliable check if local has commits remote doesn't
# Run this check AFTER potential commit
UNPUSHED_COUNT=$(git rev-list --count "origin/$BRANCH"..@ 2>/dev/null || echo 0)

if [ "$UNPUSHED_COUNT" -gt 0 ]; then
    log_message "Local branch is ahead of remote by $UNPUSHED_COUNT commit(s)." "INFO"
    NEEDS_PUSH=true
elif [ "$NEW_COMMIT_MADE" = true ]; then
    # Fallback: If we just made a commit but count failed or showed 0 (should be rare), still try pushing.
     log_message "New commit was made in this run, attempting push (even if count is 0)." "WARN"
     NEEDS_PUSH=true
fi

# --- Push Changes with Retry (if needed) ---
if [ "$NEEDS_PUSH" = true ]; then
    log_message "Pushing changes to origin $BRANCH..." "INFO"
    push_attempt=1; push_succeeded=false; final_push_exit_code=0
    while [ $push_attempt -le $MAX_PUSH_ATTEMPTS ]; do
        log_message "Attempting push (try $push_attempt/$MAX_PUSH_ATTEMPTS)..." "DEBUG"
        push_output=$(git push origin "$BRANCH" 2>&1); push_exit_code=$?
        if [ $push_exit_code -eq 0 ]; then
            log_message "Push successful on attempt $push_attempt." "INFO"
            log_message "Push Output:\n${push_output}" "DEBUG"
            push_succeeded=true;
            break # Exit loop on success
        else
            final_push_exit_code=$push_exit_code # Store last failure code
            log_message "Push attempt $push_attempt failed (Exit Code: $push_exit_code)." "WARN"
            log_message "Push Output/Error:\n${push_output}" "WARN"

            if [ $push_attempt -eq $MAX_PUSH_ATTEMPTS ]; then
                log_message "Maximum push attempts reached." "ERROR";
                break # Exit loop after last attempt fails
            fi

            log_message "Retrying in $PUSH_RETRY_DELAY seconds..." "INFO"
            sleep $PUSH_RETRY_DELAY
            # Fetch before retrying
            log_message "Running git fetch before retry..." "DEBUG"
            if ! git fetch origin "$BRANCH"; then
                 log_message "Warning: git fetch before retry failed." "WARN"
                 # Could optionally 'break' here if fetch fails consistently
            fi
        fi
        push_attempt=$((push_attempt + 1))
    done

    if [ "$push_succeeded" = false ]; then
        # Call handle_error ONLY after all retries have failed
        local status_output=$(git status --short | sed 's/^/    /')
        handle_error "git push failed after $MAX_PUSH_ATTEMPTS attempts (Last Exit: $final_push_exit_code).\nGit status:\n${status_output}" 11
    fi
else
    log_message "No push needed (local branch not ahead or no new commits)." "INFO"
fi

# --- Upload Large Files to R2 (Cloudflare) ---
log_message "Starting upload of large files to Cloudflare R2..." "INFO"
R2_UPLOAD_SCRIPT="$REPO_DIR/script/git/upload_to_r2.py"

if [ -f "$R2_UPLOAD_SCRIPT" ]; then
    R2_UPLOAD_LOG="$REPO_DIR/script/logs/gitlogs/r2_upload.log"
    # Run the upload script and capture output
    python3 "$R2_UPLOAD_SCRIPT" >> "$R2_UPLOAD_LOG" 2>&1
    R2_EXIT_CODE=$?
    if [ $R2_EXIT_CODE -eq 0 ]; then
        log_message "R2 upload completed successfully. See $R2_UPLOAD_LOG for details." "INFO"
    else
        log_message "R2 upload encountered errors (exit code $R2_EXIT_CODE). Check $R2_UPLOAD_LOG for details." "ERROR"
    fi
else
    log_message "R2 upload script not found at $R2_UPLOAD_SCRIPT. Skipping R2 upload." "WARN"
fi

# --- Final Status ---
log_message "Final repository status:" "DEBUG"
# Log status only to file, not console (tee -a appends stdout, >/dev/null discards it from console)
git status --short | tee -a "$LOG_FILE" >/dev/null

log_message "======= Git synchronization script finished successfully =======" "INFO"
exit 0