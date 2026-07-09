-- ====== ANTI REDUNDANT ======
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("BD_UI") then CoreGui.BD_UI:Destroy() end
if CoreGui:FindFirstChild("BD_Toggle") then CoreGui.BD_Toggle:Destroy() end

-- ====== SCREEN GUI INDUK ======
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BD_UI"
ScreenGui.ResetOnSpawn = false

-- ====== FUNGSI DRAG ======
local function EnableDrag(gui)
    local dragging, dragStart, startPos
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

-- ====== TOMBOL TAB BD (KIRI) ======
local ToggleGui = Instance.new("ScreenGui", CoreGui)
ToggleGui.Name = "BD_Toggle"

local TabBtn = Instance.new("TextButton", ToggleGui)
TabBtn.Size = UDim2.new(0, 55, 0, 55)
TabBtn.Position = UDim2.new(0, 15, 0.5, -27.5)
TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TabBtn.Text = "BD"
TabBtn.TextColor3 = Color3.fromRGB(255, 105, 180)
TabBtn.TextSize = 22
TabBtn.Font = Enum.Font.SourceSansBold
TabBtn.BorderSizePixel = 0
Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(1, 0)

local TabStroke = Instance.new("UIStroke", TabBtn)
TabStroke.Color = Color3.fromRGB(255, 105, 180)
TabStroke.Thickness = 2

task.spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        TabStroke.Color = Color3.fromHSV(hue, 0.6, 1)
    end
end)

EnableDrag(TabBtn)

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

task.spawn(function()
    while task.wait() do
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
Header.Text = "BD PROJECT"
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

-- ====== LAYOUT SPLIT ======
-- Bagian Kiri (Sidebar) - 30% lebar
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 120, 1, -45)
Sidebar.Position = UDim2.new(0, 5, 0, 42)
Sidebar.BackgroundTransparency = 1
Sidebar.BorderSizePixel = 0

-- Garis pemisah vertikal
local Divider = Instance.new("Frame", MainFrame)
Divider.Size = UDim2.new(0, 2, 1, -55)
Divider.Position = UDim2.new(0, 128, 0, 45)
Divider.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
Divider.BackgroundTransparency = 0.3
Divider.BorderSizePixel = 0

-- Bagian Kanan (Content) - 70% lebar
local Content = Instance.new("Frame", MainFrame)
Content.Size = UDim2.new(1, -140, 1, -55)
Content.Position = UDim2.new(0, 135, 0, 45)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

-- ====== SCROLLING SIDEBAR (KIRI) ======
local SidebarScroll = Instance.new("ScrollingFrame", Sidebar)
SidebarScroll.Size = UDim2.new(1, 0, 1, 0)
SidebarScroll.Position = UDim2.new(0, 0, 0, 0)
SidebarScroll.BackgroundTransparency = 1
SidebarScroll.BorderSizePixel = 0
SidebarScroll.Active = true
SidebarScroll.ScrollBarThickness = 4
SidebarScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
SidebarScroll.CanvasSize = UDim2.new(0, 0, 3, 0)  -- Tinggi bisa di-scroll

local SidebarLayout = Instance.new("UIListLayout", SidebarScroll)
SidebarLayout.Padding = UDim.new(0, 5)

-- ====== SCROLLING CONTENT (KANAN) ======
local ContentScroll = Instance.new("ScrollingFrame", Content)
ContentScroll.Size = UDim2.new(1, 0, 1, 0)
ContentScroll.Position = UDim2.new(0, 0, 0, 0)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.Active = true
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
ContentScroll.CanvasSize = UDim2.new(0, 0, 2, 0)

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
    
    return btn
end

-- Buat tab "0. About" dan lainnya (placeholder)
local AboutTab = CreateSidebarItem("0. About")
local Tab1 = CreateSidebarItem("1. Player ESP")
local Tab2 = CreateSidebarItem("2. Survival")
local Tab3 = CreateSidebarItem("3. Smooth Maps")
local Tab4 = CreateSidebarItem("4. Settings")

-- ====== CONTENT PAGES ======
local function CreatePage()
    local frame = Instance.new("Frame", ContentScroll)
    frame.Size = UDim2.new(1, -10, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    
    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0, 5)
    
    return frame
end

local Page0 = CreatePage() -- About
local Page1 = CreatePage() -- Player ESP
local Page2 = CreatePage() -- Survival
local Page3 = CreatePage() -- Smooth Maps
local Page4 = CreatePage() -- Settings

-- ====== ISI PAGE 0 (ABOUT) ======
local AboutText = Instance.new("TextLabel", Page0)
AboutText.Size = UDim2.new(1, 0, 0, 180)
AboutText.BackgroundTransparency = 1
AboutText.Text = "📋 ABOUT\n\nCreator: BD Project\nVersion: v0.1\n\nFitur:\n- Auto Parry (Beta)\n- ESP Player\n- No Skill Check\n- Full Bright\n- No Fog\n- Potato Mode"
AboutText.TextColor3 = Color3.fromRGB(200, 200, 200)
AboutText.TextSize = 11
AboutText.Font = Enum.Font.SourceSansBold
AboutText.TextXAlignment = Enum.TextXAlignment.Left
AboutText.TextYAlignment = Enum.TextYAlignment.Top

-- ====== PLACEHOLDER UNTUK PAGE LAIN ======
local function CreatePlaceholder(page, text)
    local label = Instance.new("TextLabel", page)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(150, 150, 150)
    label.TextSize = 14
    label.Font = Enum.Font.SourceSans
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    return label
end

CreatePlaceholder(Page1, "⚙️ Player ESP Features\nComing Soon...")
CreatePlaceholder(Page2, "⚙️ Survival Features\nComing Soon...")
CreatePlaceholder(Page3, "⚙️ Smooth Maps Features\nComing Soon...")
CreatePlaceholder(Page4, "⚙️ Settings\nComing Soon...")

-- ====== TAB NAVIGATION ======
local currentPage = Page0
local currentTab = AboutTab

local function ShowPage(page, tab)
    -- Sembunyikan semua page
    Page0.Visible = false
    Page1.Visible = false
    Page2.Visible = false
    Page3.Visible = false
    Page4.Visible = false
    
    -- Reset semua tab
    for _, child in ipairs(SidebarScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            if child.UIStroke then
                child.UIStroke.Transparency = 0.5
            end
        end
    end
    
    -- Tampilkan page yang dipilih
    page.Visible = true
    tab.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    tab.BackgroundTransparency = 0.3
    if tab.UIStroke then
        tab.UIStroke.Transparency = 0
    end
    
    currentPage = page
    currentTab = tab
end

-- Koneksi klik tab
AboutTab.MouseButton1Click:Connect(function() ShowPage(Page0, AboutTab) end)
Tab1.MouseButton1Click:Connect(function() ShowPage(Page1, Tab1) end)
Tab2.MouseButton1Click:Connect(function() ShowPage(Page2, Tab2) end)
Tab3.MouseButton1Click:Connect(function() ShowPage(Page3, Tab3) end)
Tab4.MouseButton1Click:Connect(function() ShowPage(Page4, Tab4) end)

-- Tampilkan default
ShowPage(Page0, AboutTab)

-- ====== FUNGSI BUKA/TUTUP ======
local isOpen = false

TabBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        MainFrame.Visible = true
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 300), "Out", "Back", 0.4, true)
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    else
        MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true, function()
            MainFrame.Visible = false
        end)
        TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    isOpen = false
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true, function()
        MainFrame.Visible = false
    end)
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
end)