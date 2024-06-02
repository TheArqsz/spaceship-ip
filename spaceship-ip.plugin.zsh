#
# IP address
#
# A section for spaseship prompt that allows you to show your current "main" ip (default GTW)
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_IP_SHOW="${SPACESHIP_IP_SHOW=true}"
SPACESHIP_IP_ASYNC="${SPACESHIP_IP_ASYNC=true}"
SPACESHIP_IP_USE_HOSTNAME="${SPACESHIP_IP_USE_HOSTNAME=true}"
SPACESHIP_IP_PREFIX="${SPACESHIP_IP_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_IP_SUFFIX="${SPACESHIP_IP_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_IP_SYMBOL="${SPACESHIP_IP_SYMBOL="@ "}"
# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
SPACESHIP_IP_COLOR="${SPACESHIP_IP_COLOR="#00ff5f"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show IP status
# spaceship_ prefix before section's name is required!
# Otherwise this section won't be loaded.
spaceship_ip() {
  # If SPACESHIP_IP_SHOW is false, don't show foobar section
  [[ $SPACESHIP_IP_SHOW == false ]] && return

  # Check if ip/ipconfig/hostname command is available for execution
  spaceship::exists ip || (spaceship::exists ifconfig && spaceship::exists route) || spaceship::exists hostname || return

  local _ip
  local un="$(uname)"
  if [ "$un" = "Darwin" ]; then
    if spaceship::exists ifconfig && spaceship::exists route; then
      _ip="$(ifconfig $(route -n get default | grep 'interface:' | awk -F 'interface:' '{print $2}') | grep 'inet ' | awk -F'inet' '{print $2}' | cut -d' ' -f2)"
    else
      return
    fi
  elif [ "$un" = "Linux" ]; then
    if spaceship::exists ip; then
      _ip="$(ip route get 1.1.1.1 | head -1 | awk '{ print $7 }')"
    elif spaceship::exists ifconfig && spaceship::exists route; then
      _ip="$(ifconfig $(route -n | grep '^0.0.0.0' | head -1 | awk '{print $8}') | grep 'inet ' | awk -F'inet' '{print $2}' | cut -d' ' -f2)"
    elif spaceship::exists hostname && [[ $SPACESHIP_IP_USE_HOSTNAME == true ]]; then
      _ip="*$(hostname -I | awk '{print $1}')"
    else
      return
    fi
  fi

  # Display ip section
  # spaceship::section utility composes sections. Flags are optional
  spaceship::section::v4 \
    --color "$SPACESHIP_IP_COLOR" \
    --prefix "$SPACESHIP_IP_PREFIX" \
    --suffix "$SPACESHIP_IP_SUFFIX" \
    --symbol "$SPACESHIP_IP_SYMBOL" \
    "$_ip"
}
