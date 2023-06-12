#!/bin/bash
DEST = $HOME
mkdir $DEST/opt
cd $DEST/opt
git clone https://github.com/UG4/ughub

export UG4_ROOT=$HOME/opt/ug4
echo "Found ug4: $UG4_ROOT"

# UG4
mkdir $UG4_ROOT
cd $UG4_ROOT
../ughub/ughub init
../ughub/ughub install Examples
../ughub/ughub install Limex
../ughub/ughub install SuperLU6
../ughub/ughub git checkout v23.6.0

# Fetch Pybind
cd $UG4_ROOT
../ughub/ughub install PybindForUG4
../ughub/ughub git submodule init
../ughub/ughub git submodule update

# Change to pybind feature
cd $UG4_ROOT/ugcore
git checkout feature-pybind11
git pull


# Change to v6.0.0
cd $UG4_ROOT/plugins/SuperLU6/external/superlu
git checkout v6.0.0

# Create directory for Python
mkdir $UG4_ROOT/bin
mkdir $UG4_ROOT/bin/plugins
mkdir $UG4_ROOT/bin/plugins/ug4py

# Build UG4
cd $UG4_ROOT
mkdir build
cd build
cmake -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang -DCMAKE_BUILD_TYPE=Release ..
cmake -DDIM="2;3" -DCPU=1 -DPARALLEL=OFF ..
cmake -DLimex=ON -DConvectionDiffusion=ON -DSuperLU6=ON ..
cmake -DUSE_PYBIND11=ON -DCMAKE_POLICY_DEFAULT_CMP0057=NEW ..
make 
