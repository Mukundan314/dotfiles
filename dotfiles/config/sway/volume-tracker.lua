#!/usr/bin/wpexec

Core.require_api("default-nodes", "mixer", function(...)
  local default_nodes, mixer = ...
  mixer.scale = "cubic"

  local function update()
    local id = default_nodes:call("get-default-node", "Audio/Sink")
    local props = mixer:call("get-volume", id)
    print(props.volume, props.mute)
  end

  default_nodes:connect("changed", update)
  mixer:connect("changed", update)
  update()
end)
