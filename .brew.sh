#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
#brew install coreutils
#sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
#brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
#brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
#brew install gnu-sed --with-default-names
# Install Bash 4.
brew install bash
brew install bash-completion2
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash

# Install `wget` with IRI support.
brew install wget --with-iri


# Install Python
#brew install python
#brew install python3

# Install more recent versions of some OS X tools.
brew install vim --with-override-system-vi

# Install some CTF tools; see https://github.com/ctfs/write-ups.
#brew install aircrack-ng
#brew install bfg
#brew install binutils
#brew install binwalk
#brew install cifer
#brew install dex2jar
#brew install dns2tcp
#brew install fcrackzip
#brew install foremost
#brew install hashpump
#brew install hydra
#brew install john
#brew install knock
#brew install netpbm
brew install nmap
#brew install pngcheck
#brew install socat
brew install sqlmap
#brew install tcpflow
#brew install tcpreplay
#brew install tcptrace
#brew install ucspi-tcp # `tcpserver` etc.
#brew install homebrew/x11/xpdf
#brew install xz

# Install other useful binaries.
brew install ack
brew install dark-mode
#brew install exiv2
brew install git
#brew install git-lfs
#brew install git-flow
brew install git-extras
brew install hub
#brew install graphicsmagick
#brew install lua
#brew install lynx
#brew install p7zip
#brew install pigz
#brew install pv
#brew install rename
#brew install rhino
#brew install speedtest_cli
#brew install ssh-copy-id
#brew install tree
#brew install webkit2png
#brew install zopfli
#brew install pkg-config libffi
#brew install pandoc

# Lxml and Libxslt
#brew install libxml2
#brew install libxslt
#brew link libxml2 --force
#brew link libxslt --force

# Further binaries
binaries=(
  colima
  docker
  mkcert
  drud/ddev/ddev
  node
  dnsmasq
  htop
  youtube-dl
  thefuck
  mas
)

brew install ${binaries[@]}

# Generate and install development SSL certs
mkcert -install

# Install Casks
brew tap caskroom/versions

apps=(
# core
  alfred
# development
  macdown
  sequel-ace
  phpstorm
# misc
  eloston-chromium
  firefox
  imageoptim
  dropbox
  enpass
  moneymoney
  appcleaner
  hazel
  gpgtools
  bettertouchtool
  bartender
  caffeine
  istat-menus
  libreoffice
  little-snitch
  microsoft-teams
  mimestream
  slack
  transmit
  insomnia
  tunnelblick
  visual-studio-code
)

echo "[+] installing apps ..."
brew install --cask ${apps[@]}

# Install apps from Mac Appstore
macApps=(
  425424353 #'The Unarchiver'
  671736912 #'FruitJuice'
  409183694 #'Keynote'
  472226235 #'LanScan'
  494803304 #'WiFi Explorer'
  407963104 #'Pixelmator'
  682658836 #'GarageBand'
  409203825 #'Numbers'
  497799835 #'Xcode'
  409201541 #'Pages'
  408981434 #'iMovie'
  685953216 #'Instashare'
  543327839 #'GPX Reader'
  874920950 #'Proxy'
  430255202 #'Mactracker'
  1518036000 # Sequel Ace
)
echo "[+] installing apps from mac appstore (you have to be logged in to your iCloud account!) ..."
mas install ${macApps[@]}
mas upgrade

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
quicklookFeatures=(
  qlcolorcode
  qlstephen
  qlmarkdown
  qlprettypatch
  quicklook-csv
  quicklook-json
  qlrest
  betterzipql
  qlimagesize
  webpquicklook
  suspicious-package
)
echo "[+] install quicklook features ..."
brew install --cask ${quicklookFeatures[@]}

# Set login items
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/BetterTouchTool.app", hidden:false}' > /dev/null
#osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Dropbox.app", hidden:false}' > /dev/null
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Bartender 3.app", hidden:false}' > /dev/null
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Caffeine.app", hidden:false}' > /dev/null
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Alfred 3.app", hidden:false}' > /dev/null
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/BetterTouchTool.app", hidden:false}' > /dev/null
osascript -e 'tell application "System Events" to make login item at end with properties {path:"'$HOME'/Library/PreferencePanes/Hazel.prefPane/Contents/MacOS/HazelHelper.app", hidden:false}' > /dev/null

# Remove outdated versions from the cellar.
brew cleanup
