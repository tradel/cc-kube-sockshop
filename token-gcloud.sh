#!/bin/bash

gcloud config config-helper --format=json | jq -r .credential.access_token | pbcopy
