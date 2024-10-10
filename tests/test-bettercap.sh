#!/bin/bash

source "./abstract-configs/abstract-ip-manipulation.sh"

write_endpoints "./endpoints.txt" "1" "${ipadd_pattern}"

endpoints_out=("")

get_endpoints "./endpoints.txt" "${endpoints_out}"

# Print the array contents
for endpoint in "${endpoints_out[@]}"; do
    echo "Endpoint: $endpoint"
done