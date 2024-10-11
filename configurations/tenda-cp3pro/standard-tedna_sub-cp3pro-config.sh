#!/bin/bash

source "./abstract-configs/abstract-ip-manipulation.sh"
source "./abstract-configs/abstract-ffplay-config.sh"

write_endpoints "./endpoints.txt" "1" "${ipadd_pattern}"

endpoints_out=("")

get_endpoints "./endpoints.txt" "${endpoints_out}"

ffplay_try_on_endpoints "${endpoints_out[*]}" "-fs" "tcp" "all" "video" "admin:admin123456" "554" "tenda_sub"