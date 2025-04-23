#!/bin/bash
set -e

export KIOSK_MODE
export START_URL
export SCALE

exec "$@"
