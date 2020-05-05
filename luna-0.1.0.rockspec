package = "luna"
version = "0.1-0"

source = {
  url = "git://github.com/spacebeam/exp",
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
    ['exp.lib.json'] = "src/lib/json.lua",
    ['exp.lib.yaml'] = "src/lib/YAMLParserLite.lua",
    ['exp.version'] = "src/version.lua",
    ['exp.messages'] = "src/messages.lua",
    ['exp.zstreams'] = "src/zstreams.lua",
    ['exp.options'] = "src/options.lua",
    ['exp.tools'] = "src/tools.lua"
  },
  install = {
    bin = {
      ['exp'] = "src/main.lua"
    }
  }
}
