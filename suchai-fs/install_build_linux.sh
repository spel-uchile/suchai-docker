#!/bin/bash
cd SUCHAI-Flight-Software
git pull
cd sandbox
sleep 10
sh ./postgresql_user_setup.sh ${USER}
cd ..
python3 compile.py LINUX X86 --comm 1 --fp 1 --hk 1 --test 0 --st_mode 2 --drivers --node 11
