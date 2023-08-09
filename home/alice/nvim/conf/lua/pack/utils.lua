U = {}

function U.getPlug(plugname)
	local status, plug = pcall(require, plugname)
	if not status then
		vim.notify("没有找到 " .. plugname .. " 插件")
		return nil
	end
	return plug
end

return U
