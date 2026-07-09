-- ====== ANTI REDUNDANT ======
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

if CoreGui:FindFirstChild("BD_UI") then CoreGui.BD_UI:Destroy() end
if CoreGui:FindFirstChild("BD_Toggle") then CoreGui.BD_Toggle:Destroy() end

-- ====== FUNGSI SUARA ======
local function PlaySound(soundId, volume, pitch)
    volume = volume or 0.3
    pitch = pitch or 1
    
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume
    sound.Pitch = pitch
    sound.Parent = CoreGui
    sound:Play()
    
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- Suara bawaan Roblox
local SOUNDS = {
    CLICK = "rbxasset://sounds/buttonclick.mp3",
    POP = "rbxasset://sounds/rewind.wav",
    ERROR = "rbxasset://sounds/error.mp3",
}

-- ====== SCREEN GUI INDUK ======
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BD_UI"
ScreenGui.ResetOnSpawn = false

-- ====== FUNGSI DRAG ======
local function EnableDrag(gui)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ====== TOMBOL TAB "BD" (KIRI) ======
local ToggleGui = Instance.new("ScreenGui", CoreGui)
ToggleGui.Name = "BD_Toggle"

local TabBtn = Instance.new("TextButton", ToggleGui)
TabBtn.Size = UDim2.new(0, 50, 0, 50)
TabBtn.Position = UDim2.new(0, 10, 0.5, -25)
TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TabBtn.Text = "BD"
TabBtn.TextColor3 = Color3.fromRGB(255, 105, 180)
TabBtn.TextSize = 18
TabBtn.Font = Enum.Font.SourceSansBold
TabBtn.BorderSizePixel = 0
Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(1, 0)

local TabStroke = Instance.new("UIStroke", TabBtn)
TabStroke.Color = Color3.fromRGB(255, 105, 180)
TabStroke.Thickness = 2

spawn(function()
    while wait() do
        local hue = tick() % 5 / 5
        TabStroke.Color = Color3.fromHSV(hue, 0.6, 1)
    end
end)

EnableDrag(TabBtn)

-- Suara klik tombol BD
TabBtn.MouseButton1Click:Connect(function()
    PlaySound(SOUNDS.CLICK, 0.2)
end)

-- ====== MAIN UI ======
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(1, -420, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 105, 180)
MainStroke.Thickness = 2

spawn(function()
    while wait() do
        local hue = tick() % 5 / 5
        MainStroke.Color = Color3.fromHSV(hue, 0.6, 1)
    end
end)

EnableDrag(MainFrame)

-- ====== HEADER ======
local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundTransparency = 1
Header.Text = "BoDcChii PROJECT"
Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.TextSize = 16
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Center

local HeaderLine = Instance.new("Frame", MainFrame)
HeaderLine.Size = UDim2.new(0.95, 0, 0, 2)
HeaderLine.Position = UDim2.new(0.025, 0, 0, 35)
HeaderLine.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
HeaderLine.BackgroundTransparency = 0.5
HeaderLine.BorderSizePixel = 0

-- ====== TOMBOL TUTUP ======
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

CloseBtn.MouseEnter:Connect(function()
    CloseBtn.BackgroundTransparency = 0.1
end)
CloseBtn.MouseLeave:Connect(function()
    CloseBtn.BackgroundTransparency = 0.3
end)

-- Suara klik tombol tutup
CloseBtn.MouseButton1Click:Connect(function()
    PlaySound(SOUNDS.CLICK, 0.2)
end)

-- ====== LAYOUT SPLIT ======
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 120, 1, -45)
Sidebar.Position = UDim2.new(0, 5, 0, 42)
Sidebar.BackgroundTransparency = 1
Sidebar.BorderSizePixel = 0

local Divider = Instance.new("Frame", MainFrame)
Divider.Size = UDim2.new(0, 2, 1, -55)
Divider.Position = UDim2.new(0, 128, 0, 45)
Divider.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
Divider.BackgroundTransparency = 0.3
Divider.BorderSizePixel = 0

local Content = Instance.new("Frame", MainFrame)
Content.Size = UDim2.new(1, -140, 1, -55)
Content.Position = UDim2.new(0, 135, 0, 45)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

