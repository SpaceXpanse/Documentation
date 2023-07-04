#!/bin/sh -e

./hello \
  --xaya_rpc_url="http://user:password@localhost:18499" \
  --game_rpc_port=28332 \
  --storage_type=lmdb \
  --datadir=/tmp/libspex
