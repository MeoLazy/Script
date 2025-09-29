local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/MeoLazy/Script/refs/heads/main/FixLag.lua"))()

local Window = Fluent:CreateWindow({ Title = "Turbo Lite", SubTitle = "Fix Lag True V2 https://turbolite.xyz/discord", TabWidth = 100, Size = UDim2.fromOffset(480, 320), Acrylic = false, Theme = "Dark", MinimizeKey = Enum.KeyCode.End })

local Tabs = { 
   Main = Window:AddTab({ Title = "Local Fix Lag", Icon = "" }),
    Farm = Window:AddTab({ Title = "Class Player", Icon = "" }),
}

local Options = Fluent.Options

--//ScreenGui
 local ScreenGui = Instance.new("ScreenGui") local ImageButton = Instance.new("ImageButton") local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ImageButton.Parent = ScreenGui ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) ImageButton.BorderSizePixel = 0 ImageButton.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0) ImageButton.Size = UDim2.new(0, 40, 0, 40) ImageButton.Draggable = true ImageButton.Image = "http://www.roblox.com/asset/?id=18919385586"

UICorner.CornerRadius = UDim.new(0, 10) UICorner.Parent = ImageButton

ImageButton.MouseButton1Down:Connect(function() game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.End, false, game) end)

local Dropdown = Tabs.Main:AddDropdown("DropdownFPS", {
    Title = "Set Booster FPS",
    Values = {"60", "90", "120", "300"},
    Multi = false,
    Default = "120",
    Description = "Tăng FPS",
    Callback = function(selected)
        setfpscap(tonumber(selected))
    end
})
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
local textLabel = Instance.new("TextLabel")

screenGui.Parent = game.CoreGui
screenGui.DisplayOrder = 100

textLabel.Parent = screenGui
textLabel.Size = UDim2.new(0, 130, 0, 20)
textLabel.Position = UDim2.new(0, 35, 0, 35)
textLabel.Font = Enum.Font.FredokaOne
textLabel.TextScaled = true
textLabel.BackgroundTransparency = 1
textLabel.TextStrokeTransparency = 0
textLabel.Visible = false  -- Mặc định ẩn
textLabel.Active = true  -- Kích hoạt nhận input
textLabel.Text = "FPS: 999"
textLabel.TextXAlignment = Enum.TextXAlignment.Left  -- Căn chữ sang trái
textLabel.TextYAlignment = Enum.TextYAlignment.Center  -- Giữ chữ ở giữa theo chiều dọc

-- Hàm đổi màu cầu vồng
local function rainbowColor()
    local Dreamon = 0
    while true do
        Dreamon = Dreamon + 0.01
        if Dreamon > 1 then Dreamon = 0 end
        textLabel.TextColor3 = Color3.fromHSV(Dreamon, 1, 1) 
        RunService.RenderStepped:Wait()
    end
end

-- Cập nhật FPS
local frameCount = 0
local lastUpdate = tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 2
    local now = tick()

    if now - lastUpdate >= 1 then
        local fps = frameCount / (now - lastUpdate)
        frameCount = 0
        lastUpdate = now
        textLabel.Text = string.format("FPS: %d", math.floor(fps))
    end
end)

-- Thêm toggle bật/tắt FPS
local showFPSToggle = false
Tabs.Main:AddToggle("ToggleShowFPS", {
    Title = "Show FPS",
    Default = false,
    Description = "Hiển Thị FPS",
    Callback = function(state)
        showFPSToggle = state
        textLabel.Visible = state
    end
})

-- Tính năng kéo tùy chỉnh
local dragging, dragStart, startPos

textLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = textLabel.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

textLabel.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        textLabel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
spawn(rainbowColor)

----
Tabs.Main:AddButton({
    Title = "Fix Lag X1 | Booster",
    Description = "Xoá 40% Độ Họa",
    Callback = function()
        -- Xóa quần áo và phụ kiện để giảm lag
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("Accessory") then
                        v:Destroy()
                    end
                end
            end
        end
        
        game.StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Fix Lag X1",
        Text = "Xoá Đồ Với Xương Mù",
        Duration = 3
    })

        -- Tối ưu Lighting để giảm lag
        local c = game.Lighting  
        c.FogEnd = 100000  
        for _, v in pairs(c:GetDescendants()) do  
            if v:IsA("Atmosphere") then  
                v:Destroy()  
            end  
        end  

        -- Xóa các đối tượng trong workspace (trừ nhân vật)
        for _, obj in pairs(workspace:GetDescendants()) do
            local objectsToDelete = {
                "BigHouse", "Grass", "Tree", "Wood", "SmallHouse"
            }

            if obj:IsA("MeshPart") or table.find(objectsToDelete, obj.Name) then
                local character = game.Players:GetPlayerFromCharacter(obj.Parent)
                if not character then -- Chỉ xóa nếu không phải là nhân vật của người chơi
                    obj:Destroy()
                end
            end
        end
    end
})

