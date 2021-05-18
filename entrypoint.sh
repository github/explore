#!/usr/bin/env bash

if [ "${1}" == "bash" ]; then
    bash
else
    python ${1}
fi
