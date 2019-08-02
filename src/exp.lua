#!/usr/bin/env luajit
--
-- Spawn multi-dimensional nodes of daemons — all operations run using the exp command.
--
-- change here module to exp.module after luarocks release
local version = require("version")
-- third-party awesome libraries
local argparse = require("argparse")
local socket = require("socket")
local uuid = require("uuid")
-- init random seed
uuid.randomseed(socket.gettime()*10000)
-- Session UUID
local session_uuid = uuid()
-- Erlang/OTP release
local release = "/_rel/spaceboard_release/bin/spaceboard_release"
-- CLI argument parser
local parser = argparse() {
   name = "exp",
   description = "Flying Saucer Experience (exp) command line toolkit.",
   epilog = "Remember, as your units grow in number, you must spawn more nodes to control them."
}
-- TODO: Missing Scientific Filesystem (SCIF) application!
parser:option("-u --unit", "unit name, uuid or hash", false)
parser:option("-x --execute", "exec string", "")
parser:option("-a --app", "application name", false)
parser:option("-d --directory", "Sandbox directory", "/opt/sandbox/")
-- CLI exp command
parser:command_target("command")
parser:command("build")
parser:command("clone")
parser:command("cluster")
parser:command("start")
parser:command("stop")
-- How if instead of run we force the use of SCI-F Apps?
-- https://sci-f.github.io/apps/examples/tutorials/getting-started
-- We can probably support both of them, let just start with run.
parser:command("run")
parser:command("status")
parser:command("version")
-- Parse your arguments
local args = parser:parse()
-- Your system variables
local run = "singularity run --writable " .. args['directory']
local start = "singularity instance.start --writable " .. args['directory']
local stop = "singularity instance.stop " .. args['directory']
local build = "singularity build --sandbox"
local git_clone_spaceboard = "git clone https://github.com/spacebeam/spaceboard"
local spaceboard = "/opt/spaceboard/"
-- Your system messages
local messages = {
  'Can I take your order?',
  'Go ahead HQ.',
  'SCI-F app?',
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
-- Computer do your stuff
if args['command'] == 'build' then
    if args['unit'] then
        print('Installing ' .. args['unit'] .. ' into ' .. args['directory'])
        -- install singularity container
        print('Done... ' .. messages[math.random(#messages)])
    else
        os.execute(git_clone_spaceboard .. " " .. spaceboard)
        os.execute("curl -O https://erlang.mk/erlang.mk")
        os.execute("mv erlang.mk " .. spaceboard)
        os.execute("rm erlang.mk")
        os.execute("cd " .. spaceboard .. " && make all")
        print('Done... ' .. messages[math.random(#messages)])
    end
elseif args['command'] == 'start' then
    if args['unit'] then
        print('Starting unit ' .. args['unit'])
        os.execute(start .. args['unit'] .. " " .. args['unit'])
        print('Done... ' .. messages[math.random(#messages)])
    else
        os.execute(spaceboard .. release .. " start")
        print('Done... ' .. messages[math.random(#messages)])
    end
elseif args['command'] == 'stop' then
    if args['unit'] then
        print('Stoping unit ' .. args['unit'])
        os.execute(stop .. args['unit'] .. " " .. args['unit'])
        print('Done... ' .. messages[math.random(#messages)])
    else
        os.execute(spaceboard .. release .. " stop")
        print('Done... ' .. messages[math.random(#messages)])
    end
elseif args['command'] == 'status' then
    if args['unit'] then
        print('Getting the status of unit ' .. args['unit'] )
        -- status
        print('Done.. ' .. messages[math.random(#messages)])
    else
        os.execute("singularity instance.list")
        os.execute(spaceboard .. release .. " ping")
    end
elseif args['command'] == 'run' then
    if args['unit'] then
        if args['execute'] then
            os.execute(run .. args['unit'] .. ' ' .. args['execute'])
        else
            os.execute(run .. args['unit'])
        end
    else
        print('Did you forget about the ' .. messages[4])
    end
elseif args['command'] == 'clone' then
    if args['unit'] then
        print('Remove unit ' .. args['unit'])
        os.execute("rm -Rf /opt/sandbox/" .. args['unit'])
        print('Done... ' .. messages[math.random(#messages)])
    else
        print('Remove spaceboard release from "' .. spaceboard .. '"')
        os.execute("rm -Rf " .. spaceboard)
        print('Done... ' .. messages[math.random(#messages)])
    end
elseif args['command'] == 'cluster' then
    print('Cluster ' .. messages[math.random(#messages)])
elseif args['command'] == 'version' then
    print('exp version '..version)
else
    -- do something else
    print(messages[1])
end
