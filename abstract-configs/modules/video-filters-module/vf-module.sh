#!/bin/bash

# mutable attributes
vf_crop="-vf crop=w=in_w:h=in_h"
vf_color=""
vf_saturation=""
vf_background=""
vf_brightness=""
vf_buffersink=""
vf_roi="-vf addroi=iw/4:iw/4:iw/2:ih/2:-1"

# mutating the attributes' states!
function set_vf_roi() {
    x_roi="${1}"
    y_roi="${2}"
    w_roi="${3}"
    h_roi="${4}"
    qoffset="${5}"

    vf_roi="-vf addroi=$x_roi:$y_roi:$w_roi:$h_roi:$qoffset"

}

function set_vf_crop() {
    crop_w="${1}"
    crop_h="${2}"

    vf_crop="-vf crop=w=$crop_w:h=$crop_h"
}