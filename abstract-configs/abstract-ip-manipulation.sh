#!/bin/bash 

# grep is a command used to search for patterns in text.
# -o means "only show the part of the line that matches the pattern."
# -E enables extended regular expressions, which are more powerful than basic ones.
# The pattern '([0-9]{1,3}\.){3}[0-9]{1,3}' is a regular expression (regex) that matches IP addresses.

# Here’s how that pattern works:

# [0-9]{1,3}: This part matches numbers that are one to three digits long (for example, numbers between zero and nine hundred ninety-nine).
# \.: This matches a literal dot . between the number blocks in an IP address.
# {3}: This means the previous pattern (the number and dot) repeats three times. So, it matches three groups of numbers followed by dots.
# [0-9]{1,3}: Finally, it matches the last block of numbers without a dot.
# The overall pattern matches something like this: 192.168.0.1.

ipadd_pattern="([0-9]{1,3}\.){3}[0-9]{1,3}"
# macadd_pattern="([0-9][A-Z]{1,2}\:){5}[0-9][A-Z]{1,2}"

function setup_bettercap() {
    sudo apt install build-essential libpcap-dev libusb-1.0-0-dev libnetfilter-queue-dev
    sudp apt update
    sudo apt install bettercap
}

function write_endpoints() {
    endpoints_filepath=${1}
    seconds=${2}
    pattern=${3}
    cam_mac=${4}

    sudo bettercap -eval "events.stream off; \
                         net.probe on;sleep ${seconds}; \
                         set net.show.filter ${cam_mac};net.show; \
                         quit" > "${endpoints_filepath}-bettercap"

    cat "${endpoints_filepath}-bettercap" | grep -oE "${pattern}" > "${endpoints_filepath}"
}

function get_endpoints() {
    endpoints_filepath=${1}
    endpoints_out=${2}

    # Read endpoints into an array
    mapfile -t endpoints_out < "${endpoints_filepath}"
}