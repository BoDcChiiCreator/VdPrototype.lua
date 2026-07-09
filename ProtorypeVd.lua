-- ====== AMBIL PLAYER ======
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ====== BUAT SCREEN GUI INDUK ======
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BD_UI"
screenGui.Parent = playerGui

-- ====== TAB UI (Bundar dengan tulisan BD) ======
local tabButton = Instance.new("ImageButton")
tabButton.Size = UDim2.new(0, 60, 0, 60)
tabButton.Position = UDim2.new(1, -80, 0, 20)
tabButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
tabButton.BackgroundTransparency = 0.2
tabButton.Image = ""
tabButton.BorderSizePixel = 0
tabButton.Parent = screenGui

-- Bikin bentuk bundar
local cornerTab = Instance.new("UICorner")
cornerTab.CornerRadius = UDim.new(1, 0)
cornerTab.Parent = tabButton

-- Teks "BD" di dalam tab
local tabText = Instance.new("TextLabel")
tabText.Size = UDim2.new(1, 0, 1, 0)
tabText.BackgroundTransparency = 1
tabText.Text = "BD"
tabText.TextColor3 = Color3.fromRGB(255, 255, 255)
tabText.TextScaled = true
tabText.Font = Enum.Font.GothamBold
tabText.Parent = tabButton

-- ====== MAIN UI (Kotak persegi panjang) ======
local mainUI = Instance.new("Frame")
mainUI.Size = UDim2.new(0, 320, 0, 450)
mainUI.Position = UDim2.new(1, -340, 0, 100)
mainUI.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainUI.BackgroundTransparency = 0.15
mainUI.BorderSizePixel = 0
mainUI.Visible = false
mainUI.Parent = screenGui

-- Bikin sudut melengkung
local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 12)
cornerMain.Parent = mainUI

-- ====== TOMBOL TUTUP (X) ======
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = mainUI

-- Bikin tombol X bundar
local cornerClose = Instance.new("UICorner")
cornerClose.CornerRadius = UDim.new(1, 0)
cornerClose.Parent = closeBtn

-- ====== JUDUL ======
local titleUI = Instance.new("TextLabel")
titleUI.Size = UDim2.new(1, 0, 0, 40)
titleUI.Position = UDim2.new(0, 0, 0, 0)
titleUI.BackgroundTransparency = 1
titleUI.Text = "VIOLENCE DISTRICT"
titleUI.TextColor3 = Color3.fromRGB(255, 255, 255)
titleUI.TextScaled = true
titleUI.Font = Enum.Font.GothamBold
titleUI.Parent = mainUI

-- Garis bawah judul
local line = Instance.new("Frame")
line.Size = UDim2.new(0.9, 0, 0, 2)
line.Position = UDim2.new(0.05, 0, 0, 40)
line.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
line.BackgroundTransparency = 0.5
line.Parent = mainUI

-- ====== PLACEHOLDER ======
local placeholder = Instance.new("TextLabel")
placeholder.Size = UDim2.new(1, 0, 1, -50)
placeholder.Position = UDim2.new(0, 0, 0, 50)
placeholder.BackgroundTransparency = 1
placeholder.Text = "⚙️ Fitur akan ditambahkan"
placeholder.TextColor3 = Color3.fromRGB(150, 150, 150)
placeholder.TextScaled = true
placeholder.Font = Enum.Font.Gotham
placeholder.Parent = mainUI

-- ====== FUNGSI BUKA/TUTUP ======
local isOpen = false

tabButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    mainUI.Visible = isOpen
    if isOpen then
        tabButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    isOpen = false
    mainUI.Visible = false
    tabButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end)

-- ====== DRAGGABLE ======
local dragging = false
local dragStart = nil
local startPos = nil

mainUI.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainUI.Position
    end
end)

mainUI.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainUI.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)