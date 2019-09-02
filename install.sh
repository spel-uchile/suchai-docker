#!/bin/bash
git clone https://github.com/spel-uchile/SUCHAI-Flight-Software.git
cd SUCHAI-Flight-Software
python3 compile.py FREERTOS NANOMIND --drivers
