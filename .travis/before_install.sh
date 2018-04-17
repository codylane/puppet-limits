#!/bin/bash -xe

rm -f Gemfile.lock
rm -rf .bundle/

export RBENV_ROOT="${HOME}/.rbenv"

SHELL_PROFILE="${HOME}/.bashrc"

if [ ! -d ${RBENV_ROOT} ]; then
  git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT}
  cd ${RBENV_ROOT} && src/configure && make -C src

  if [ -f "${HOME}/.bashrc" ]; then
    SHELL_PROFILE="${HOME}/.bashrc"

    echo 'export PATH="${RBENV_ROOT}/bin:$PATH"' >> ${SHELL_PROFILE}
    echo 'eval "$(rbenv init -)"' >> ${SHELL_PROFILE}
  elif [ -f "${HOME}/.bash_profile" ]; then
    SHELL_PROFILE="${HOME}/.bash_profile"

    echo 'export PATH="${RBENV_ROOT}/bin:$PATH"' >> ${SHELL_PROFILE}
    echo 'eval "$(rbenv init -)"' >> ${SHELL_PROFILE}
  fi

fi

[ -f ${SHELL_PROFILE} ] && . ${SHELL_PROFILE} || . ${HOME}/.bash_profile

mkdir -p ${RBENV_ROOT}/plugins
[ -d "${RBENV_ROOT}/plugins/ruby-build" ] || git clone https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build

rbenv install --skip-existing 2.4.3
rbenv global 2.4.3
gem update --system --no-document
gem install --no-document bundler rake
