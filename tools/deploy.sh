#!/bin/bash
# Push the app to Google App Engine

if ! type gcloud > /dev/null; then
  echo "Please set up gcloud first: https://cloud.google.com/sdk/docs/quickstarts"
  exit 1
fi

gcloud app deploy _public/app.yaml --project elliptical-tree-187121
