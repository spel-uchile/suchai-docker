#!/bin/bash
cd SUCHAI-Flight-Software
git pull
python3 compile.py FREERTOS NANOMIND --drivers --ssh
python3 compile.py FREERTOS NANOMIND
