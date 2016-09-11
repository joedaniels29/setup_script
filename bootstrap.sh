#!/bin/bash

cd ~;
mkdir -p ~/Projects/Mine/
cd ~/Projects/Mine


git clone https://github.com/joedaniels29/setup_script.git

if [[ -d setup_script ]]; then
  if [[ $TESTING == "true"]]; then
     return 0;
   fi
  cd setup_script
  source setup.sh
else
  echo "you failed. Internet connection? Github down? "
   return 1
fi
