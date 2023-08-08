# Cyber and Fraud Centre Scotland - Testing Laptop / Testing VM Playbook

This ansible playbook was created with the original purpose of reworking the
Testing Laptop used by Cyber and Fraud Centre Scotland. However, it has now became
a streamlined way for the hackers to spin up a completely fresh Kali Linux VM for
each engagement, ensuring that there are no overlaps in data between tests and clients.

## Table of Contents

1. [Prerequisites](#prerequisites)
1. [Usage](#usage)

## Prerequisites

The only requirement to use this playbook is the ansible-core package, this contains
everything needed by ansible to successfully execute the playbook. The following
command can be used to download the package.

```bash
sudo apt update -y && sudo apt update -y && \ 
sudo apt install ansible-core -y
```

## Usage

### Creating a new Kali Virtual Machine

The first step in using this playbook is creating a fresh Kali virtual machine.
An ISO file for Kali can be downloaded from [here](https://www.kali.org/get-kali/#kali-installer-images)
and installation guidance can be found [here](https://www.kali.org/docs/installation/hard-disk-install/).
