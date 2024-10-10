#!/bin/bash

source "./abstract-configs/abstract-ip-manipulation.sh"
source "./abstract-configs/abstract-ffplay-config.sh"

credentials="${1}"
streaming_port="${2}"
streaming_component="${3}"

write_endpoints "./endpoints.txt" "1" "${ipadd_pattern}"

endpoints_out=("")

get_endpoints "./endpoints.txt" "${endpoints_out}"

ffplay_try_on_endpoints "${endpoints_out[*]}" "-fs" "tcp" "all" "video" \
                "${credentials}" "${streaming_port}" "${streaming_component}"