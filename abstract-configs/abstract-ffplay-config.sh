#!/bin/bash

source "./abstract-configs/modules/video-filters-module/vf-module.sh"
source "./abstract-configs/modules/audio-filters-module/af-module.sh"

function ffplay_play_stream() {
    screen=${1}
    window_title=${2}
    transport_protocol=${3}
    allowed_media=${4}
    sync_type=${5}
    credentials=${6}
    endpoint=${7}
    streaming_port=${8}
    streaming_component=${9}
    av_filters=${10}
    # e.g.: for the tenda C3Pro camera
    # ffplay -rtsp_transport tcp -allowed_media_types all -sync video rtsp://admin:admin123456@${endpoint}:554/tenda
    # use this command. 
    # 
    ffplay $screen -window_title ${window_title} -rtsp_transport ${transport_protocol} \
           -allowed_media_types ${allowed_media} \
           -sync ${sync_type} -fast ${av_filters} \
            rtsp://${credentials}@${endpoint}:${streaming_port}/${streaming_component} 
}

function ffplay_try_on_endpoints() {
    endpoints_in=(${1})
    screen=${2}
    window_title=${3}
    transport_protocol=${4}
    allowed_media=${5}
    sync_type=${6}
    credentials=${7}
    streaming_port=${8}
    streaming_component=${9}
    av_filters=${10}

    for endpoint in "${endpoints_in[@]}"; do
        ffplay_play_stream "${screen}" "${window_title}" "${transport_protocol}" \
                           "${allowed_media}" "${sync_type}" \
                           "${credentials}" "${endpoint}" "${streaming_port}" \
                           "${streaming_component}" "${av_filters}" 
    done
}

function ffmpeg_record() {
    screen=${1}
    duration=${2}
    transport_protocol=${3}
    credentials=${4}
    endpoint=${5}
    streaming_port=${6}
    streaming_component=${7}
    output_vid=${8}
    av_filters=${9}

    ffmpeg $screen -y  \
            -t $duration \
            -rtsp_transport ${transport_protocol} \
            -i rtsp://${credentials}@${endpoint}:${streaming_port}/${streaming_component} \
            ${av_filters} ${output_vid}
}

function ffmpeg_try_on_endpoints() {
    endpoints_in=(${1})
    screen=${2}
    duration=${3}
    transport_protocol=${4}
    credentials=${5}
    streaming_port=${6}
    streaming_component=${7}
    output_vid=${8}
    av_filters=${9}

    for endpoint in "${endpoints_in[@]}"; do
        ffmpeg_record "${screen}" \
                      "${duration}" \
                      "${transport_protocol}" \
                      "${credentials}" "${endpoint}" \
                      "${streaming_port}" "${streaming_component}" \
                      "${av_filters}" "${output_vid}"
    done
}
