#!/bin/bash

function ffplay_play_stream() {
    screen=${1}
    transport_protocol=${2}
    allowed_media=${3}
    sync_type=${4}
    credentials=${5}
    endpoint=${6}
    streaming_port=${7}
    streaming_component=${8}
    # e.g.: for the tenda C3Pro camera
    # ffplay -rtsp_transport tcp -allowed_media_types all -sync video rtsp://admin:admin123456@${endpoint}:554/tenda
    # use this command. 
    # 
    ffplay $screen -rtsp_transport ${transport_protocol} \
           -allowed_media_types ${allowed_media} \
           -sync ${sync_type} -fast \
            rtsp://${credentials}@${endpoint}:${streaming_port}/${streaming_component}
}

function ffplay_try_on_endpoints() {
    endpoints_in=(${1})
    screen=${2}
    transport_protocol=${3}
    allowed_media=${4}
    sync_type=${5}
    credentials=${6}
    streaming_port=${7}
    streaming_component=${8}

    for endpoint in "${endpoints_in[@]}"; do
        ffplay_play_stream "${screen}" "${transport_protocol}" \
                           "${allowed_media}" "${sync_type}" \
                           "${credentials}" "${endpoint}" "${streaming_port}" "${streaming_component}" 
    done
}
