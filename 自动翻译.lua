local CoreGui = cloneref(game:GetService("CoreGui"))
local Players = cloneref(game:GetService("Players"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local HttpService = cloneref(game:GetService("HttpService"))

local LocalPlayer = Players.LocalPlayer

local translation = function(text, target)
	local encodedText = HttpService:UrlEncode(text)
	local url = "https://translate.googleapis.com/translate_a/single?client=gtx&dt=t&q="
		.. encodedText
		.. "&tl="
		.. target
		.. "&sl="
		.. "auto"
	local success, response = pcall(function()
		return request({
			Url = url,
			Method = "GET",
			Headers = {},
		})
	end)

	if not success or not response or not response.Body then
		warn("request error: " .. tostring(response))
		return nil
	end

	local success2, data = pcall(function()
		return HttpService:JSONDecode(response.Body)
	end)

	if not success2 or not data or not data[1] or not data[1][1] or not data[1][1][1] then
		warn("parse error: " .. tostring(data))
		return nil
	end

	return data[1][1][1]
end

local localtext = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/qweasdzxcahd/laoshujiaoben/refs/heads/main/local language.lua")
)()

return function(target)
	target = target or "zh-CN"

	for _, v in next, CoreGui:GetDescendants() do
		if v:IsA("TextLabel") then
			local lt = localtext[v.Text:lower()]
			if lt then
				v.Text = lt
			else
				task.spawn(function()
					local text = translation(v.Text, target)
					if text then
						v.Text = text
					end
				end)
			end
			task.wait()
		end
	end

	for _, v in next, LocalPlayer:GetDescendants() do
		if v:IsA("TextLabel") then
			local lt = localtext[v.Text:lower()]
			if lt then
				v.Text = lt
			else
				task.spawn(function()
					local text = translation(v.Text, target)
					if text then
						v.Text = text
					end
				end)
			end
			task.wait()
		end
	end

	for _, v in next, StarterGui:GetDescendants() do
		if v:IsA("TextLabel") then
			local lt = localtext[v.Text:lower()]
			if lt then
				v.Text = lt
			else
				task.spawn(function()
					local text = translation(v.Text, target)
					if text then
						v.Text = text
					end
				end)
			end
			task.wait()
		end
	end
end
