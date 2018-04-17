#!/bin/bash -xe

update_env_profile() {
  export PATH="${RBENV_ROOT}/bin:$PATH"
  eval "$(rbenv init -)"
}

rm -f Gemfile.lock
rm -rf .bundle/

export RBENV_ROOT="${HOME}/.rbenv"

if [ ! -d ${RBENV_ROOT} ]; then
  git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT}
  cd ${RBENV_ROOT} && src/configure && make -C src
fi

type -P rbenv >>/dev/null 2>&1 || update_env_profile

mkdir -p ${RBENV_ROOT}/plugins
[ -d "${RBENV_ROOT}/plugins/ruby-build" ] || git clone https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build

rbenv install --skip-existing 2.4.3
rbenv global 2.4.3
gem update --system --no-document
gem install --no-document --force bundler rake
