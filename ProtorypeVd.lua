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
Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(1, 0)  -- 100% bundar

-- Stroke berwarna (animasi)
local TabStroke = Instance.new("UIStroke", TabBtn)
TabStroke.Color = Color3.fromRGB(255, 105, 180)
TabStroke.Thickness = 2

-- Animasi warna stroke
task.spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        TabStroke.Color = Color3.fromHSV(hue, 0.6, 1)
    end
end)

EnableDrag(TabBtn)

-- ====== MAIN UI (KOTAK PERSEGI PANJANG) ======
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 0, 0, 0)  -- Mulai kecil
MainFrame.Position = UDim2.new(1, -370, 0, 80)  -- Pojok kanan atas
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Stroke utama (animasi)
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

-- ====== HEADER / JUDUL ======
local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundTransparency = 1
Header.Text = "BD PROJECT"
Header.TextColor3 = Color3.fromRGB(255, 105, 180)
Header.TextSize = 16
Header.Font = Enum.Font.SourceSansBold
Header.TextXAlignment = Enum.TextXAlignment.Center

-- Garis bawah header
local HeaderLine = Instance.new("Frame", MainFrame)
HeaderLine.Size = UDim2.new(0.95, 0, 0, 2)
HeaderLine.Position = UDim2.new(0.025, 0, 0, 35)
HeaderLine.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
HeaderLine.BackgroundTransparency = 0.5
HeaderLine.BorderSizePixel = 0

-- ====== TOMBOL TUTUP (X) ======
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
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)  -- Bundar

-- Hover effect
CloseBtn.MouseEnter:Connect(function()
    CloseBtn.BackgroundTransparency = 0.1
end)
CloseBtn.MouseLeave:Connect(function()
    CloseBtn.BackgroundTransparency = 0.3
end)

-- ====== PLACEHOLDER (KOSONG) ======
local Placeholder = Instance.new("TextLabel", MainFrame)
Placeholder.Size = UDim2.new(1, 0, 1, -45)
Placeholder.Position = UDim2.new(0, 0, 0, 40)
Placeholder.BackgroundTransparency = 1
Placeholder.Text = "⚙️ Fitur akan ditambahkan"
Placeholder.TextColor3 = Color3.fromRGB(150, 150, 150)
Placeholder.TextSize = 14
Placeholder.Font = Enum.Font.SourceSans
Placeholder.TextXAlignment = Enum.TextXAlignment.Center
Placeholder.TextYAlignment = Enum.TextYAlignment.Center

-- ====== FUNGSI BUKA/TUTUP ======
local isOpen = false

TabBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        MainFrame.Visible = true
        MainFrame:TweenSize(UDim2.new(0, 350, 0, 220), "Out", "Back", 0.4, true)
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