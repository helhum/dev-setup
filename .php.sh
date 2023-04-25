#!/usr/bin/env bash

brew tap shivammathur/php

binaries=(
  php
  shivammathur/php/php@5.6
  shivammathur/php/php@7.2
  shivammathur/php/php@7.4
  shivammathur/php/php@8.1
)

brew install ${binaries[@]}

# Install composer
if [ -f ~/.bin/composer ]; then
  composer self-update
else
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php --install-dir=$HOME/.bin --filename=composer
  php -r "unlink('composer-setup.php');"
fi

# Install global composer packages
composerPackages=(
  bamarni/symfony-console-autocomplete
  friendsofphp/php-cs-fixer
  helhum/typo3-deployer-recipe:dev-main
)

php74 $HOME/.bin/composer global require ${composerPackages[@]}

$(brew --prefix)/Cellar/php@8.1/*/bin/pecl install xdebug
