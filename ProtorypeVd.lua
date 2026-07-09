-- ====== ANTI REDUNDANT ======
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

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
    
    -- Suara klik untuk setiap tab
    btn.MouseButton1Click:Connect(function()
        PlaySound(SOUNDS.CLICK, 0.15)
    end)
    
    return btn
end

local AboutTab = CreateSidebarItem("0. About")
local Tab1 = CreateSidebarItem("1. Player ESP")
local Tab2 = CreateSidebarItem("2. Survival")
local Tab4 = CreateSidebarItem("3. Settings")

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
local Page4 = CreatePage()

-- ====== PAGE 0: ABOUT ======
local AboutFrame = Instance.new("Frame", Page0)
AboutFrame.Size = UDim2.new(1, 0, 1, 0)
AboutFrame.BackgroundTransparency = 1

-- Profile Section
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

-- Info Channel
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

-- Info Script
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

-- Variabel ESP
local espSurvival = false
local espKiller = false

-- Fungsi toggle dengan warna ON=Hijau, OFF=Merah
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

-- Fungsi update ESP
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

-- Label "ESP Survival"
local LabelSurv = Instance.new("TextLabel", EspFrame)
LabelSurv.Size = UDim2.new(1, -10, 0, 25)
LabelSurv.Position = UDim2.new(0, 5, 0, 5)
LabelSurv.BackgroundTransparency = 1
LabelSurv.Text = "ESP Survival"
LabelSurv.TextColor3 = Color3.fromRGB(0, 255, 0)
LabelSurv.TextSize = 14
LabelSurv.Font = Enum.Font.SourceSansBold
LabelSurv.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol ON/OFF ESP Survival
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

-- Label "ESP Killer"
local LabelKill = Instance.new("TextLabel", EspFrame)
LabelKill.Size = UDim2.new(1, -10, 0, 25)
LabelKill.Position = UDim2.new(0, 5, 0, 40)
LabelKill.BackgroundTransparency = 1
LabelKill.Text = "ESP Killer"
LabelKill.TextColor3 = Color3.fromRGB(255, 0, 0)
LabelKill.TextSize = 14
LabelKill.Font = Enum.Font.SourceSansBold
LabelKill.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol ON/OFF ESP Killer
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

-- Update ESP otomatis
spawn(function()
    while wait(0.5) do
        if espSurvival or espKiller then
            UpdateESP()
        end
    end
end)

-- Cleanup saat player keluar
Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        local highlight = player.Character:FindFirstChild("BD_EspHighlight")
        if highlight then highlight:Destroy() end
    end
end)

-- ====== PAGE 2: SURVIVAL (Placeholder) ======
local SurvFrame = Instance.new("Frame", Page2)
SurvFrame.Size = UDim2.new(1, 0, 1, 0)
SurvFrame.BackgroundTransparency = 1

local SurvPlaceholder = Instance.new("TextLabel", SurvFrame)
SurvPlaceholder.Size = UDim2.new(1, 0, 1, 0)
SurvPlaceholder.BackgroundTransparency = 1
SurvPlaceholder.Text = "⚙️ Survival Features\nComing Soon..."
SurvPlaceholder.TextColor3 = Color3.fromRGB(150, 150, 150)
SurvPlaceholder.TextSize = 14
SurvPlaceholder.Font = Enum.Font.SourceSans
SurvPlaceholder.TextXAlignment = Enum.TextXAlignment.Center
SurvPlaceholder.TextYAlignment = Enum.TextYAlignment.Center

-- ====== PAGE 4: SETTINGS (Low Graphics Mode) ======
local SettingsFrame = Instance.new("Frame", Page4)
SettingsFrame.Size = UDim2.new(1, 0, 1, 0)
SettingsFrame.BackgroundTransparency = 1

-- Variabel Low Graphics
local lowGraphics = false
local savedParts = {}

-- Fungsi toggle dengan warna ON=Hijau, OFF=Merah
local function ToggleSettings(btn, state)
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

