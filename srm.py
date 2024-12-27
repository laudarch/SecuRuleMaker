#!/usr/bin/env python3
# coder: laudarch
# copyright: Tactical Intelligence Security (https://taise.tech)
# license: OpenBSD

import argparse
import sys

"""
Generate rules function
"""
def generate_rules(cidr_list, action, firewall_type):
    rules = []
    for cidr in cidr_list:
        if firewall_type == 'iptables':
            if action == 'allow':
                rules.append(f'iptables -A INPUT -s {cidr} -j ACCEPT')
            elif action == 'block':
                rules.append(f'iptables -A INPUT -s {cidr} -j DROP')
            else:
                raise ValueError("Action must be 'allow' or 'block'")
        elif firewall_type == 'ipfw':
            if action == 'allow':
                rules.append(f'ipfw add allow ip from {cidr} to any')
            elif action == 'block':
                rules.append(f'ipfw add deny ip from {cidr} to any')
        elif firewall_type == 'ipchains':
            if action == 'allow':
                rules.append(f'ipchains -A input -s {cidr} -j ACCEPT')
            elif action == 'block':
                rules.append(f'ipchains -A input -s {cidr} -j DENY')
        elif firewall_type == 'pf':
            if action == 'allow':
                rules.append(f'pass in from {cidr}')
            elif action == 'block':
                rules.append(f'block in from {cidr}')
        elif firewall_type == 'ACL':
            if action == 'allow':
                rules.append(f'permit {cidr} any')
            elif action == 'block':
                rules.append(f'deny {cidr} any')
        else:
            raise ValueError("Unsupported firewall type. Use 'iptables', 'ipfw', 'ipchains', 'pf', or 'ACL'.")
 
    return rules

"""
Main function
"""
def main():
    parser = argparse.ArgumentParser(description='Generate firewall rules from CIDR list.')
    parser.add_argument('input_file', help='File containing CIDR addresses, one per line.')
    parser.add_argument('action', choices=['allow', 'block'], help='Action to perform (allow/block).')
    parser.add_argument('firewall', choices=['iptables', 'ipfw', 'ipchains', 'pf', 'ACL'], help='Type of firewall to generate rules for.')
    parser.add_argument('--output', help='Output file to write rules to. If not specified, output will be printed to stdout.')

    args = parser.parse_args()

    try:
        with open(args.input_file, 'r') as file:
            cidr_list = [line.strip() for line in file if line.strip()]
 
        rules = generate_rules(cidr_list, args.action, args.firewall)

        if args.output:
            with open(args.output, 'w') as output_file:
                for rule in rules:
                    output_file.write(rule + '\n')
            print(f"Rules written to {args.output}")
        else:
            for rule in rules:
                print(rule)

    except FileNotFoundError:
        print(f"Error: The file {args.input_file} was not found.")
        sys.exit(1)
    except ValueError as e:
        print(f"Error: {e}")
        sys.exit(1)

"""
entrypoint
"""
if __name__ == "__main__":
    main()

