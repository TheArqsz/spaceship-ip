#!/usr/bin/env zsh

# Required for shunit2 to run correctly
CWD="${${(%):-%x}:A:h}"
setopt shwordsplit
SHUNIT_PARENT=$0

# Use system Spaceship or fallback to Spaceship Docker on CI
typeset -g SPACESHIP_ROOT="${SPACESHIP_ROOT:=/spaceship}"

# Mocked tool CLI
mocked_ip="127.0.0.11"

# ------------------------------------------------------------------------------
# SHUNIT2 HOOKS
# ------------------------------------------------------------------------------

setUp() {
  # Enter the test directory
  cd $SHUNIT_TMPDIR
}

oneTimeSetUp() {
  export TERM="xterm-256color"

  source "$SPACESHIP_ROOT/spaceship.zsh"
  source "$(dirname $CWD)/spaceship-ip.plugin.zsh"

  SPACESHIP_PROMPT_ASYNC=false
  SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_PROMPT_ORDER=(ip)
  SPACESHIP_IP_USE_HOSTNAME=false

  echo "Spaceship version: $(spaceship --version)"
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_ASYNC
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_no_prompt_env() {
  local SPACESHIP_IP_SHOW=false
  local expected=""
  local actual="$(spaceship::testkit::render_prompt)"

  assertEquals "do not render ip" "$expected" "$actual"
}

test_mocked_ip_linux() {
  (
    uname() {
      echo "Linux"
    }

    ip() {
      # Try to fit into "$(ip route get 1.1.1.1 | head -1 | awk '{ print $7 }')"
      echo "1.1.1.1 via 127.0.0.1 dev eth0 src $mocked_ip uid 1000"
      echo "cache"
    }
    local prefix="%{%B%}$SPACESHIP_IP_PREFIX%{%b%}"
    local content="%{%B%F{$SPACESHIP_IP_COLOR}%}$SPACESHIP_IP_SYMBOL$mocked_ip%{%b%f%}"
    local suffix="%{%B%}$SPACESHIP_IP_SUFFIX%{%b%}"

    local expected="$prefix$content$suffix"
    local actual="$(spaceship::testkit::render_prompt)"

    assertEquals "Render mocked ip on Linux" "$expected" "$actual"
  )
}

test_mocked_ip_macos() {
  (
    uname() {
      echo "Darwin"
    }

    ifconfig() {
      echo "inet $mocked_ip"
    }

    route() {
      echo "interface: eth0"
    }

    local prefix="%{%B%}$SPACESHIP_IP_PREFIX%{%b%}"
    local content="%{%B%F{$SPACESHIP_IP_COLOR}%}$SPACESHIP_IP_SYMBOL$mocked_ip%{%b%f%}"
    local suffix="%{%B%}$SPACESHIP_IP_SUFFIX%{%b%}"

    local expected="$prefix$content$suffix"
    local actual="$(spaceship::testkit::render_prompt)"

    assertEquals "Render mocked ip on MacOS" "$expected" "$actual"
  )
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source "$SPACESHIP_ROOT/tests/shunit2/shunit2"
