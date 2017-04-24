#!/bin/bash
set -ve
SRC="$(readlink -f "$(dirname "${0}")/../")"
cd "${SRC}"
./waf configure --enable-webkit2 --gtk=3
./waf build -j2
./waf install
