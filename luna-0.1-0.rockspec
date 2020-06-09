package = "luna"
version = "0.1-0"

source = {
  url = "git://github.com/spacebeam/luna",
  tag = "0.1.0",
}

description = {
  summary = "Spaceboard workspace (luna) command line tool.",
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
    ['luna.lib.json'] = "src/lib/json.lua",
    ['luna.lib.yaml'] = "src/lib/YAMLParserLite.lua",
    ['luna.version'] = "src/version.lua",
    ['luna.messages'] = "src/messages.lua",
    ['luna.options'] = "src/options.lua",
    ['luna.tools'] = "src/tools.lua"
  },
  install = {
    bin = {
      ['luna'] = "src/main.lua"
    }
  }
}
