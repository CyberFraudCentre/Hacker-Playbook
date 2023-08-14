# Cyber and Fraud Centre Scotland - Testing Laptop / Testing VM Playbook

This ansible playbook was created with the original purpose of reworking the
Testing Laptop used by Cyber and Fraud Centre Scotland. However, it has now became
a streamlined way for the hackers to spin up a completely fresh Kali Linux virtual
machine for each engagement, ensuring that there are no overlaps in data between
tests and clients.

## Table of Contents

1. [Prerequisites](#prerequisites)
1. [Usage](#usage)
1. [Troubleshooting](#troubleshooting)

## Prerequisites

### Kali Linux Virtual Machine

Before anything else can be done a Kali virtual machine must be installed. To do
this, first download the Kali ISO file from [here](https://www.kali.org/get-kali/#kali-installer-images).

Once installed, create a virtual machine following the guidance for your preferred
platform, e.g [VMware](https://www.kali.org/docs/virtualization/install-vmware-guest-vm/) or [VirtualBox](https://www.kali.org/docs/virtualization/install-virtualbox-guest-vm/)
Once a virtual machine has been created start the VM and follow the installation
guide [here](https://www.kali.org/docs/installation/hard-disk-install/).

### Packages

With a fully installed Kali VM the only requirement left to use the playbook is
the ansible-core package, this contains everything needed for a successful operation
of the playbook. Using the following command will download the package (alongside
updating the package cache and installing any updates).

```bash
sudo apt update -y && sudo apt upgrade -y && \ 
sudo apt install ansible-core -y
```

## Usage

### Obtaining the Playbook

Once Kali is installed the next step is to clone the GitHub repository containing
the playbook. To do this open a terminal and type the following.

```bash
git clone https://github.com/CyberFraudCentre/Hacker-Playbook.git
```

### Running the Playbook

To then install the playbook change into the newly created directory for the repo
(`cd Hacker-Playbook`) and run the following command, entering the password for
your user account when prompted.

```bash
ansible-playbook main.yml -K
```

The playbook will then install the extra tools used by Cyber and Fraud Centre hackers
alongside making a few QOL changes to software configurations such as burpsuite
and firefox.

### Installed/Modified software

#### Modified

- BurpSuite
- Firefox

#### Installed

- Vulnerability Assessment Script (Adam Board)
- dmitry
- wpscan
- whatweb
- nuclei
- o-saft
- tlssled
- uniscan
- wig
- wafw00f
- feroxbuster
- xclip
- tldr
- wireguard-tools
- virtualenvwrapper
- algo
- resolvconf
- python3-virtualenv
- jruby
- jython
- nessus

## Troubleshooting

This section discusses potential issues that occur when running the playbook
(on Kali Linux), any issues that occur from steps relating to installation of
Kali Linux or installation of other prerequisites will not be covered.

### Nessus Fails to Download / Install

There is a check in place to see if the API location (from which the nessus
.deb file is downloaded from). When a new version of nessus is released the
prior endpoint is removed causing the script to fail the download / install
process.

__If this message is shown during the script execution the download link is down__
```bash
TASK [install_tools : Check if nessus download link is dead or alive] *******
***
fatal: [localhost]: FAILED! => {"censored": "the output has been hidden due t
o the fact that 'no_log: true' was specified for this result", "changed": fal
se}
 ... ignoring
```

#### Manual install

Go to the [downloads section](https://www.tenable.com/downloads/nessus) for nessus on the tenable website and select the
platform Linux-Debian-amd64. Click the download button and accept the License
Agreement, after the file has downloaded compare the sha256 checksum of the
downloaded file to the one shown on the website.

```bash
sha256sum /path/to/Nessus-x.x.x-debian10_amd64.deb # checksum

sudo apt insall -f /path/to/Nessus-x.x.x-debian10_amd64.deb # install nessus deb
```
