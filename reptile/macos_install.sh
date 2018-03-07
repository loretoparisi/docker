#
# Reptile Build Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2018 Loreto Parisi (loretoparisi at gmail dot com)
#

# check xquartz
if which xquartz >/dev/null; then
    echo "XQuartz installed!"
else
    echo "Please manually install XQuartz from https://www.xquartz.org/"
    echo "and rerun this script."
fi

# install homebrew
if which brew >/dev/null; then
    echo "Homebrew installed!"
else
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if which socat >/dev/null; then
    echo "socat installed!"
else
    echo "Installing socat..."
    # install socat to bind display port
    brew install socat
fi

