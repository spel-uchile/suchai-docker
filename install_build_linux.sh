#!/bin/bash
cd SUCHAI-Flight-Software
git pull
python3 compile.py LINUX LINUX --comm 1 --fp 1 --hk 1 --test 0 --st_mode 1 --drivers
