#!/bin/bash -xe

if [ -d "${HOME}/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

bundle install --path .bundle/gems --verbose
bundle show
