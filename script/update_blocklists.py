#!/usr/bin/env python3
import os
import sys
import logging
from datetime import datetime

try:
    from tqdm import tqdm
except ImportError:
    print('tqdm module not found. Please install it with pip install tqdm')
    sys.exit(1)

try:
    import yaml
except ImportError:
    yaml = None

def load_config(config_path='config.yaml'):
    # Load configuration from config.yaml if available, else use defaults
    config = {}
    if yaml and os.path.exists(config_path):
        try:
            with open(config_path, 'r') as f:
                config = yaml.safe_load(f)
        except Exception as e:
            print(f'Error parsing {config_path}: {e}')
            sys.exit(1)

    default_config = {
        'base_dir': '/home/spydisec/spydiblocklist',
        'script_dir': '/home/spydisec/spydiblocklist/script',
        'whitelist_dir': '/home/spydisec/spydiblocklist/whitelist',
        'domainlists': {
            'unique_malicious': '/home/spydisec/spydiblocklist/domainlist/malicious/unique_malicious_domains.txt',
            'unique_ads': '/home/spydisec/spydiblocklist/domainlist/ads/unique_advtracking_domains.txt',
            'unique_spam': '/home/spydisec/spydiblocklist/domainlist/spam/unique_spamscamabuse_domains.txt',
            'permanent': '/home/spydisec/spydiblocklist/permanent_DomainList.txt'
        }
    }

    for key, value in default_config.items():
        if key not in config:
            config[key] = value
    if 'domainlists' not in config or not config['domainlists']:
        config['domainlists'] = default_config['domainlists']

    return config

CONFIG = load_config()

LOG_FILE = os.path.join(CONFIG['script_dir'], 'update_blocklists.log')
import os
os.makedirs(os.path.dirname(LOG_FILE), exist_ok=True)
import logging
logging.basicConfig(filename=LOG_FILE,
                    format='%(asctime)s - %(levelname)s - %(message)s',
                    level=logging.INFO)
logger = logging.getLogger()

def update_permanent_domain_list():
    logger.info('=== Starting Permanent Domain List Update ===')
    source = CONFIG['domainlists']['unique_malicious']
    dest = CONFIG['domainlists']['permanent']

    if not os.path.isfile(source):
        logger.error(f'Source file {source} not found')
        return 1

    try:
        with open(source, 'r') as f:
            new_domains = {line.strip() for line in f if line.strip()}

        if not new_domains:
            logger.info('No new domains to process')
            return 0

        date_header = f"#{datetime.today().strftime('%Y-%m-%d')}"
        existing = []
        seen_domains = set()

        if os.path.exists(dest):
            with open(dest, 'r') as f:
                for line in f:
                    line = line.strip()
                    if line.startswith('#'):
                        existing.append(line)
                    elif line and line not in seen_domains:
                        seen_domains.add(line)
                        existing.append(line)

        existing.append(date_header)
        added_count = 0
        for domain in new_domains:
            if domain not in seen_domains:
                seen_domains.add(domain)
                existing.append(domain)
                added_count += 1

        with open(dest, 'w') as f:
            f.write('\n'.join(existing) + '\n')

        logger.info(f'Added {added_count} new domains to permanent domain list. Total domains: {len(seen_domains)}')
        logger.info('=== Permanent Domain List Update Completed Successfully ===')
        return 0
    except Exception as e:
        logger.exception('Critical error during permanent domain list update')
        return 1

def normalize_domain(domain):
    return domain.rstrip('.').strip().lower()

def load_whitelist(whitelist_dir=None):
    if whitelist_dir is None:
        whitelist_dir = CONFIG['whitelist_dir']
    whitelisted = set()
    if not os.path.exists(whitelist_dir):
        logger.warning(f"Whitelist directory '{whitelist_dir}' does not exist. Proceeding without whitelisting.")
        return whitelisted

    for file in os.listdir(whitelist_dir):
        if file.endswith('.txt'):
            try:
                with open(os.path.join(whitelist_dir, file), 'r') as f:
                    for line in f:
                        line = line.strip()
                        if line:
                            if line.startswith('(\\.|^)') and line.endswith('$'):
                                domain = line[5:-1].replace('\\', '')
                                domain = normalize_domain(domain)
                                if '.' in domain and ' ' not in domain:
                                    whitelisted.add(domain)
                            else:
                                parts = line.split('#', 1)
                                domain = parts[0].strip()
                                domain = normalize_domain(domain)
                                if domain and '.' in domain and ' ' not in domain:
                                    whitelisted.add(domain)
            except Exception as e:
                logger.exception(f'Error reading whitelist file {file}')
    return whitelisted

def should_remove(domain, whitelisted):
    norm = normalize_domain(domain)
    for wd in whitelisted:
        if norm == wd or norm.endswith('.' + wd):
            return True
    return False

def filter_blocklist(domains, whitelisted, name):
    filtered = []
    for domain in tqdm(domains, desc=f'Filtering {name} domains'):
        if not should_remove(domain, whitelisted):
            filtered.append(domain)
    return filtered

def filter_all_blocklists():
    logger.info('=== Starting Blocklist Filtering Process ===')
    whitelisted = load_whitelist()

    blocklists = {
        'malicious': (
            CONFIG['domainlists']['unique_malicious'], 
            os.path.join(os.path.dirname(CONFIG['domainlists']['unique_malicious']), 'malicious_domains.txt')
        ),
        'ads': (
            CONFIG['domainlists']['unique_ads'], 
            os.path.join(os.path.dirname(CONFIG['domainlists']['unique_ads']), 'advtracking_domains.txt')
        ),
        'spam': (
            CONFIG['domainlists']['unique_spam'], 
            os.path.join(os.path.dirname(CONFIG['domainlists']['unique_spam']), 'spamscamabuse_domains.txt')
        ),
        'permanent': (
            CONFIG['domainlists']['permanent'], 
            CONFIG['domainlists']['permanent']
        )
    }

    for name, (infile, outfile) in blocklists.items():
        if not os.path.exists(infile):
            logger.warning(f'Blocklist file {infile} does not exist. Skipping {name}.')
            continue

        logger.info(f'Processing {name} blocklist from {infile}.')
        try:
            with open(infile, 'r') as f:
                domains = [line.strip() for line in f if line.strip()]
            updated = filter_blocklist(domains, whitelisted, name)
            with open(outfile, 'w') as f:
                for d in updated:
                    f.write(d + '\n')
            logger.info(f'Filtered {name} blocklist: {len(updated)} domains written to {outfile}.')
        except Exception as e:
            logger.exception(f'Error processing blocklist {name}.')

    logger.info('=== Blocklist Filtering Process Completed ===')
    return 0

def main():
    logger.info('=== Starting Consolidated Domain List Update & Blocklist Filtering ===')

    ret1 = update_permanent_domain_list()
    ret2 = filter_all_blocklists()

    if ret1 == 0 and ret2 == 0:
        logger.info('=== Consolidated process completed successfully ===')
    else:
        logger.error('=== Consolidated process encountered errors ===')

    return 0 if (ret1==0 and ret2==0) else 1

if __name__ == '__main__':
    sys.exit(main())
import os
from tqdm import tqdm

# Configuration
WHITELIST_DIR = 'whitelist'
BLOCKLIST_DIRS = {
    'malicious': 'domainlist/malicious/unique_malicious_domains.txt',
    'ads': 'domainlist/ads/unique_advtracking_domains.txt',
    'spam': 'domainlist/spam/unique_spamscamabuse_domains.txt',
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
