#!/bin/bash
cd SUCHAI-Flight-Software
git pull
test=$1
echo $test
if [ "$test" == "test_cmd" ]
then
    python3 compile.py LINUX X86 --comm 0 --fp 0 --hk 0 --st_mode 1 --drivers --test 1 --test_type $test
else
    python3 compile.py LINUX X86 --comm 0 --fp 0 --hk 0 --st_mode 1 --drivers --test 0 --test_type $test
fi
