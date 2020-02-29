#!/bin/bash
echo -e "\x1b[32mDependency compilation starting...\n\x1b[0m"
rm -rf target
mkdir target && cd target
echo -e "\x1b[32mRunning cmake.\n\x1b[0m"
`cmake -D CMAKE_INSTALL_PREFIX=./install ..` > /dev/null 2>&1
echo -e "\x1b[32mConfiguration complete.\nCompiling...\x1b[0m"
`make -j4` > /dev/null 2>&1
echo -e "\x1b[32mCompiling complete.\nGathering...\x1b[0m"
`make install` > /dev/null 2>&1
cd install/lib
rm -f librocket-deps.a
`../../../combine_static_libraries.sh librocket-deps` > /dev/null 2>&1

echo -e "\x1b[32;5mDependency compilation complete!\n\x1b[0m"
