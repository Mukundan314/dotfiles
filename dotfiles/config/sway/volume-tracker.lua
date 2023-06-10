#!/usr/bin/wpexec

local default_sink = nil
local volume = {}


function output_info()
  if volume[default_sink] ~= nil then
    print(volume[default_sink].level, volume[default_sink].mute)
  end
end


-- Keep volume update
sink_manager = ObjectManager {
  Interest {
    type = "node",
    Constraint { "media.class", "=", "Audio/Sink", type = "pw-global" }
  },
}

sink_manager:connect("object-added", function (_, node)
  function update_volume(node)
    for param in node:iterate_params("Props") do
      local props = param:parse().properties
      if props.volume then
        volume[node.properties["node.name"]] = {
          level = props.channelVolumes and props.channelVolumes[1] ^ (1 / 3),
          mute = props.mute,
        }

        if default_sink == node.properties["node.name"] then output_info() end
      end
    end
  end

  node:connect("params-changed", function(node, params) update_volume(node) end)
  update_volume(node)
end)

sink_manager:connect("object-removed", function(_, node)
  volume[node.properties["node.name"]] = nil
end)

sink_manager:activate()


-- Keep default_sink updated
default_manager = ObjectManager {
  Interest {
    type = "metadata",
    Constraint { "metadata.name", "=", "default" },
  },
}

default_manager:connect("object-added", function(_, metadata)
  function process(key, value)
    if key == "default.audio.sink" and value ~= nil then
      default_sink = value:match('"name":[ \t]*"(.*)"')
      output_info()
    end
  end

  metadata:connect("changed", function(_, _, k, _, v) process(k, v) end)
  for _, k, _, v in metadata:iterate(Id.ANY) do process(k, v) end
end)

default_manager:activate()
