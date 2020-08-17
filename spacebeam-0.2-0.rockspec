package = "spacebeam"
version = "0.2-0"

source = {
  url = "git://github.com/spacebeam/luna",
  tag = "0.2.0",
}

description = {
  summary = "Spacebeam workspace (luna) command line tool.",
  detailed = "Spawn nodes of daemons — all operations run using the luna command.",
  homepage = "https://spacebeam.org",
  license = "AGPL 3"
}

dependencies = {
  "lua == 5.1",
  "argparse",
  "luasocket",
  "lzmq-ffi",
  "uuid"
}

build = {
  type = 'builtin',
  modules = {
    ['spacebeam.lib.json'] = "src/lib/json.lua",
    ['spacebeam.lib.yaml'] = "src/lib/YAMLParserLite.lua",
    ['spacebeam.version'] = "src/version.lua",
    ['spacebeam.messages'] = "src/messages.lua",
    ['spacebeam.options'] = "src/options.lua",
    ['spacebeam.tools'] = "src/tools.lua"
  },
  install = {
    bin = {
      ['luna'] = "src/main.lua"
    }
  }
}
