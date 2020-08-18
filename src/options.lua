-- read luna.conf with the lua module inifile
--
-- why a ini file? it appears that is what we are using in python by default
-- for all the *.conf files of our daemons.
--
local inspect = require('inspect')
local inifile = require('inifile')
local conf = inifile.parse('/opt/luna/luna.conf')

-- TODO: for now just get cluster variable from luna.conf?
print(inspect(conf))