Tabs.Main:AddButton({
    Title = "Fix Lag X2 | Booster",
    Description = "Xoá 50% Độ Họa",
    Callback = function()
        -- Xoá hiệu ứng Death và Spawn
        spawn(function()
            local container = game:GetService("ReplicatedStorage"):WaitForChild("Effect"):WaitForChild("Container")
            for _, effect in ipairs(container:GetChildren()) do
                local name = effect.Name
                if name == "Death" or name == "Spawn" then
                    pcall(function()
                        effect:Destroy()
                    end)
                end
            end
        end)

        -- Tắt hiệu ứng Particle, Trail, Explosion, Fire, SpotLight, Smoke
        spawn(function()
            for _, instance in pairs(game:GetDescendants()) do
                if instance:IsA("ParticleEmitter") or instance:IsA("Trail") then
                    instance.Lifetime = NumberRange.new(0)
                elseif instance:IsA("Explosion") then
                    instance.BlastPressure = 1
                    instance.BlastRadius = 1
                elseif instance:IsA("Fire") or instance:IsA("SpotLight") or instance:IsA("Smoke") then
                    instance.Enabled = false
                end
            end
        end)

        -- Xoá hiệu ứng nước và thay Water thành vật liệu khác
        spawn(function()
            for _, instance in pairs(game:GetDescendants()) do
                if instance:IsA("Texture") then
                    instance.Texture = ""
                elseif instance:IsA("BasePart") and instance.Material == Enum.Material.Water then
                    instance.Material = Enum.Material.SmoothPlastic
                end
            end
            game.StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Fix Lag X2",
        Text = "Xoá Đi Hiệu Ứng Skill",
        Duration = 3
    })
    
            for _, scriptInstance in pairs(game.Players.LocalPlayer.PlayerScripts:GetDescendants()) do
                local waterEffects = {
                    "WaterBlur",
                    "WaterEffect",
                    "WaterColorCorrection",
                    "WaterCFrame",
                    "MirageFog"
                }
                
                if table.find(waterEffects, scriptInstance.Name) then
                    scriptInstance:Destroy()
                end
            end
        end)
    end
})

Tabs.Main:AddButton({
    Title = "Fix Lag X3 | Booster",
    Description = "Xoá 60% Độ Họa",
    Callback = function()
    game.StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Fix Lag X3",
        Text = "Làm Độ Họa Đen Xì",
        Duration = 3
    })
    
        local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i,v in pairs(g:GetDescendants()) do
   if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
       v.Material = "Plastic"
v.Reflectance = 0
elseif v:IsA("Decal") and decalsyeeted then
v.Transparency = 1
elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
v.Lifetime = NumberRange.new(0)
elseif v:IsA("Explosion") then
v.BlastPressure = 1
v.BlastRadius = 1
   end
end
for i,e in pairs(l:GetChildren()) do
if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
e.Enabled = false
end
end
    end
})

Tabs.Main:AddButton({
    Title = "Fix Lag X4 | Booster",
    Description = "Xoá 70% Độ Họa",
    Callback = function()
    game.StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Fix Lag X4",
        Text = "Giảm Nhẹ Độ Họa",
        Duration = 3
    })
    
        for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
            obj.Material = Enum.Material.Concrete
            obj.Color = Color3.fromRGB(128, 128, 128)
            obj.Reflectance = 0
            obj.CastShadow = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
            obj:Destroy()
        end
    end
    game.Lighting.GlobalShadows = false
    game.Lighting.FogEnd = 1e10
    game.Lighting.FogStart = 1e10
    end
})

