local base_path = "/home/alice/develop/project/nvim_conf/new_conf/lua"
package.path = package.path..string.format(";/%s/?.lua;/%s/?/init.lua", base_path, base_path)

require("modules.keymap")
require("modules.option")
require("modules.plugin")
