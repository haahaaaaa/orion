if game.PlaceId == 71895508397153 then
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "Die of Death Script", -- Required
		Text = "Script by obstruction_ on discord (me)", -- Required
		Icon = "rbxassetid://133992837986106" -- Optional
	})
else
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "Die of Death Script", -- Required
		Text = "You are not in Die of Death..", -- Required
		Icon = "rbxassetid://133992837986106" -- Optional
	})
	return
end

local killers = workspace:FindFirstChild("GameAssets"):FindFirstChild("Teams"):FindFirstChild("Killer")
local survivors = workspace:FindFirstChild("GameAssets"):FindFirstChild("Teams"):FindFirstChild("Survivor")
local other = workspace:FindFirstChild("GameAssets"):FindFirstChild("Teams"):FindFirstChild("Other")

local lighting = game:GetService("Lighting")
local runservice = game:GetService("RunService")
local players = game:GetService("Players")

print("Die of Death Script Loaded!!")

local function createESP(v, color)
	-- Try to get HumanoidRootPart and Humanoid safely
	local hrp = v:FindFirstChild("HumanoidRootPart")
	local hum = v:FindFirstChild("Humanoid")
	if not hrp or not hum then
		return
	end

	-- Remove old ESPNEW/ESPHP if they exist but are broken
	local oldBillboard = hrp:FindFirstChild("ESPNEW")
	if oldBillboard and not oldBillboard:IsA("BillboardGui") then
		oldBillboard:Destroy()
	end
	local oldHP = hrp:FindFirstChild("ESPHP")
	if oldHP and not oldHP:IsA("BillboardGui") then
		oldHP:Destroy()
	end

	-- Highlight
	if not v:FindFirstChild("ESPNEW") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "ESPNEW"
		highlight.Parent = v
		highlight.FillColor = color
		highlight.OutlineTransparency = 1
	end

	-- Name Billboard
	if not hrp:FindFirstChild("ESPNEW") then
		local billboard = Instance.new("BillboardGui")
		billboard.AlwaysOnTop = true
		billboard.Size = UDim2.new(0, 200, 0, 50)
		billboard.StudsOffset = Vector3.new(0, -2, 0)
		billboard.Parent = hrp
		billboard.Name = "ESPNEW"

		local text = Instance.new("TextLabel")
		text.Text = v.Name
		text.Size = UDim2.new(1, 0, 1, 0)
		text.BackgroundTransparency = 1
		text.TextColor3 = color
		text.TextSize = 20
		text.Font = Enum.Font.SourceSans
		text.TextStrokeColor3 = Color3.new(0, 0, 0)
		text.TextStrokeTransparency = 0
		text.Parent = billboard
	end

	-- Health Billboard
	if not hrp:FindFirstChild("ESPHP") then
		local hpb = Instance.new("BillboardGui")
		hpb.Name = "ESPHP"
		hpb.AlwaysOnTop = true
		hpb.Size = UDim2.new(0, 200, 0, 50)
		hpb.StudsOffset = Vector3.new(0, -3.5, 0)
		hpb.Parent = hrp

		local hpt = Instance.new("TextLabel")
		hpt.Text = tostring(math.round(hum.Health)).. "/".. tostring(hum.MaxHealth)
		hpt.Size = UDim2.new(1, 0, 1, 0)
		hpt.BackgroundTransparency = 1
		hpt.TextColor3 = color
		hpt.TextSize = 20
		hpt.Font = Enum.Font.SourceSans
		hpt.TextStrokeTransparency = 0
		hpt.TextStrokeColor3 = Color3.new(0, 0, 0)
		hpt.Parent = hpb
	end

	local hpGui = hrp:FindFirstChild("ESPHP")
	if hpGui and hpGui:FindFirstChildWhichIsA("TextLabel") then
		local hpt = hpGui:FindFirstChildWhichIsA("TextLabel")
		hpt.Text = tostring(math.round(hum.Health)).. "/".. tostring(hum.MaxHealth)
	end
end

local function createOtherESP(v, color)
	-- Try to get HumanoidRootPart if available
	local hrp = v:FindFirstChild("HumanoidRootPart")
	local attachTo = hrp or v

	-- Remove old ESPNEW if broken
	local oldBillboard = attachTo:FindFirstChild("ESPNEW")
	if oldBillboard and not oldBillboard:IsA("BillboardGui") then
		oldBillboard:Destroy()
	end

	-- Highlight
	if not v:FindFirstChild("ESPNEW") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "ESPNEW"
		highlight.Parent = v
		highlight.FillColor = color
		highlight.OutlineTransparency = 1
	end

	-- Name Billboard
	if not attachTo:FindFirstChild("ESPNEW") then
		local billboard = Instance.new("BillboardGui")
		billboard.AlwaysOnTop = true
		billboard.Size = UDim2.new(0, 200, 0, 50)
		billboard.StudsOffset = Vector3.new(0, -2, 0)
		billboard.Parent = attachTo
		billboard.Name = "ESPNEW"

		local text = Instance.new("TextLabel")
		text.Text = v.Name
		text.Size = UDim2.new(1, 0, 1, 0)
		text.BackgroundTransparency = 1
		text.TextColor3 = color
		text.TextSize = 20
		text.Font = Enum.Font.SourceSans
		text.TextStrokeColor3 = Color3.new(0, 0, 0)
		text.TextStrokeTransparency = 0
		text.Parent = billboard
	end
end

local function esp()
	-- Killers
	for i, v in killers:GetChildren() do
		createESP(v, Color3.fromRGB(255, 0, 0))
	end
	-- Survivors
	for i, v in survivors:GetChildren() do
		createESP(v, Color3.fromRGB(255, 255, 255))
	end
	-- Other
	for i, v in other:GetChildren() do
		createOtherESP(v, Color3.fromRGB(255, 255, 0))
	end

	lighting.Brightness = 2
	lighting.ClockTime = 14
	lighting.FogEnd = 100000
	lighting.GlobalShadows = false
	lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)

	lighting.FogEnd = 100000
	for k, v in lighting:GetDescendants() do
		if v:IsA("Atmosphere") then
			v:Destroy()
		end
	end
end

local function deathlog(plr)
	pcall(function()
		local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
		if hum then
			hum.Died:Connect(function()
				game:GetService("StarterGui"):SetCore("SendNotification",{
					Title = "Die of Death Script", -- Required
					Text = plr.Character.Name.. " (@"..players:GetPlayerFromCharacter(plr.Character).Name..") has died.", -- Required
					Icon = "rbxassetid://133992837986106" -- Optional
				})
			end)
		end
	end)
end

for k, v in players:GetPlayers() do
	deathlog(v)
	v.CharacterAdded:Connect(function()
		deathlog(v)
	end)
end

players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Wait()
	deathlog(plr)
	plr.CharacterAdded:Connect(function()
		deathlog(plr)
	end)
end)

runservice.RenderStepped:Connect(esp)