Tabs.Main:AddButton({
    Title = "Fix Lag X5 | Booster",
    Description = "Xoá 80% Độ Họa",
    Callback = function()
        local function FPSBooster()
            local decalsyeeted = true
            local g = game
            local w = g.Workspace
            local l = g.Lighting
            local t = w.Terrain
            
            sethiddenproperty(l, "Technology", Enum.Technology.Compatibility)
            sethiddenproperty(t, "Decoration", false)
            
            t.WaterWaveSize = 0
            t.WaterWaveSpeed = 0
            t.WaterReflectance = 0
            t.WaterTransparency = 0
            
            l.GlobalShadows = false
            l.FogEnd = 9e9
            l.Brightness = 0
            
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            
            for _, v in pairs(g:GetDescendants()) do
                if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                elseif v:IsA("Explosion") then
                    v.BlastPressure = 1
                    v.BlastRadius = 1
                elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
                elseif v:IsA("MeshPart") then
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                    v.TextureID = 10385902758728957 -- You might want to verify this TextureID
                end
            end
            game.StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Fix Lag X5",
        Text = "Xoá Đi Độ Họa",
        Duration = 3
    })
    
            for _, e in pairs(l:GetChildren()) do
                if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                    e.Enabled = false
                end
            end
        end
        
        FPSBooster()
    end
})

Tabs.Main:AddButton({
    Title = "Fix Lag X6 | Booster",
    Description = "Xoá 90% Độ Họa",
    Callback = function()
    game.StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Fix Lag X6",
        Text = "Xoá Siêu Mạnh Độ Họa",
        Duration = 3
    })
    
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("MeshPart") then
                local character = game.Players:GetPlayerFromCharacter(obj.Parent)
                if not character then -- Chỉ xóa nếu không thuộc về nhân vật
                    obj:Destroy()
                end
            end
        end
    end
})

-- 🚀 Walk Speed 
local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

-- Biến điều khiển
local WalkSpeedEnabled = false
local TargetWalkspeed = 100 -- Mặc định là tốc độ bình thường của Roblox

-- Toggle để bật/tắt WalkSpeed
local Toggle = Tabs.Farm:AddToggle("WalkSpeedToggle", { 
    Title = "Walk Speed", 
    Default = false,
    Description = "Chạy Nhanh" 
})

Toggle:OnChanged(function(Value)
    WalkSpeedEnabled = Value
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if Value then
            humanoid.WalkSpeed = TargetWalkspeed -- Áp dụng tốc độ khi bật
        else
            humanoid.WalkSpeed = 16 -- Reset về mặc định khi tắt
        end
    end
end)

-- Textbox để nhập tốc độ di chuyển
local WalkSpeedInput = Tabs.Farm:AddInput("WalkSpeedInput", {
    Title = "Walk Speed Value",
    Default = "100",
    Placeholder = "Value",
    Numeric = true, -- Chỉ cho phép nhập số
    Description = "Nhập Giá Trị"
})

WalkSpeedInput:OnChanged(function(Value)
    local speed = tonumber(Value)
    if speed and speed >= 10 and speed <= 50000 then -- Giới hạn hợp lý
        TargetWalkspeed = speed
        if WalkSpeedEnabled and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = TargetWalkspeed
        end
    end
end)

-- 🚀 Walk Speed: Cập nhật tốc độ khi di chuyển
runService.RenderStepped:Connect(function()
    if WalkSpeedEnabled then
        pcall(function()
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid.MoveDirection.Magnitude > 0 then
                    player.Character:TranslateBy(humanoid.MoveDirection * TargetWalkspeed / 100)
                end
            end
        end)
    end
end)

-- 🌟 Full Bright
local FullBrightEnabled = false
local Light = game.Lighting

-- 🔥 Toggle Full Bright
local ToggleFullBright = Tabs.Farm:AddToggle("FullBrightToggle", {
    Title = "Day Bright",
    Default = false,
    Description = "Chế Độ Sáng"
})

ToggleFullBright:OnChanged(function(Value)
    FullBrightEnabled = Value
    if FullBrightEnabled then
        doFullBright()
    else
        Light.Ambient = Color3.new(0, 0, 0)
        Light.ColorShift_Bottom = Color3.new(0, 0, 0)
        Light.ColorShift_Top = Color3.new(0, 0, 0)
        Light.FogEnd = 1000
        Light.FogStart = 0
        Light.ClockTime = 12
        Light.Brightness = 1
        Light.GlobalShadows = true
    end
end)

-- Hàm bật Full Bright
function doFullBright()
    Light.Ambient = Color3.new(1, 1, 1)
    Light.ColorShift_Bottom = Color3.new(1, 1, 1)
    Light.ColorShift_Top = Color3.new(1, 1, 1)
    Light.FogEnd = 100000
    Light.FogStart = 0
    Light.ClockTime = 14
    Light.Brightness = 2
    Light.GlobalShadows = false
