#!/bin/bash
cd SUCHAI-Flight-Software
git pull
python3 compile.py FREERTOS ESP32 --comm 1 --fp 0 --hk 1 --test 0 --st_mode 1 --drivers
