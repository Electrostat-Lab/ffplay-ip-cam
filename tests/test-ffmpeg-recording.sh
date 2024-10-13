#!/bin/bash

source "./abstract-configs/abstract-ip-manipulation.sh"
source "./abstract-configs/abstract-ffplay-config.sh"

credentials="${1}"
streaming_port="${2}"
streaming_component="${3}"
cam_mac="${4}"

write_endpoints "./endpoints.txt" "1" "${ipadd_pattern}" "${cam_mac}"

endpoints_out=("")

get_endpoints "./endpoints.txt" "${endpoints_out}"

# remove logo and overlays
set_vf_crop "in_w/1.3" "in_h/1.3" 

ffmpeg_try_on_endpoints "${endpoints_out[*]}" "" "10" "tcp" \
                "${credentials}" "${streaming_port}" "${streaming_component}" "./test.mp4" "$vf_specifier $vf_roi,$vf_crop"