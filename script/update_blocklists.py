import os

def normalize_domain(domain):
    return domain.rstrip('.').strip()

def is_valid_domain(domain):
    return '.' in domain and ' ' not in domain

def is_subdomain(domain, whitelisted):
    return domain == whitelisted or domain.endswith('.' + whitelisted)

def main():
    whitespace_dir = 'whitespace'
    blocklist_dirs = {
        'malicious': 'domainlist/malicious/unique_malicious_domains.txt',
        'ads': 'domainlist/ads/unique_advtracking_domains.txt',
        'spam': 'domainlist/spam/unique_spamscamabuse_domains.txt'
    }

    whitelisted_domains = set()

    # Read whitelisted domains
    for file in os.listdir(whitespace_dir):
        if file.endswith('.txt'):
            with open(os.path.join(whitespace_dir, file), 'r') as f:
                for line in f:
                    line = line.strip()
                    if line.startswith('(\.|^)') and line.endswith('$'):
                        domain = line[5:-1].replace('\\', '')
                        domain = normalize_domain(domain)
                        if is_valid_domain(domain):
                            whitelisted_domains.add(domain)
                    else:
                        parts = line.split('#', 1)
                        domain = parts[0].strip()
                        domain = normalize_domain(domain)
                        if domain:
                            whitelisted_domains.add(domain)

    # Process each blocklist file
    for name, path in blocklist_dirs.items():
        with open(path, 'r') as f:
            blocklist_domains = [normalize_domain(line.strip()) for line in f if line.strip()]
        updated_blocklist = []
        for domain in blocklist_domains:
            if not any(is_subdomain(domain, wd) for wd in whitelisted_domains):
                updated_blocklist.append(domain)
        # Write to new file
        new_file_path = path.replace('unique_', 'updated_unique_')
        with open(new_file_path, 'w') as f:
            for domain in updated_blocklist:
                f.write(domain + '\n')

if __name__ == '__main__':
    main()
