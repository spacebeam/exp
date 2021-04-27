package = "zerg"
version = "0.3-0"

source = {
  url = "git://github.com/spacebeam/zerg",
  tag = "0.3.0",
}

description = {
  summary = "Live for the Swarm!",
  detailed = "Spawn nodes of processes — all operations run using the zerg command.",
  homepage = "https://spacebeam.org",
  license = "Apache-2.0"
}

dependencies = {
  "lua == 5.1",
  "argparse",
  "inifile",
  "luasocket",
  "lzmq-ffi",
  "uuid"
}

build = {	
  type = 'builtin',
  modules = {
    ['zerg.lib.json'] = "src/lib/json.lua",
    ['zerg.lib.yaml'] = "src/lib/YAMLParserLite.lua",
    ['zerg.version'] = "src/version.lua",
    ['zerg.messages'] = "src/messages.lua",
    ['zerg.options'] = "src/options.lua",
    ['zerg.tools'] = "src/tools.lua"
  },
  install = {
    bin = {
      ['zerg'] = "src/main.lua"
    }
  }
}
