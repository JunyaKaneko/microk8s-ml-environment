#!/usr/bin/env bash

eval "$(/opt/conda/bin/conda shell.bash hook)"
conda activate env
exec "$@"
