-- Ambil player
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ====== BUAT TAB UI (Bundar dengan tulisan BD) ======
local tabButton = Instance.new("ImageButton")
tabButton.Size = UDim2.new(0, 60, 0, 60)
tabButton.Position = UDim2.new(1, -80, 0, 20)  -- Pojok kanan atas
tabButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
tabButton.BackgroundTransparency = 0.2
tabButton.Image = "rbxassetid://"  -- Kosong, nanti pake background
tabButton.BorderSizePixel = 0
tabButton.Parent = playerGui

-- Bikin bentuk bundar pake Corner
local cornerTab = Instance.new("UICorner")
cornerTab.CornerRadius = UDim.new(1, 0)  -- 100% bundar
cornerTab.Parent = tabButton

-- Efek glow (opsional)
local glowTab = Instance.new("UIStroke")
glowTab.Color = Color3.fromRGB(255, 0, 0)
glowTab.Thickness = 2
glowTab.Transparency = 0.5
glowTab.Parent = tabButton

-- Teks "BD" di dalam tab
local tabText = Instance.new("TextLabel")
tabText.Size = UDim2.new(1, 0, 1, 0)
tabText.BackgroundTransparency = 1
tabText.Text = "BD"
tabText.TextColor3 = Color3.fromRGB(255, 255, 255)
tabText.TextScaled = true
tabText.Font = Enum.Font.GothamBold
tabText.Parent = tabButton

-- ====== BUAT MAIN UI (Kotak persegi panjang) ======
local mainUI = Instance.new("Frame")
mainUI.Size = UDim2.new(0, 320, 0, 450)
mainUI.Position = UDim2.new(1, -340, 0, 100)  -- Pojok kanan atas
mainUI.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainUI.BackgroundTransparency = 0.15
mainUI.BorderSizePixel = 0
mainUI.Visible = false  -- Sembunyiin dulu
mainUI.Parent = playerGui

-- Bikin sudut melengkung (sedikit)
local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 12)
cornerMain.Parent = mainUI

-- Efek stroke (garis tepi)
local strokeMain = Instance.new("UIStroke")
strokeMain.Color = Color3.fromRGB(100, 100, 255)
strokeMain.Thickness = 1.5
strokeMain.Transparency = 0.5
strokeMain.Parent = mainUI

-- ====== TOMBOL TUTUP (X) ======
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = mainUI

-- Bikin tombol X bundar
local cornerClose = Instance.new("UICorner")
cornerClose.CornerRadius = UDim.new(1, 0)
cornerClose.Parent = closeBtn

-- Efek hover tombol X
closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundTransparency = 0.1
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundTransparency = 0.3
end)

-- ====== JUDUL UI ======
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

-- ====== KOSONGKAN UNTUK FITUR NANTI ======
-- (Di sini nanti bisa ditambah tombol fitur, slider, dll)

-- Contoh placeholder (bisa dihapus nanti)
local placeholder = Instance.new("TextLabel")
placeholder.Size = UDim2.new(1, 0, 1, -50)
placeholder.Position = UDim2.new(0, 0, 0, 50)
placeholder.BackgroundTransparency = 1
placeholder.Text = "⚙️ Fitur akan ditambahkan"
placeholder.TextColor3 = Color3.fromRGB(150, 150, 150)
placeholder.TextScaled = true
placeholder.Font = Enum.Font.Gotham
placeholder.Parent = mainUI

-- ====== FUNGSI BUKA/TUTUP UI ======
local isOpen = false

-- Klik tab BD untuk buka UI
tabButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    mainUI.Visible = isOpen
    if isOpen then
        tabButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)  -- Hijau saat terbuka
        tabButton.BackgroundTransparency = 0.2
    else
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Merah saat tertutup
        tabButton.BackgroundTransparency = 0.2
    end
end)

-- Tombol X untuk tutup UI
closeBtn.MouseButton1Click:Connect(function()
    isOpen = false
    mainUI.Visible = false
    tabButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    tabButton.BackgroundTransparency = 0.2
end)

-- ====== DRAGGABLE (Bisa digeser) ======
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