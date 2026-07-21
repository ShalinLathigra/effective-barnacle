local M = {}

local FLAG = "/tmp/yazi-autoplay-on"
local SOCK = "/tmp/yazi-mpv.sock"

local get_hovered = ya.sync(function()
	local h = cx.active.current.hovered
	return h and tostring(h.url) or nil
end)

local function is_on()
	local f = io.open(FLAG, "r")
	if f then f:close(); return true end
	return false
end

local function mpv_cmd(json)
	local cmd = string.format(
		"echo '%s' | socat - %s",
		json, SOCK
	)
	Command("sh"):arg({ "-c", cmd }):output()
end

function M:peek(job)
	local path = tostring(job.file.url)
	local mime = job.mime or "NIL"
	if is_on() and mime:find("^audio/") then
		mpv_cmd(string.format('{"command": ["loadfile", "%s"]}', path))
	end
	local status = is_on() and "▶ autoplay on" or "‖ autoplay off"
	ya.preview_widget(job, ui.Text(status .. "\n" .. path):area(job.area))
end

function M:seek() end
function M:entry()
	if is_on() then
		os.remove(FLAG)
		mpv_cmd('{"command": ["stop"]}')
	else
		local f = io.open(FLAG, "w")
		if f then f:close() end
		local path = get_hovered()
		if path then
			mpv_cmd(string.format('{"command": ["loadfile", "%s"]}', path))
		end
	end
end

return M
