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
	Title = "ne hub ",
	Author = ("Executeor" .. ":" .. (identifyexecutor() or "Unknow") .. " Game" .. ":" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
	Folder = "SukunaScript",
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
	Title = "登入",
	Color = Color3.fromHex("#30ff6a"),
	Radius = 13,
})

Window:SetToggleKey(Enum.KeyCode.U)

Window:EditOpenButton({
	Title = "执行者：" .. (identifyexecutor() or "Unknow"),
	CornerRadius = UDim.new(0, 16),
	StrokeThickness = 2,
	Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
	Draggable = true,
})

Tab = Window:Tab({
	Title = "登入",
})

Window:SelectTab(1)

Tab:Input({
    Title = "卡密",
    Callback = function(input) 
        getfenv().ADittoKey = tostring(input) 
    end
})

Tab:Button({
    Title = "登入",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/shenqin/refs/heads/main/NE%20HUB.lua"))()
    end
})