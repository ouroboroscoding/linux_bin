#!/bin/bash
ffmpeg -i $1 -vf "transpose=2" $2
