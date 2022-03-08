#!/bin/bash

source ./set_envs
./compose.sh $1 down && ./compose.sh $1 up -d
