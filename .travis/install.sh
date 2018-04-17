#!/bin/bash -xe

if [ -d "${HOME}/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv rehash
fi

bundle install --retry 5 --path .bundle/gems
rbenv rehash
