#!/bin/bash
cd SUCHAI-Flight-Software 
git pull
python3 compile.py FREERTOS NANOMIND "$@"