end

-- 🎥 No Camera Shake
local NoCameraShakeEnabled = false

-- 🔥 Toggle No Camera Shake
local ToggleNoCameraShake = Tabs.Farm:AddToggle("NoCameraShakeToggle", {
    Title = "No Camera Shake",
    Default = false,
    Description = "Không Bị Rung Màn Hình"
})

ToggleNoCameraShake:OnChanged(function(Value)
    NoCameraShakeEnabled = Value
    if NoCameraShakeEnabled then
        disableCameraShake()
    end
end)

-- Hàm tắt rung màn hình
function disableCameraShake()
    local player = game.Players.LocalPlayer
    if player:FindFirstChild("PlayerScripts") and player.PlayerScripts:FindFirstChild("CameraShake") then
        player.PlayerScripts.CameraShake.Value = CFrame.new(0,0,0) * CFrame.new(0,0,0)
    end
end

local ToggleBone = Tabs.Farm:AddToggle("ToggleFast", {
    Title = "Fast Attack",
    Description = "Siêu Đánh Nhanh", 
    Default = false 
})

ToggleBone:OnChanged(function(State)
    if State then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/Artac.lua"))()
    end
end)

local Toggle = Tabs.Farm:AddToggle("Wak", {
    Title = "Walk on Water",
    Description = "Đi Trên Nước",
    Default = true
})

Toggle:OnChanged(function(Value)
    _G.Wak = Value
end)

spawn(function()
    while task.wait() do
        pcall(function()
            if _G.Wak then
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
            else
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
            end
        end)
    end
end)

--// Webhook 
local placeId = game.PlaceId
local jobId = game.JobId

local sea1 = 2753915549
local sea2 = 4442272183
local sea3 = 7449423635

local CheckSea
if placeId == sea1 then
    CheckSea = "Sea 1"
elseif placeId == sea2 then
    CheckSea = "Sea 2"
elseif placeId == sea3 then
    CheckSea = "Sea 3"
else
    CheckSea = "unknown sea"
end

local Players = game:GetService("Players")
local playerCount = #game:GetService("Players"):GetPlayers()

local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
local ExecutorUsing = identifyexecutor()
local HttpService = game:GetService("HttpService")
local Data =
{
    ["embeds"] = {
        {
            ["title"] = "**Script Fix Lag True V2**",  -- Thêm phần tiêu đề vào đây
            ["url"] = "https://www.roblox.com/users/"..game.Players.LocalPlayer.UserId,
            ["description"] = "",  -- Xóa phần hiển thị UserId
            ["color"] = tonumber("0xf7c74b"),
            ["thumbnail"] = {["url"] = "https://cdn.discordapp.com/attachments/1315892490351411251/1330807326428499968/Screenshot_2024-10-01-10-06-47-767_com.miui.gallery-edit.jpg?ex=678f5267&is=678e00e7&hm=9ec317e6698983fb3e98fc57c74535c93e96d14ade50b7a009d06a4653e65559&"},
            ["fields"] = {
                {
                    ["name"] = "Name:",
                    ["value"] = "```"..game.Players.LocalPlayer.DisplayName.."```",  -- Thêm tên người chơi vào đây
                    ["inline"] = true
                },
                {
                    ["name"] = "Acc:",
                    ["value"] = "```"..game.Players.LocalPlayer.Name.."```",  -- Thêm tên tài khoản vào đây
                    ["inline"] = true
                },
                {
                    ["name"] = "Execute:",
                    ["value"] = "```"..ExecutorUsing.."```",
                    ["inline"] = true
                },
                {
                    ["name"] = "Sea:",
                    ["value"] = "```" .. CheckSea.."```", 
                    ["inline"] = true
                }
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S") -- Thêm thời gian vào đây
        }
    }
}

local Headers = {["Content-Type"] = "application/json"}
local Encoded = HttpService:JSONEncode(Data)

local Request = http_request or request or HttpPost or syn.request
local Final = {Url = "https://discord.com/api/webhooks/1326033633273712692/xwG8JleuqGN3P5dzztmNSSLaaGF3AhIUz42EMlcI03vSEL-8SwLQIjmba0vtfyCB5Zgp", Body = Encoded, Method = "POST", Headers = Headers}
Request(Final)
