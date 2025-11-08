if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = game:GetService("Players").LocalPlayer
local StarterGui = game:GetService("StarterGui")
local Key = key or script_key or ADittokey or "Unknow"

local function Notify(Text)
	StarterGui:SetCore("SendNotification", {
		Title = "ne hub",
		Text = Text,
	})
end

Notify("ne hub")

local WindUI = loadstring(game:HttpGet("https://gitee.com/roblox-smk/sh/raw/master/Luau/WindUIFix.lua"))()

local Window = WindUI:CreateWindow({
	Title = "TeTraX ",
	Author = ("Executeor" .. ":" .. (identifyexecutor() or "Unknow") .. " Game" .. ":" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
	Folder = "TeTraXofficial",
	Size = UDim2.fromOffset(300, 250),
	Transparent = true,
	Theme = "Dark",
	Resizable = true,
	SideBarWidth = 150,
	BackgroundImageTransparency = 0.42,
	HideSearchBar = true,
	ScrollBarEnabled = false,

	User = {
		Enabled = false,
		Callback = function() end,
	},
})

Window:Tag({
	Title = "Check key",
	Color = Color3.fromHex("#30ff6a"),
	Radius = 13,
})

Window:SetToggleKey(Enum.KeyCode.U)

Window:EditOpenButton({
	Title = "Executeor：" .. (identifyexecutor() or "Unknow"),
	CornerRadius = UDim.new(0, 16),
	StrokeThickness = 2,
	Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
	Draggable = true,
})

Tab = Window:Tab({
	Title = "Check key",
})

Window:SelectTab(1)

Tab:Input({
    Title = "key",
    Callback = function(input) 
        script_key=tostring(input) 
    end
})

Tab:Button({
    Title = "Check key.",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/cb3eba9992f4d5233b9fac5e5d2ce692.lua"))()
    end
})