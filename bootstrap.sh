#!/bin/sh

#
# Check if Homebrew is installed
#
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
	echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "Homebrew already installed"
fi

#
# Check if python is installed
#
if [ ! -e $(python -c 'from distutils.sysconfig import get_makefile_filename as m; print m()') ]; then
	# Install python
	echo "Installing python"
	brew install python
else
	echo "python already installed"
fi

#
# Check if SwiftLint is installed
#
which -s swiftlint
if [[ $? != 0 ]] ; then
    # Install SwiftLint
    echo "Installing SwiftLint"
    brew install swiftlint
else
        echo "SwiftLint already installed"
fi

#
# Check if cURL is installed
#
which -s wget
if [[ $? != 0 ]] ; then
    # Install SwiftGen
    echo "Installing wget"
    brew install wget
else
        echo "wget already installed"
fi


#
# Download SwiftGen
#

wget https://github.com/SwiftGen/SwiftGen/releases/download/6.4.0/swiftgen-6.4.0.zip
unzip swiftgen-6.4.0.zip -d SwiftGen
rm swiftgen-6.4.0.zip