-- Fungsi Low Graphics (Hapus Detail Maps, bukan ubah warna)
local function ApplyLowGraphics(state)
    if state then
        for _, obj in pairs(Workspace:GetDescendants()) do
            -- Cek apakah objek adalah Generator atau Pallet
            local isGenerator = obj.Name:lower():find("generator") or obj.Name:lower():find("gen") or obj:FindFirstAncestor("Generator")
            local isPallet = obj.Name:lower():find("pallet") or obj:FindFirstAncestor("Pallet")
            local isPlayer = obj:FindFirstAncestorOfClass("Model") and Players:GetPlayerFromCharacter(obj:FindFirstAncestorOfClass("Model"))
            
            -- Lewati Generator, Pallet, dan Player
            if isGenerator or isPallet or isPlayer then
                continue
            end
            
            -- Hapus detail part (BasePart)
            if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                if not savedParts[obj] then
                    savedParts[obj] = {
                        Material = obj.Material,
                        Color = obj.Color,
                        Transparency = obj.Transparency,
                        Reflectance = obj.Reflectance
                    }
                end
                -- Jadikan transparan/hampir tidak terlihat
                obj.Material = Enum.Material.ForceField
                obj.Transparency = 0.9
                obj.Reflectance = 0
                
            -- Hapus Texture/Decal
            elseif obj:IsA("Texture") or obj:IsA("Decal") then
                if not savedParts[obj] then
                    savedParts[obj] = {
                        Transparency = obj.Transparency
                    }
                end
                obj.Transparency = 1
                
            -- Matikan efek
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                if not savedParts[obj] then
                    savedParts[obj] = {
                        Enabled = obj.Enabled
                    }
                end
                obj.Enabled = false
                
            -- Hapus efek cahaya
            elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                if not savedParts[obj] then
                    savedParts[obj] = {
                        Enabled = obj.Enabled
                    }
                end
                obj.Enabled = false
            end
        end
    else
        -- Kembalikan semua yang sudah disimpan
        for obj, data in pairs(savedParts) do
            if obj and obj.Parent then
                if obj:IsA("BasePart") then
                    obj.Material = data.Material
                    obj.Color = data.Color
                    obj.Transparency = data.Transparency
                    obj.Reflectance = data.Reflectance
                elseif obj:IsA("Texture") or obj:IsA("Decal") then
                    obj.Transparency = data.Transparency
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                    obj.Enabled = data.Enabled
                elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                    obj.Enabled = data.Enabled
                end
            end
        end
        savedParts = {}
    end
end

-- Label "Low Graphics Mode"
local LabelLow = Instance.new("TextLabel", SettingsFrame)
LabelLow.Size = UDim2.new(1, -10, 0, 25)
LabelLow.Position = UDim2.new(0, 5, 0, 5)
LabelLow.BackgroundTransparency = 1
LabelLow.Text = "Low Graphics Mode"
LabelLow.TextColor3 = Color3.fromRGB(180, 180, 180)
LabelLow.TextSize = 14
LabelLow.Font = Enum.Font.SourceSansBold
LabelLow.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol ON/OFF Low Graphics
local LowBtn = Instance.new("TextButton", SettingsFrame)
LowBtn.Size = UDim2.new(0, 60, 0, 30)
LowBtn.Position = UDim2.new(1, -65, 0, 5)
LowBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
LowBtn.Text = "OFF"
LowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LowBtn.TextSize = 14
LowBtn.Font = Enum.Font.SourceSansBold
LowBtn.BorderSizePixel = 0
Instance.new("UICorner", LowBtn).CornerRadius = UDim.new(0, 6)

LowBtn.MouseButton1Click:Connect(function()
    lowGraphics = ToggleSettings(LowBtn, lowGraphics)
    ApplyLowGraphics(lowGraphics)
    PlaySound(SOUNDS.CLICK, 0.15)
end)

-- Info Low Graphics
local InfoLow = Instance.new("TextLabel", SettingsFrame)
InfoLow.Size = UDim2.new(1, -10, 0, 40)
InfoLow.Position = UDim2.new(0, 5, 0, 40)
InfoLow.BackgroundTransparency = 1
InfoLow.Text = "🔘 Menghilangkan detail maps (warna, tekstur, efek)\n🔘 Generator dan Pallet tetap terlihat"
InfoLow.TextColor3 = Color3.fromRGB(150, 150, 150)
InfoLow.TextSize = 11
InfoLow.Font = Enum.Font.SourceSans
InfoLow.TextXAlignment = Enum.TextXAlignment.Left
InfoLow.TextYAlignment = Enum.TextYAlignment.Top

-- ====== TAB NAVIGATION ======
local function ShowPage(page, tab)
    Page0.Visible = false
    Page1.Visible = false
    Page2.Visible = false
    Page4.Visible = false
    
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
Tab4.MouseButton1Click:Connect(function() ShowPage(Page4, Tab4) end)

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