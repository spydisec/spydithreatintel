from OTXv2 import OTXv2
import os

# Initialize OTX
otx = OTXv2(os.environ['OTX_API_KEY'])

# Define pulse ID for the existing pulse
pulse_id = '61bbe76bc405cbe23f3d5847'  # Using the provided Pulse ID
indicators = []

# Fetch the IPs from the specified file in the repository
with open('agr_unique_ips.txt', 'r') as file:
    for line in file:
        line = line.strip()
        if line:
            indicators.append({'indicator': line, 'type': 'IPv4'})

# Update the existing pulse
response = otx.replace_pulse_indicators(pulse_id, indicators)
print(response)
