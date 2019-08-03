package = "exp"
version = "0.1-0"

source = {
  url = "git://github.com/spacebeam/exp",
  tag = "0.1.0",
}

description = {
  summary = "Flying Saucer Experience (exp) command line toolkit.",
  detailed = "Spawn multi-dimensional nodes of daemons — all operations run using the exp command.",
  homepage = "https://spacebeam.io",
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
    ['exp.version'] = "src/version.lua",
    ['exp.messages'] = "src/messages.lua",
    ['exp.cluster'] = "src/cluster.lua",
    ['exp.options'] = "src/options.lua",
    ['exp.tools'] = "src/tools.lua"
  },
  install = {
    bin = {
      ['exp'] = "src/main.lua"
    }
  }
}
