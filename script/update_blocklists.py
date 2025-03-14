import os

# Configuration
WHITELIST_DIR = 'whitelist'
BLOCKLIST_FILES = {
    'malicious': 'domainlist/malicious/unique_malicious_domains.txt',
    'ads': 'domainlist/ads/unique_advtracking_domains.txt',
    'spam': 'domainlist/spam/unique_spamscamabuse_domains.txt'
}

# Helper Functions
def normalize_domain(domain):
    """Normalize a domain by removing trailing dots, whitespace, and converting to lowercase."""
    return domain.rstrip('.').strip().lower()

def should_remove(domain, whitelisted_domains):
    """
    Determine if a domain should be removed based on whitelist.
    Returns True if the domain matches a whitelisted domain or is a subdomain thereof.
    """
    normalized_domain = normalize_domain(domain)
    for wd in whitelisted_domains:
        if normalized_domain == wd or normalized_domain.endswith('.' + wd):
            return True
    return False

def check_path(path, is_dir=False):
    """
    Check if a path exists and is of the expected type (directory or file).
    Exits with an error message if the check fails.
    """
    if not os.path.exists(path):
        print(f"Error: {'Directory' if is_dir else 'File'} '{path}' does not exist in {os.getcwd()}.")
        exit(1)
    if is_dir and not os.path.isdir(path):
        print(f"Error: '{path}' is not a directory.")
        exit(1)
    if not is_dir and not os.path.isfile(path):
        print(f"Error: '{path}' is not a file.")
        exit(1)

def main():
    # Verify whitelist directory exists
    check_path(WHITELIST_DIR, is_dir=True)

    # Verify blocklist files exist
    for name, blocklist_file in BLOCKLIST_FILES.items():
        check_path(blocklist_file)

    # Initialize set for whitelisted domains
    whitelisted_domains = set()

    # Read whitelisted domains from all .txt files in WHITELIST_DIR
    for file in os.listdir(WHITELIST_DIR):
        if file.endswith('.txt'):
            file_path = os.path.join(WHITELIST_DIR, file)
            with open(file_path, 'r') as f:
                for line in f:
                    line = line.strip()
                    if line.startswith('(\.|^)') and line.endswith('$'):
                        # Handle regex-style entries like '(\.|^)example\.com$'
                        domain = line[5:-1].replace('\\', '')
                        domain = normalize_domain(domain)
                        if '.' in domain and ' ' not in domain:
                            whitelisted_domains.add(domain)
                    else:
                        # Handle plain domains, ignoring comments
                        parts = line.split('#', 1)
                        domain = parts[0].strip()
                        domain = normalize_domain(domain)
                        if domain and '.' in domain and ' ' not in domain:
                            whitelisted_domains.add(domain)

    # Process each blocklist file
    for name, path in BLOCKLIST_FILES.items():
        # Read blocklist domains
        with open(path, 'r') as f:
            blocklist_domains = [line.strip() for line in f if line.strip()]
        
        # Filter out whitelisted domains and their subdomains
        updated_blocklist = [
            domain for domain in blocklist_domains
            if not should_remove(domain, whitelisted_domains)
        ]
        
        # Determine output file path by removing 'unique_' prefix
        directory = os.path.dirname(path)
        filename = os.path.basename(path)
        new_filename = filename.replace('unique_', '', 1)
        new_file_path = os.path.join(directory, new_filename)
        
        # Write updated blocklist to new file
        with open(new_file_path, 'w') as f:
            for domain in updated_blocklist:
                f.write(domain + '\n')

if __name__ == '__main__':
    main()
