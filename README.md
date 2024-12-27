# Firewall Rule Generator

## Overview

The Firewall Rule Generator is a Python script designed to automate the creation of firewall rules for various firewall types, including `iptables`, `ipfw`, `ipchains`, `pf`, and Access Control Lists (ACL). This tool simplifies the process of managing network security by allowing users to generate rules based on CIDR (Classless Inter-Domain Routing) addresses.

## Features

- Supports multiple firewall types:
  - `iptables`
  - `ipfw`
  - `ipchains`
  - `pf`
  - ACL
- Allows users to specify whether to allow or block traffic from specified CIDR addresses.
- Outputs rules to the console or writes them to a specified file.

## Requirements

- Python 3.x
- Basic understanding of firewall concepts and CIDR notation.

## Installation

1. Clone the repository or download the script:

   ```bash
   git clone https://github.com/laudarch/SecuRuleMaker.git
   cd SecuRuleMaker.
   ./download_zones.sh gh
   ./srm.py --output pf.conf zones/gh.zone block pf
   ```
   
