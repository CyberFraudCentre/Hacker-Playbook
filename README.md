# Cyber and Fraud Centre Scotland - Testing Laptop / Testing VM Playbook

This Ansible playbook was created with the original purpose of reworking the
Testing Laptop used by Cyber and Fraud Centre Scotland. However, it has now
became a streamlined way for the hackers to spin up a completely fresh Kali
Linux virtual machine for each engagement, ensuring a clean slate is used for
each client.

## Table of Contents

1. [Prerequisites](#prerequisites)
1. [Usage](#usage)
1. [Troubleshooting](#troubleshooting)

## Prerequisites

### Kali Linux Virtual Machine

Before anything else can be done a Kali virtual machine must be installed. To
do this, first download the Kali ISO file from [here](https://www.kali.org/get-kali/#kali-installer-images).

Once installed, create a virtual machine following the guidance for your
preferred platform, e.g [VMware](https://www.kali.org/docs/virtualization/install-vmware-guest-vm/) or [VirtualBox](https://www.kali.org/docs/virtualization/install-virtualbox-guest-vm/)
Once a virtual machine has been created start the VM and follow the
installation guide [here](https://www.kali.org/docs/installation/hard-disk-install/).

### Packages

With a fully installed Kali VM the only requirement left to use the playbook is
the ansible-core package, this contains everything needed for a successful
operation of the playbook. Using the following command will download the
package (alongside updating the package cache and installing any updates).

```bash
sudo apt update -y && sudo apt upgrade -y && \ 
sudo apt install ansible-core -y
```

## Usage

### Obtaining the Playbook

Once Kali is installed the next step is to clone the GitHub repository
containing the playbook. To do this open a terminal and type the following.

```bash
git clone https://github.com/CyberFraudCentre/Hacker-Playbook.git
```

### Running the Playbook

To then install the playbook change into the newly created directory for the
repo (`cd Hacker-Playbook`) and run the following command, entering the
password for your user account when prompted.

```bash
ansible-playbook main.yml -K
```

The playbook will then install the extra tools used by Cyber and Fraud Centre
hackers alongside making a few QOL changes to software configurations such as
burpsuite and firefox.

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

#### Replacing the Broken Link in the Playbook

There are 2 places in the playbook where the link to download nessus is present,
all three of these are found in the `roles/install_tools/tasks/main.yml` file.

1. Check if nessus download link is dead or alive
1. Download Nessus .deb

To retrieve the new, functioning url follow the link to the download page in
the [Manual Install](#manual-install) section. Remember to change the platform
before proceeding further. Instead of manually downloading the deb file, open
the "Download with curl" link and copy the url used; this will be used to
replace the broken link. On the same page the sha256 checksum can be found, this
is needed to replace the old checksum in the second task.

_For help on submitting changes see the [Submitting Fixes / New Additions](#submitting-fixes--new-additions) section_

## Submitting Fixes / New Additions

To make have your changes merged with the contents of the repository a pull
request should be made. Before submitting a pull request there are 4 key steps
to be performed.

1. Fork the repository
1. Clone the repository
1. Create a new branch
1. Make necessary changes

After these steps are complete a pull request can be submitted (a pull request
is the process of requesting the repository owner to pull your changes into
their repository).

### Forking and Cloning the Repository

Before any other steps can be done, it is first required to make a fork of the
[main repository](https://github.com/CyberFraudCentre/Hacker-Playbook.git).
This is a required step as _most_ users will not have access to create new
branches on the main repository.

Cloning the repository was covered in the [Usage](#obtaining-the-playbook) section, However
the link should be changed to `https://github.com/[username]/Hacker-Playbook`.
Forking the repository means that you have a copy of the repo connected to your
account and can do as you wish to it (in this case create a new branch and make
changes).

Finally the main repository must be set as an upstream remote of your fork.
`git remote add --track master upstream https://github.com/CyberFraudCentre/Hacker-Playbook`

__It is good practice to first synchronise your fork with the main repo__
First, pull remote changes to local upstream `git fetch upstream`. Second,
merge changes to local main branch `git merge upstream/main`.

### Creating a New Branch and Making Changes

A new branch must be created and switched to. Creating a new __local__ branch
can be done with the command `git branch [branch-name]` which can then be
switched to using `git checkout branch-name` (these two steps can be done in a
single command - `git checkout -b branch-name`).

Changes can be committed locally with `git commit [path-to-file]` (to commit
only a specific portion of the changes made to a file, use `git commit -p [path-to-file]`).

### Creating pull request

There are two main ways to create a pull request, via the [GitHub CLI](https://cli.github.com/) or the
GitHub Website. Guides for using both methods can be found [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).

It is important when writing a pull request to include a helpful title
(titles such as "Pull Request #3" or "My changes" are not this) and a brief yet
comprehensive description.

__Remember, pull requests are subject to review by the repository owner before
being merged. They are not a guarantee that the changes will be merged__
