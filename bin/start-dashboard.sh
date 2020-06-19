#!/usr/bin/env bash

microk8s kubectl proxy --accept-hosts=.* --address=0.0.0.0
