#!/bin/bash -eux

THIS_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
echo $THIS_DIR
export BUNDLE_GEMFILE=${THIS_DIR}/Gemfile
bundle exec ruby ${THIS_DIR}/nagel_schreckenberg.rb $@
