#!/bin/bash

set -eux
script_dir=$(cd $(dirname $0); pwd)
cd "$script_dir"

bundle install --path=vendor/bundle

"$OACIS_ROOT/bin/oacis_ruby" "$script_dir/register_on_oacis.rb"

