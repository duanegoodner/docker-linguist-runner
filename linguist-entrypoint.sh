#!/bin/bash
set -e
cd /linguist
exec bundle exec ruby bin/github-linguist "$@"
