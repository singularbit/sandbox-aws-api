#!/bin/bash

if [ "$RUN_TESTS" = true ]; then

  echo "Running tflint..."
  ls -la && pwd
  tflint

fi