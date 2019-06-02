#!/usr/bin/env bash

cd ${HOME}
mkdir skysource
cd skysource
wget -q -O - https://raw.githubusercontent.com/muldjord/skyscraper/master/update_skyscraper.sh | bash

cd ${HOME}
rm -rf skysource
