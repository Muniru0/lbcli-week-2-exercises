#!/bin/bash

# ========================================================================
# HELPER FUNCTIONS (PROVIDED - you don't need to modify these)
# ========================================================================

# Helper function to format JSON output
format_json() {
  # This uses jq if available, otherwise falls back to a simple echo
  if command -v jq &> /dev/null; then
    echo "$1" | jq .
  else
    echo "$1"
  fi
}

# Enhanced check_cmd that verifies both command success and non-empty variables
check_cmd() {
  local exit_code=$?
  local cmd_name=$1
  local var_name=$2
  local var_value=$3

  if [ $exit_code -ne 0 ]; then
    echo "ERROR: $cmd_name command failed!"
    exit 1
  fi

  # If a variable name and value are provided, check if it's empty
  if [ ! -z "$var_name" ] && [ ! -z "$var_value" ]; then
    if [ -z "$var_value" ]; then
      echo "ERROR: $var_name is empty! Make sure your solution populates this variable."
      exit 1
    fi
  fi
}

# Helper to trim whitespace
trim() {
  local var="$*"
  # Remove leading whitespace
  var="${var#"${var%%[![:space:]]*}"}"
  # Remove trailing whitespace
  var="${var%"${var##*[![:space:]]}"}"
  printf '%s' "$var"
}