-- ====== SCROLLING SIDEBAR ======
local SidebarScroll = Instance.new("ScrollingFrame", Sidebar)
SidebarScroll.Size = UDim2.new(1, 0, 1, 0)
SidebarScroll.Position = UDim2.new(0, 0, 0, 0)
SidebarScroll.BackgroundTransparency = 1
SidebarScroll.BorderSizePixel = 0
SidebarScroll.Active = true
SidebarScroll.ScrollBarThickness = 4
SidebarScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
SidebarScroll.CanvasSize = UDim2.new(0, 0, 2.5, 0)

local SidebarLayout = Instance.new("UIListLayout", SidebarScroll)
SidebarLayout.Padding = UDim.new(0, 5)

-- ====== SCROLLING CONTENT ======
local ContentScroll = Instance.new("ScrollingFrame", Content)
ContentScroll.Size = UDim2.new(1, 0, 1, 0)
ContentScroll.Position = UDim2.new(0, 0, 0, 0)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.Active = true
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
ContentScroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)

local ContentLayout = Instance.new("UIListLayout", ContentScroll)
ContentLayout.Padding = UDim.new(0, 5)

-- ====== SIDEBAR ITEMS ======
local function CreateSidebarItem(text)
    local btn = Instance.new("TextButton", SidebarScroll)
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.SourceSansBold
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 105, 180)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    
    btn.MouseButton1Click:Connect(function()
        PlaySound(SOUNDS.CLICK, 0.15)
    end)
    
    return btn
end

local AboutTab = CreateSidebarItem("0. About")
local Tab1 = CreateSidebarItem("1. Player ESP")
local Tab2 = CreateSidebarItem("2. Survival")

