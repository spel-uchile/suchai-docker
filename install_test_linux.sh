#!/bin/bash
cd SUCHAI-Flight-Software
git pull
python3 compile.py LINUX LINUX --comm 0 --fp 0 --hk 0 --st_mode 1 --drivers --test 1 --test_type test_cmd
python3 compile.py LINUX LINUX --comm 0 --fp 0 --hk 0 --st_mode 1 --drivers --test 0 --test_type test_unit
python3 compile.py LINUX LINUX --comm 0 --fp 0 --hk 0 --st_mode 1 --drivers --test 0 --test_type test_load
python3 compile.py LINUX LINUX --comm 0 --fp 0 --hk 0 --st_mode 1 --drivers --test 0 --test_type test_bug_delay

