#!/usr/bin/env bash

cd ${HOME}
# mkdir skysource
# cd skysource
# wget -q -O - https://raw.githubusercontent.com/muldjord/skyscraper/master/update_skyscraper.sh | bash

handle_error () {
	local EXITCODE=$?
	local ACTION=$1
	rm --force VERSION
	echo "--- Failed to $ACTION Skyscraper v.${LATEST}, exiting with code $EXITCODE ---"
	exit $EXITCODE
}

echo "--- Fetching Skyscraper ---"
git clone https://github.com/muldjord/skyscraper.git
cd skyscraper
echo "--- Cleaning out old build if one exists ---"
make --ignore-errors clean
rm --force .qmake.stash
qmake || handle_error "clean old"
echo "--- Building Skyscraper ---"
make -j$(nproc) || handle_error "build"
echo "--- Installing Skyscraper ---"
sudo make install || handle_error "install"
echo "--- Skyscraper has been updated ---"

cd ${HOME}
rm -rf skyscraper
