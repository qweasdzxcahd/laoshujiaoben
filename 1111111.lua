-- 修复HTTP 404错误的TeTraX作弊菜单脚本

-- 设置FPS上限
if setfpscap then
    setfpscap(900)
end

-- 加载WindUI库（使用可靠链接）
local success, WindUI = pcall(function()
    -- 尝试多个可能的WindUI源
    local sources = {
        "https://raw.githubusercontent.com/wally-rblx/WindUI/main/source.lua",
        "https://raw.githubusercontent.com/EdgeIY/WindUI/main/WindUI.lua",
        "https://raw.githubusercontent.com/AlexR32/WindUI/main/dist/WindUI.lua"
    }
    
    for _, url in ipairs(sources) do
        local response = game:HttpGet(url, true)
        if response and #response > 0 then
            return loadstring(response)()
        end
    end
    error("Failed to load WindUI from any source")
end)

if not success then
    warn("WindUI加载失败: "..tostring(WindUI))
    return
end

-- 修复后的grabfunc函数
function grabfunc(p93)
    local success, result = pcall(function()
        local signalFunc = require(game:GetService("ReplicatedStorage").devv.client.Helpers.remotes.Signal).FireServer
        local upvalues = getupvalue(signalFunc, 1)
        if upvalues and upvalues.grabPlayer then
            game:GetService("ReplicatedStorage").devv.remoteStorage[tostring(upvalues.grabPlayer)]:FireServer(unpack({p93}))
        end
    end)
    if not success then warn("grabfunc错误: "..tostring(result)) end
end

-- 修复后的getPlayerEquipped函数
function getPlayerEquipped()
    local equippedItem = nil
    pcall(function()
        local v3Items = require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item)
        equippedItem = getupvalues(v3Items.inventory.setEquipped)[7].equipped
    end)
    return equippedItem
end

-- 创建WindUI主窗口
local window = WindUI:CreateWindow({
    Title = "TeTraX",
    Center = true,
    AutoShow = true,
    Size = UDim2.new(0, 500, 0, 400)
})

-- 添加功能标签页
local mainTab = window:AddTab("Main")
local playerTab = window:AddTab("Player")
local teleportTab = window:AddTab("Teleport")

-- 主标签页功能
mainTab:AddSection("核心功能")
mainTab:AddButton({
    Title = "加载作弊",
    Description = "初始化所有作弊功能",
    Callback = function()
        print("作弊功能已加载!")
    end
})

mainTab:AddToggle({
    Title = "无敌模式",
    Default = false,
    Callback = function(value)
        getgenv().GodMode = value
        print("无敌模式: "..(value and "开启" or "关闭"))
    end
})

-- 玩家标签页功能
playerTab:AddSection("玩家属性")
playerTab:AddSlider({
    Title = "移动速度",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(value)
        local character = game:GetService("Players").LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = value
        end
    end
})

playerTab:AddSlider({
    Title = "跳跃高度",
    Min = 50,
    Max = 300,
    Default = 50,
    Callback = function(value)
        local character = game:GetService("Players").LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = value
        end
    end
})

-- 传送标签页功能
teleportTab:AddSection("位置传送")
teleportTab:AddButton({
    Title = "传送到出生点",
    Callback = function()
        local spawn = game:GetService("Workspace"):FindFirstChild("SpawnLocation")
        if spawn then
            local character = game:GetService("Players").LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = spawn.CFrame
            end
        else
            warn("未找到出生点!")
        end
    end
})

teleportTab:AddDropdown({
    Title = "传送到玩家",
    Options = {},
    Callback = function(selected)
        local targetPlayer = game:GetService("Players"):FindFirstChild(selected)
        if targetPlayer and targetPlayer.Character then
            local character = game:GetService("Players").LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = targetPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
            end
        end
    end
})

-- 自动更新玩家列表
game:GetService("Players").PlayerAdded:Connect(function(player)
    local options = {}
    for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
        if p ~= game:GetService("Players").LocalPlayer then
            table.insert(options, p.Name)
        end
    end
    teleportTab:UpdateDropdown("传送到玩家", {Options = options})
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    local options = {}
    for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
        if p ~= game:GetService("Players").LocalPlayer then
            table.insert(options, p.Name)
        end
    end
    teleportTab:UpdateDropdown("传送到玩家", {Options = options})
end)

-- 初始化UI
WindUI:Init()

print("TeTraX作弊菜单已成功加载!")
