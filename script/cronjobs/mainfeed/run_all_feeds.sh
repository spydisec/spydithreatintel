#!/bin/bash
# run_all_feeds.sh - Main orchestrator for Domain + IP + Confidence pipelines
# Health Check: Daily Domain & IP List Update (eaf3923a-15fb-4919-ad73-3b08c74fbc07)

set -o pipefail

# --- Configuration ---
BASE_DIR="/home/spydisec/spydiblocklist"
LOG_DIR="$BASE_DIR/script/logs/cron"
LOG_FILE="$LOG_DIR/run_all_feeds.log"
HEALTH_CHECK_URL="https://hc-ping.com/eaf3923a-15fb-4919-ad73-3b08c74fbc07"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# --- Logging Setup ---
exec > >(tee -a "$LOG_FILE") 2>&1

# --- Health Check Function ---
report_health() {
    local status_suffix=$1
    local full_url="${HEALTH_CHECK_URL}${status_suffix}"
    
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Sending health check to: ${full_url}"
    
    if curl -fsS -m 10 --retry 5 -o /dev/null "$full_url"; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Health check sent successfully"
    else
        local curl_exit_code=$?
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Failed to send health check (curl exit code: $curl_exit_code)"
        return 1
    fi
    return 0
}

# --- Main Execution ---
RUN_START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo "######################################################################"
echo "### START RUN: run_all_feeds.sh @ ${RUN_START_TIME}"
echo "######################################################################"

TOTAL_EXIT_CODE=0

# --- Step 0: Pull latest changes (picks up GitHub Actions commits, e.g., community whitelist entries) ---
echo ""
echo "$(date '+%Y-%m-%d %H:%M:%S') - [0/3] Pulling latest changes from GitHub..."
cd "$BASE_DIR" && git pull --rebase --autostash origin main 2>&1 || {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [0/3] WARNING: git pull failed (non-fatal, continuing with local state)"
}

# --- Step 1: Domain Feed Pipeline ---
echo ""
echo "$(date '+%Y-%m-%d %H:%M:%S') - [1/3] Running Domain Feed Pipeline..."
/bin/bash "$BASE_DIR/script/domain_blocklist/orchestration/main_domain_pipeline.sh"
DOMAIN_EXIT=$?
TOTAL_EXIT_CODE=$((TOTAL_EXIT_CODE + DOMAIN_EXIT))

if [ $DOMAIN_EXIT -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [1/3] Domain pipeline completed successfully"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [1/3] Domain pipeline failed with exit code: $DOMAIN_EXIT"
fi

# --- Step 2: IP Feed Pipeline ---
echo ""
echo "$(date '+%Y-%m-%d %H:%M:%S') - [2/3] Running IP Feed Pipeline..."
/bin/bash "$BASE_DIR/script/ip_blocklist/orchestration/main_ip_pipeline.sh"
IP_EXIT=$?
TOTAL_EXIT_CODE=$((TOTAL_EXIT_CODE + IP_EXIT))

if [ $IP_EXIT -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [2/3] IP pipeline completed successfully"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [2/3] IP pipeline failed with exit code: $IP_EXIT"
fi

# --- Step 3: Confidence-Based IP Aggregation ---
echo ""
echo "$(date '+%Y-%m-%d %H:%M:%S') - [3/3] Running Confidence-Based IP Aggregation..."
/bin/bash "$BASE_DIR/script/ip_blocklist/orchestration/run_confidence_aggregation.sh"
CONFIDENCE_EXIT=$?
TOTAL_EXIT_CODE=$((TOTAL_EXIT_CODE + CONFIDENCE_EXIT))

if [ $CONFIDENCE_EXIT -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [3/3] Confidence aggregation completed successfully"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [3/3] Confidence aggregation failed with exit code: $CONFIDENCE_EXIT"
fi

# --- Final Status and Health Check ---
echo ""
echo "========================================================================"
echo "Pipeline Summary:"
echo "  Domain Pipeline:          Exit Code $DOMAIN_EXIT"
echo "  IP Pipeline:              Exit Code $IP_EXIT"
echo "  Confidence Aggregation:   Exit Code $CONFIDENCE_EXIT"
echo "  Total Exit Code:          $TOTAL_EXIT_CODE"
echo "========================================================================"

if [ $TOTAL_EXIT_CODE -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - All pipelines completed successfully"
    report_health ""
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - One or more pipelines failed"
    report_health "/fail"
fi

RUN_END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo ""
echo "######################################################################"
echo "### END RUN: run_all_feeds.sh @ ${RUN_END_TIME}"
echo "### Final Exit Code: $TOTAL_EXIT_CODE"
echo "######################################################################"
echo ""

exit $TOTAL_EXIT_CODE