-- ====== CONTENT PAGES ======
local function CreatePage()
    local frame = Instance.new("Frame", ContentScroll)
    frame.Size = UDim2.new(1, -10, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    return frame
end

local Page0 = CreatePage()
local Page1 = CreatePage()
local Page2 = CreatePage()

-- ====== PAGE 0: ABOUT ======
local AboutFrame = Instance.new("Frame", Page0)
AboutFrame.Size = UDim2.new(1, 0, 1, 0)
AboutFrame.BackgroundTransparency = 1

local ProfileFrame = Instance.new("Frame", AboutFrame)
ProfileFrame.Size = UDim2.new(1, 0, 0, 100)
ProfileFrame.Position = UDim2.new(0, 0, 0, 0)
ProfileFrame.BackgroundTransparency = 1

local AvatarCircle = Instance.new("Frame", ProfileFrame)
AvatarCircle.Size = UDim2.new(0, 60, 0, 60)
AvatarCircle.Position = UDim2.new(0, 10, 0, 10)
AvatarCircle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
AvatarCircle.BackgroundTransparency = 0.3
Instance.new("UICorner", AvatarCircle).CornerRadius = UDim.new(1, 0)

local AvatarText = Instance.new("TextLabel", AvatarCircle)
AvatarText.Size = UDim2.new(1, 0, 1, 0)
AvatarText.BackgroundTransparency = 1
AvatarText.Text = "BD"
AvatarText.TextColor3 = Color3.fromRGB(255, 255, 255)
AvatarText.TextSize = 24
AvatarText.Font = Enum.Font.SourceSansBold

local CreatorName = Instance.new("TextLabel", ProfileFrame)
CreatorName.Size = UDim2.new(1, -80, 0, 25)
CreatorName.Position = UDim2.new(0, 80, 0, 10)
CreatorName.BackgroundTransparency = 1
CreatorName.Text = "BoDcChii"
CreatorName.TextColor3 = Color3.fromRGB(255, 105, 180)
CreatorName.TextSize = 18
CreatorName.Font = Enum.Font.SourceSansBold
CreatorName.TextXAlignment = Enum.TextXAlignment.Left

local CreatorSub = Instance.new("TextLabel", ProfileFrame)
CreatorSub.Size = UDim2.new(1, -80, 0, 20)
CreatorSub.Position = UDim2.new(0, 80, 0, 35)
CreatorSub.BackgroundTransparency = 1
CreatorSub.Text = "Creator & Developer"
CreatorSub.TextColor3 = Color3.fromRGB(180, 180, 180)
CreatorSub.TextSize = 12
CreatorSub.Font = Enum.Font.SourceSans
CreatorSub.TextXAlignment = Enum.TextXAlignment.Left

local CreatorSub2 = Instance.new("TextLabel", ProfileFrame)
CreatorSub2.Size = UDim2.new(1, -80, 0, 20)
CreatorSub2.Position = UDim2.new(0, 80, 0, 55)
CreatorSub2.BackgroundTransparency = 1
CreatorSub2.Text = "🎮 Roblox Scripter"
CreatorSub2.TextColor3 = Color3.fromRGB(150, 150, 150)
CreatorSub2.TextSize = 11
CreatorSub2.Font = Enum.Font.SourceSans
CreatorSub2.TextXAlignment = Enum.TextXAlignment.Left

local Line1 = Instance.new("Frame", AboutFrame)
Line1.Size = UDim2.new(0.95, 0, 0, 1)
Line1.Position = UDim2.new(0.025, 0, 0, 105)
Line1.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
Line1.BackgroundTransparency = 0.5
Line1.BorderSizePixel = 0

local ChannelFrame = Instance.new("Frame", AboutFrame)
ChannelFrame.Size = UDim2.new(1, 0, 0, 70)
ChannelFrame.Position = UDim2.new(0, 0, 0, 110)
ChannelFrame.BackgroundTransparency = 1

local ChannelLabel = Instance.new("TextLabel", ChannelFrame)
ChannelLabel.Size = UDim2.new(1, -20, 0, 20)
ChannelLabel.Position = UDim2.new(0, 10, 0, 0)
ChannelLabel.BackgroundTransparency = 1
ChannelLabel.Text = "📺 YouTube Channel"
ChannelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ChannelLabel.TextSize = 13
ChannelLabel.Font = Enum.Font.SourceSansBold
ChannelLabel.TextXAlignment = Enum.TextXAlignment.Left

local ChannelLink = Instance.new("TextLabel", ChannelFrame)
ChannelLink.Size = UDim2.new(1, -20, 0, 20)
ChannelLink.Position = UDim2.new(0, 10, 0, 22)
ChannelLink.BackgroundTransparency = 1
ChannelLink.Text = "@BoDcChii"
ChannelLink.TextColor3 = Color3.fromRGB(255, 200, 100)
ChannelLink.TextSize = 12
ChannelLink.Font = Enum.Font.SourceSans
ChannelLink.TextXAlignment = Enum.TextXAlignment.Left

local ChannelLink2 = Instance.new("TextLabel", ChannelFrame)
ChannelLink2.Size = UDim2.new(1, -20, 0, 20)
ChannelLink2.Position = UDim2.new(0, 10, 0, 42)
ChannelLink2.BackgroundTransparency = 1
ChannelLink2.Text = "🔗 https://youtube.com/@bodcchii"
ChannelLink2.TextColor3 = Color3.fromRGB(100, 150, 255)
ChannelLink2.TextSize = 10
ChannelLink2.Font = Enum.Font.SourceSans
ChannelLink2.TextXAlignment = Enum.TextXAlignment.Left

local Line2 = Instance.new("Frame", AboutFrame)
Line2.Size = UDim2.new(0.95, 0, 0, 1)
Line2.Position = UDim2.new(0.025, 0, 0, 185)
Line2.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
Line2.BackgroundTransparency = 0.5
Line2.BorderSizePixel = 0

local ScriptFrame = Instance.new("Frame", AboutFrame)
ScriptFrame.Size = UDim2.new(1, 0, 0, 60)
ScriptFrame.Position = UDim2.new(0, 0, 0, 190)
ScriptFrame.BackgroundTransparency = 1

local ScriptLabel = Instance.new("TextLabel", ScriptFrame)
ScriptLabel.Size = UDim2.new(1, -20, 0, 20)
ScriptLabel.Position = UDim2.new(0, 10, 0, 0)
ScriptLabel.BackgroundTransparency = 1
ScriptLabel.Text = "⚡ Script Info"
ScriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptLabel.TextSize = 13
ScriptLabel.Font = Enum.Font.SourceSansBold
ScriptLabel.TextXAlignment = Enum.TextXAlignment.Left

local ScriptInfo = Instance.new("TextLabel", ScriptFrame)
ScriptInfo.Size = UDim2.new(1, -20, 0, 30)
ScriptInfo.Position = UDim2.new(0, 10, 0, 22)
ScriptInfo.BackgroundTransparency = 1
ScriptInfo.Text = "📌 Script masih dalam tahap prototype.\nFitur akan segera hadir!"
ScriptInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
ScriptInfo.TextSize = 10
ScriptInfo.Font = Enum.Font.SourceSans
ScriptInfo.TextXAlignment = Enum.TextXAlignment.Left
ScriptInfo.TextYAlignment = Enum.TextYAlignment.Top

-- ====== PAGE 1: PLAYER ESP ======
local EspFrame = Instance.new("Frame", Page1)
EspFrame.Size = UDim2.new(1, 0, 1, 0)
EspFrame.BackgroundTransparency = 1

local espSurvival = false
local espKiller = false

local function ToggleESP(btn, state)
    state = not state
    if state then
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        btn.Text = "ON"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    return state
end

local function UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("BD_EspHighlight")
            
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "BD_EspHighlight"
                highlight.Parent = player.Character
            end
            
            local isKiller = false
            if player.Team and player.Team.Name:lower():find("kill") then
                isKiller = true
            elseif player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth > 100 then
                isKiller = true
            end
            
            if isKiller and espKiller then
                highlight.Enabled = true
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            elseif not isKiller and espSurvival then
                highlight.Enabled = true
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
            else
                highlight.Enabled = false
            end
        end
    end
end

local LabelSurv = Instance.new("TextLabel", EspFrame)
LabelSurv.Size = UDim2.new(1, -10, 0, 25)
LabelSurv.Position = UDim2.new(0, 5, 0, 5)
LabelSurv.BackgroundTransparency = 1
LabelSurv.Text = "ESP Survival"
LabelSurv.TextColor3 = Color3.fromRGB(0, 255, 0)
LabelSurv.TextSize = 14
LabelSurv.Font = Enum.Font.SourceSansBold
LabelSurv.TextXAlignment = Enum.TextXAlignment.Left

local EspSurvBtn = Instance.new("TextButton", EspFrame)
EspSurvBtn.Size = UDim2.new(0, 60, 0, 30)
EspSurvBtn.Position = UDim2.new(1, -65, 0, 5)
EspSurvBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
EspSurvBtn.Text = "OFF"
EspSurvBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspSurvBtn.TextSize = 14
EspSurvBtn.Font = Enum.Font.SourceSansBold
EspSurvBtn.BorderSizePixel = 0
Instance.new("UICorner", EspSurvBtn).CornerRadius = UDim.new(0, 6)

EspSurvBtn.MouseButton1Click:Connect(function()
    espSurvival = ToggleESP(EspSurvBtn, espSurvival)
    UpdateESP()
    PlaySound(SOUNDS.CLICK, 0.15)
end)

local LabelKill = Instance.new("TextLabel", EspFrame)
LabelKill.Size = UDim2.new(1, -10, 0, 25)
LabelKill.Position = UDim2.new(0, 5, 0, 40)
LabelKill.BackgroundTransparency = 1
LabelKill.Text = "ESP Killer"
LabelKill.TextColor3 = Color3.fromRGB(255, 0, 0)
LabelKill.TextSize = 14
LabelKill.Font = Enum.Font.SourceSansBold
LabelKill.TextXAlignment = Enum.TextXAlignment.Left

local EspKillBtn = Instance.new("TextButton", EspFrame)
EspKillBtn.Size = UDim2.new(0, 60, 0, 30)
EspKillBtn.Position = UDim2.new(1, -65, 0, 40)
EspKillBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
EspKillBtn.Text = "OFF"
EspKillBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspKillBtn.TextSize = 14
EspKillBtn.Font = Enum.Font.SourceSansBold
EspKillBtn.BorderSizePixel = 0
Instance.new("UICorner", EspKillBtn).CornerRadius = UDim.new(0, 6)

EspKillBtn.MouseButton1Click:Connect(function()
    espKiller = ToggleESP(EspKillBtn, espKiller)
    UpdateESP()
    PlaySound(SOUNDS.CLICK, 0.15)
end)

spawn(function()
    while wait(0.5) do
        if espSurvival or espKiller then
            UpdateESP()
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        local highlight = player.Character:FindFirstChild("BD_EspHighlight")
        if highlight then highlight:Destroy() end
    end
end)

-- ====== PAGE 2: SURVIVAL (Auto Perfect Generator & Anti Fail - FIXED) ======
local SurvFrame = Instance.new("Frame", Page2)
SurvFrame.Size = UDim2.new(1, 0, 1, 0)
SurvFrame.BackgroundTransparency = 1

local autoPerfect = false
local antiFail = false

local function ToggleSurv(btn, state)
    state = not state
    if state then
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        btn.Text = "ON"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    return state
end

-- AUTO PERFECT GENERATOR
local LabelPerfect = Instance.new("TextLabel", SurvFrame)
LabelPerfect.Size = UDim2.new(1, -10, 0, 25)
LabelPerfect.Position = UDim2.new(0, 5, 0, 5)
LabelPerfect.BackgroundTransparency = 1
LabelPerfect.Text = "Auto Perfect Generator"
LabelPerfect.TextColor3 = Color3.fromRGB(0, 255, 200)
LabelPerfect.TextSize = 13
LabelPerfect.Font = Enum.Font.SourceSansBold
LabelPerfect.TextXAlignment = Enum.TextXAlignment.Left

local PerfectBtn = Instance.new("TextButton", SurvFrame)
PerfectBtn.Size = UDim2.new(0, 60, 0, 30)
PerfectBtn.Position = UDim2.new(1, -65, 0, 5)
PerfectBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
PerfectBtn.Text = "OFF"
PerfectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PerfectBtn.TextSize = 14
PerfectBtn.Font = Enum.Font.SourceSansBold
PerfectBtn.BorderSizePixel = 0
Instance.new("UICorner", PerfectBtn).CornerRadius = UDim.new(0, 6)

PerfectBtn.MouseButton1Click:Connect(function()
    autoPerfect = ToggleSurv(PerfectBtn, autoPerfect)
    PlaySound(SOUNDS.CLICK, 0.15)
end)

-- ANTI FAIL GENERATOR
local LabelAntiFail = Instance.new("TextLabel", SurvFrame)
LabelAntiFail.Size = UDim2.new(1, -10, 0, 25)
LabelAntiFail.Position = UDim2.new(0, 5, 0, 40)
LabelAntiFail.BackgroundTransparency = 1
LabelAntiFail.Text = "Anti Fail Generator"
LabelAntiFail.TextColor3 = Color3.fromRGB(255, 200, 0)
LabelAntiFail.TextSize = 13
LabelAntiFail.Font = Enum.Font.SourceSansBold
LabelAntiFail.TextXAlignment = Enum.TextXAlignment.Left

local AntiFailBtn = Instance.new("TextButton", SurvFrame)
AntiFailBtn.Size = UDim2.new(0, 60, 0, 30)
AntiFailBtn.Position = UDim2.new(1, -65, 0, 40)
AntiFailBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
AntiFailBtn.Text = "OFF"
AntiFailBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiFailBtn.TextSize = 14
AntiFailBtn.Font = Enum.Font.SourceSansBold
AntiFailBtn.BorderSizePixel = 0
Instance.new("UICorner", AntiFailBtn).CornerRadius = UDim.new(0, 6)

AntiFailBtn.MouseButton1Click:Connect(function()
    antiFail = ToggleSurv(AntiFailBtn, antiFail)
    PlaySound(SOUNDS.CLICK, 0.15)
end)

local InfoSurv = Instance.new("TextLabel", SurvFrame)
InfoSurv.Size = UDim2.new(1, -10, 0, 40)
InfoSurv.Position = UDim2.new(0, 5, 0, 75)
InfoSurv.BackgroundTransparency = 1
InfoSurv.Text = "⚡ Auto Perfect = Skill check selalu sempurna\n🛡️ Anti Fail = Generator tidak pernah meledak"
InfoSurv.TextColor3 = Color3.fromRGB(150, 150, 150)
InfoSurv.TextSize = 10
InfoSurv.Font = Enum.Font.SourceSans
InfoSurv.TextXAlignment = Enum.TextXAlignment.Left
InfoSurv.TextYAlignment = Enum.TextYAlignment.Top

-- ====== LOGIKA AUTO PERFECT & ANTI FAIL (FIXED) ======

-- Fungsi untuk mencari dan mengirim success ke generator
local function SendGeneratorSuccess()
    pcall(function()
        -- Cari semua RemoteEvent di workspace
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                local name = obj.Name:lower()
                -- Cari event yang berhubungan dengan generator/skillcheck
                if name:find("skill") or name:find("generator") or name:find("gen") or name:find("success") or name:find("complete") or name:find("done") then
                    pcall(function()
                        obj:FireServer()
                    end)
                end
            end
        end
    end)
end

-- Fungsi untuk force stop generator (biar gak stuck)
local function ForceStopGenerator()
    pcall(function()
        local player = Players.LocalPlayer
        if player and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                -- Force stop semua animasi
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
            -- Reset velocity biar bisa gerak
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end
    end)
end

-- AUTO PERFECT - Loop sangat cepat
spawn(function()
    while wait(0.03) do
        if autoPerfect then
            SendGeneratorSuccess()
        end
    end
end)

-- ANTI FAIL - Cegah fail/explode
local mt = getrawmetatable(game)
if mt then
    local old = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        
        if (autoPerfect or antiFail) and (method == "FireServer" or method == "InvokeServer") then
            local selfStr = tostring(self):lower()
            
            -- Cegah fail/explode
            if antiFail and (selfStr:find("fail") or selfStr:find("explode") or selfStr:find("skillcheck")) then
                -- Kirim success biar state selesai
                pcall(function()
                    if self and self.Parent then
                        local successEvent = self.Parent:FindFirstChild("Success") or self.Parent:FindFirstChild("Complete") or self.Parent:FindFirstChild("Done")
                        if successEvent and successEvent:IsA("RemoteEvent") then
                            successEvent:FireServer()
                        end
                    end
                end)
                -- Force stop generator biar gak stuck
                ForceStopGenerator()
                return nil
            end
            
            -- Auto Perfect - selalu success
            if autoPerfect and (selfStr:find("skill") or selfStr:find("generator") or selfStr:find("gen")) then
                pcall(function()
                    if self and self.Parent then
                        local successEvent = self.Parent:FindFirstChild("Success") or self.Parent:FindFirstChild("Complete") or self.Parent:FindFirstChild("Done")
                        if successEvent and successEvent:IsA("RemoteEvent") then
                            successEvent:FireServer()
                        end
                    end
                end)
                return nil
            end
        end
        
        return old(self, ...)
    end)
    
    setreadonly(mt, true)
