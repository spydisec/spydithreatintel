import os
from tqdm import tqdm

# Configuration
WHITELIST_DIR = 'whitelist'
BLOCKLIST_DIRS = {
    'malicious': 'domainlist/malicious/unique_malicious_domains.txt',
    'ads': 'domainlist/ads/unique_advtracking_domains.txt',
    'spam': 'domainlist/spam/unique_spamscamabuse_domains.txt'
    'permanentDomainList': 'permanent_DomainList.txt'
}

# Helper Functions
def normalize_domain(domain):
    """Normalize a domain by removing trailing dots and converting to lowercase."""
    return domain.rstrip('.').strip().lower()

def should_remove(domain, whitelisted_domains):
    """Check if a domain should be removed based on the whitelist."""
    normalized_domain = normalize_domain(domain)
    for wd in whitelisted_domains:
        if normalized_domain == wd or normalized_domain.endswith('.' + wd):
            return True
    return False

def filter_blocklist(blocklist_domains, whitelisted_domains, name):
    """Filter blocklist domains with a progress bar."""
    updated_blocklist = []
    for domain in tqdm(blocklist_domains, desc=f"Filtering {name} domains"):
        if not should_remove(domain, whitelisted_domains):
            updated_blocklist.append(domain)
    return updated_blocklist

# Main Function
def main():
    print("Starting blocklist update process...")

    # Load whitelisted domains
    if not os.path.exists(WHITELIST_DIR):
        print(f"Warning: Whitelist directory '{WHITELIST_DIR}' does not exist. Proceeding without whitelisting.")
        whitelisted_domains = set()
    else:
        whitelisted_domains = set()
        for file in os.listdir(WHITELIST_DIR):
            if file.endswith('.txt'):
                with open(os.path.join(WHITELIST_DIR, file), 'r') as f:
                    for line in f:
                        line = line.strip()
                        if line.startswith('(\.|^)') and line.endswith('$'):
                            domain = line[5:-1].replace('\\', '')
                            domain = normalize_domain(domain)
                            if '.' in domain and ' ' not in domain:
                                whitelisted_domains.add(domain)
                        else:
                            parts = line.split('#', 1)
                            domain = parts[0].strip()
                            domain = normalize_domain(domain)
                            if domain and '.' in domain and ' ' not in domain:
                                whitelisted_domains.add(domain)

    # Process each blocklist
    for name, path in BLOCKLIST_DIRS.items():
        if not os.path.exists(path):
            print(f"Warning: Blocklist file {path} does not exist. Skipping.")
            continue
        print(f"Processing {name} blocklist...")
        with open(path, 'r') as f:
            blocklist_domains = [line.strip() for line in f if line.strip()]
        updated_blocklist = filter_blocklist(blocklist_domains, whitelisted_domains, name)
        # Determine new file path
        directory = os.path.dirname(path)
        filename = os.path.basename(path)
        new_filename = filename.replace('unique_', '', 1)
        new_file_path = os.path.join(directory, new_filename)
        # Write updated blocklist
        with open(new_file_path, 'w') as f:
            for domain in updated_blocklist:
                f.write(domain + '\n')
        print(f"Updated {name} blocklist: {len(updated_blocklist)} domains remaining.")

    print("Blocklist update process completed successfully.")

if __name__ == '__main__':
    main()
