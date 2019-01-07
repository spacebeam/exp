#!/usr/bin/env luajit
--
-- Spawn multi-dimensional nodes of daemons — all operations run using the pkg command.
--
local argparse = require("argparse")
local socket = require("socket")
local uuid = require("uuid")
-- init random seed
uuid.randomseed(socket.gettime()*10000)
-- Session UUID
local session_uuid = uuid()
-- Erlang/OTP release
local release = "/_rel/daemons_release/bin/daemons_release"
-- Parse CLI arguments
local parser = argparse() {
   name = "pkg",
   description = "pkg command line toolkit.",
   epilog = "Remember, as your units grow in number, you must spawn more nodes to control them."
}
-- Spawning sandbox scif unit at directory
parser:option("-u --unit", "unit name, uuid or hash", false)
parser:option("-d --directory", "Sandbox directory", "/opt/pkg/")
-- CLI pkg command
parser:command_target("command")
parser:command("install")
parser:command("remove")
parser:command("start")
parser:command("stop")
parser:command("status")
-- How if instead of run we force the use of scif apps?
parser:command("run")
-- We can probably support both of them, let just start with run.

-- system variables
local build = "singularity build --sandbox"
local daemons = "git clone https://github.com/spacebeam/daemons"
local spawn = "/opt/daemons/"
-- system messages
local messages = {
  'Computer online. Good morning, Human.',
  'Can I take your order?',
  'Go ahead HQ.',
  'container unit?',
  'Input unit.',
  'When removing your overhead luggage, please be careful.',
  'In case of a water landing, you may be used as a flotation device.',
  'To hurl chunks, please use the vomit bag in front of you.',
  'Please keep your arms and legs inside until this ride comes to a full and complete stop.',
  'In the pipe, five by five.',
  'In transit HQ.',
  'Buckle up.',
  'Strap yourselves in, boys.',
  'I copy that.',
}
-- parse arguments
local args = parser:parse()
local runsc = "singularity run --writable " .. args['directory']
local instart = "singularity instance.start --writable " .. args['directory']
local instop = "singularity instance.stop " .. args['directory']
-- do your stuff
if args['command'] == 'install' then
    if args['unit'] then
        print('Installing scif unit ' .. args['unit'] .. ' into ' .. args['directory'])
        -- install some singularity container
        print('Done... ' .. messages[math.random(#messages)])
    else
        os.execute(daemons .. " " .. spawn)
        os.execute("curl -O https://erlang.mk/erlang.mk")
        os.execute("mv erlang.mk " .. spawn)
        os.execute("rm erlang.mk")
        os.execute("cd " .. spawn .. " && make all")
        print('Done... ' .. messages[math.random(#messages)])
    end
elseif args['command'] == 'start' then
    if args['unit'] then
        print('Starting scif unit ' .. args['unit'])
        os.execute(instart .. args['unit'] .. " " .. args['unit'])
        print('Done... ' .. messages[math.random(#messages)])
    else
        os.execute(spawn .. release .. " start")
        os.execute(instart .. "daemons" .. " " .. "bridge")
        print('Done... ' .. messages[math.random(#messages)])
    end
elseif args['command'] == 'stop' then
    if args['unit'] then
        print('Stoping scif unit ' .. args['unit'])
        os.execute(instop .. args['unit'] .. " " .. args['unit'])
        print('Done... ' .. messages[math.random(#messages)])
    else
        os.execute()
        os.execute()
        print()
    end
elseif args['command'] == 'status' then
    if args['unit'] then
        print('Getting the status of scif unit ' .. args['unit'] )
        -- Query and return last status
        print('Done.. ' .. messages[math.random(#messages)])
    else
        os.execute(spawn .. release .. " ping")
    end
elseif args['command'] == 'run' then
    if args['unit'] then
        os.execute(runsc .. args['unit'])
    else
        print('Did you forget about the ' .. messages[4])
    end
elseif args['command'] == 'remove' then
    if args['unit'] then
        print('Remove unit ' .. args['unit'])
        os.execute("rm -Rf /opt/scif/" .. args['unit'])
        print('Done... ' .. messages[math.random(#messages)])
    else
        print('Remove Erlang/OTP release from "' .. spawn .. '"')
        os.execute("rm -Rf " .. spawn)
        print('Done... ' .. messages[math.random(#messages)])
    end
else
    -- do something else
    print(messages[1])
end
