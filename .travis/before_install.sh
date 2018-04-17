#!/bin/bash -xe

rm -f Gemfile.lock
rm -rf .bundle/

[ -d ~/.rbenv ] || git clone https://github.com/rbenv/rbenv.git ~/.rbenv

cd ~/.rbenv && src/configure && make -C src

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

. ~/.bashrc
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

rbenv install -f 2.4.3
rbenv global 2.4.3
gem update --system --no-document
gem install --no-document bundler rake
