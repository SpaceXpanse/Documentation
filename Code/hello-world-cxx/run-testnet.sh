#!/bin/sh -e

./hello \
  --spacexpanse_rpc_url="http://user:password@localhost:18399" \
  --game_rpc_port=28332 \
  --storage_type=memory \
  --datadir=/tmp/libspex
