#!/bin/bash

source "./abstract-configs/abstract-ip-manipulation.sh"
source "./abstract-configs/abstract-ffplay-config.sh"

window_title=${1}
cam_mac=${2}

write_endpoints "./endpoints.txt" "1" "${ipadd_pattern}" "${cam_mac}"

endpoints_out=("")

get_endpoints "./endpoints.txt" "${endpoints_out}"

# remove logo and overlays
set_vf_crop "in_w/1.3" "in_h/1.3" 

# apply video filters
ffplay_try_on_endpoints "${endpoints_out[*]}" \
    "-fs" "${window_title}" "tcp" "all" "video" \
    "admin:admin123456" "554" "tenda" "$vf_specifier $vf_roi,$vf_crop"