end

-- ANTI FAIL - Backup loop
spawn(function()
    while wait(0.1) do
        if antiFail then
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("RemoteEvent") then
                        local name = obj.Name:lower()
                        if name:find("fail") or name:find("explode") then
                            local parent = obj.Parent
                            if parent then
                                local success = parent:FindFirstChild("Success") or parent:FindFirstChild("Complete") or parent:FindFirstChild("Done")
                                if success and success:IsA("RemoteEvent") then
                                    success:FireServer()
                                end
                            end
                        end
                    end
                end
                -- Force stop generator
                ForceStopGenerator()
            end)
        end
        wait(0.5)
    end
end)

-- AUTO PERFECT - Backup force stop
spawn(function()
    while wait(0.1) do
        if autoPerfect then
            -- Kirim success terus menerus
            SendGeneratorSuccess()
            -- Force stop biar gak stuck
            ForceStopGenerator()
        end
        wait(0.2)
    end
end)
-- ====== TAB NAVIGATION ======
local function ShowPage(page, tab)
    Page0.Visible = false
    Page1.Visible = false
    Page2.Visible = false
    
    for _, child in ipairs(SidebarScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            if child.UIStroke then
                child.UIStroke.Transparency = 0.5
            end
        end
    end
    
    page.Visible = true
    tab.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    tab.BackgroundTransparency = 0.3
    if tab.UIStroke then
        tab.UIStroke.Transparency = 0
    end
    
    PlaySound(SOUNDS.POP, 0.15)
end

AboutTab.MouseButton1Click:Connect(function() ShowPage(Page0, AboutTab) end)
Tab1.MouseButton1Click:Connect(function() ShowPage(Page1, Tab1) end)
Tab2.MouseButton1Click:Connect(function() ShowPage(Page2, Tab2) end)

ShowPage(Page0, AboutTab)

-- ====== FUNGSI BUKA/TUTUP ======
local isOpen = false

TabBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        MainFrame.Visible = true
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 280), "Out", "Back", 0.4, true)
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        PlaySound(SOUNDS.POP, 0.3)
    else
        MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true, function()
            MainFrame.Visible = false
        end)
        TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        PlaySound(SOUNDS.CLICK, 0.2)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    isOpen = false
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true, function()
        MainFrame.Visible = false
    end)
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    PlaySound(SOUNDS.CLICK, 0.2)
end)