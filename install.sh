#!/usr/bin/env bash

#check dependencies
if ! ruby -v > /dev/null 2>&1; then
  echo "Ruby is not installed!"
  echo "You can visit https://www.ruby-lang.org/en/documentation/installation/ to get it"
  exit
fi
if ! gem spec nokogiri > /dev/null 2>&1; then
  echo "Gem nokogiri is not installed!"
  echo "Run 'gem install nokogiri' to install it"
  exit
fi
if ! gem spec colorize > /dev/null 2>&1; then
  echo "Gem colorize is not installed!"
  echo "Run 'gem install colorize' to install it"
  exit
fi

#move ruby file to lib folder and let execute it
mkdir /usr/lib/enru -p
cp ./enru.rb /usr/lib/enru/enru.rb
chmod +x /usr/lib/enru/enru.rb

#move executable to /bin folder
cp ./enru /usr/bin/enru
chmod +x /usr/bin/enru