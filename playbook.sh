#! /bin/bash

# If there is no command option supplied run normally
if [ -z "$1" ]; then
	ansible-playbook main.yml --ask-become-pass
# if debug is supplied (as upper or lowercase) enable debug mode
elif [[ $(echo "$1" | awk '{print tolower($0)}') = "debug" ]]; then
	ANSIBLE_DEBUG=true ansible-playbook main.yml --ask-become-pass
fi
