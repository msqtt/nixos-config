local Opt = {}
local Mode = {}
Keymap = {}

--[[
-- Opt 方法
]]
-- 当前buffer生效
function Opt:Buffer()
	self.buffer = true
	return self
end
-- 不会递归定义
function Opt:Nore()
	self.noremap = true
	return self
end
-- 前缀相同时，不会等待下一个键
function Opt:Nowait()
	self.nowait = true
	return self
end
-- 命令如果有echo, 不显示
function Opt:Silent()
	self.silent = true
	return self
end
-- 参数作为表达式，结果为lhs
function Opt:Expr()
	self.expr = true
	return self
end

--[[
-- Mode 方法
]]

function Mode:n()
	table.insert(self, "n")
	return self
end
-- select + view
function Mode:v()
	table.insert(self, "v")
	return self
end

function Mode:i()
	table.insert(self, "i")
	return self
end
-- cli
function Mode:c()
	table.insert(self, "c")
	return self
end
-- select
function Mode:s()
	table.insert(self, "s")
	return self
end
-- view
function Mode:x()
	table.insert(self, "x")
	return self
end
-- operate
function Mode:o()
	table.insert(self, "o")
	return self
end

function Keymap.opt(o)
	o = o or {}
	setmetatable(o, { __index = Opt })
	return o
end

function Keymap.mod(m)
	m = m or {}
	setmetatable(m, { __index = Mode })
	return m
end

function Keymap.map(mode, pre, now, opt)
	vim.keymap.set(mode, pre, now, opt)
end

return Keymap
