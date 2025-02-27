--// Menu Loading
-- HAS NOT SOLARA SUPPORT!

local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local pcall, getgenv, next, setmetatable, Vector2new, CFramenew, Color3fromRGB, Drawingnew, TweenInfonew, stringupper, mousemoverel = pcall, getgenv, next, setmetatable, Vector2.new, CFrame.new, Color3.fromRGB, Drawing.new, TweenInfo.new, string.upper, mousemoverel or (Input and Input.MouseMove)

local HighlightEnabled = false
local TeamCheckEnabled = false
local AutoTeamColorEnabled = false
local FillColor = Color3.new(1, 0, 0) 
local OutlineColor = Color3.new(1, 1, 1) 
local FillTransparency = 0.5 
local OutlineTransparency = 0.3 

local hitboxEnabled = false
local hitboxSize = 5
local hitboxTransparency = 0.7
local hitboxTeamCheckEnabled = false
local hitboxTargetPart = "HumanoidRootPart"

local RequiredDistance, Typing, Running, ServiceConnections, Animation, OriginalSensitivity = 2000, false, false, {}

if not getgenv().IAHub then getgenv().IAHub = {} end
if getgenv().IAHub.Aimbot then return end

getgenv().IAHub.Aimbot = {
	Settings = {
		Enabled = false,
		TeamCheck = false,
		AliveCheck = true,
		WallCheck = false,
		Sensitivity = 0,
		ThirdPerson = false,
		ThirdPersonSensitivity = 3,
		TriggerKey = "MouseButton2",
		Toggle = false,
		LockPart = "Head"
	},

	FOVSettings = {
		Enabled = false,
		Visible = false,
		Amount = 90,
		Color = Color3fromRGB(255, 255, 255),
		LockedColor = Color3fromRGB(255, 70, 70),
		Transparency = 0.5,
		Sides = 60,
		Thickness = 1,
		Filled = false
	},

	FOVCircle = Drawingnew("Circle")
}

local Environment = getgenv().IAHub.Aimbot

local function IsSameTeam(player)
    if TeamCheckEnabled then
        return player.TeamColor == LocalPlayer.TeamColor
    end
    return false
end

local function ToggleHighlight(enable)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character or player.CharacterAdded:Wait()
            if character then
                local highlight = character:FindFirstChild("Highlight")
                if enable and not IsSameTeam(player) then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "Highlight"
                        highlight.Parent = character
                    end
                    if AutoTeamColorEnabled then
                        highlight.FillColor = player.TeamColor.Color
                    else
                        highlight.FillColor = FillColor
                    end
                    highlight.OutlineColor = OutlineColor
                    highlight.FillTransparency = FillTransparency
                    highlight.OutlineTransparency = OutlineTransparency
                else
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end
    end
end

local function ToggleAutoTeamColor(enable)
    AutoTeamColorEnabled = enable
    ToggleHighlight(HighlightEnabled) 
end

function isPlayerOnSameTeam(player)
    if hitboxTeamCheckEnabled and player.Team == LocalPlayer.Team then
        return true
    end
    return false
end

function resetHitbox(part)
    if part and part:IsA("BasePart") then
        if part:FindFirstChild("OriginalSize") then
            part.Size = part.OriginalSize.Value
            part.OriginalSize:Destroy()
        end
        if part.Name == "HumanoidRootPart" then
            part.Transparency = 1
        else
            part.Transparency = 0
        end
        part.CanCollide = true
    end
end

function updateHitbox(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")

    if hitboxEnabled then
        if hitboxTargetPart == "HumanoidRootPart" and humanoidRootPart then
            if head then resetHitbox(head) end
            if not humanoidRootPart:FindFirstChild("OriginalSize") then
                local hitboxOriginalSize = Instance.new("Vector3Value")
                hitboxOriginalSize.Name = "OriginalSize"
                hitboxOriginalSize.Value = humanoidRootPart.Size
                hitboxOriginalSize.Parent = humanoidRootPart
            end
            humanoidRootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
            humanoidRootPart.Transparency = hitboxTransparency
            humanoidRootPart.CanCollide = true
        elseif hitboxTargetPart == "Head" and head then
            if humanoidRootPart then resetHitbox(humanoidRootPart) end
            if not head:FindFirstChild("OriginalSize") or head.Size == head.OriginalSize.Value or head.Transparency == 0 then
                local hitboxOriginalSize = Instance.new("Vector3Value")
                hitboxOriginalSize.Name = "OriginalSize"
                hitboxOriginalSize.Value = head.Size
                hitboxOriginalSize.Parent = head
            end
            head.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
            head.Transparency = hitboxTransparency
            head.CanCollide = false
            head.CanCollide = false
            head.Massless = true
            
            if humanoidRootPart then
                humanoidRootPart.CanCollide = false
            end
        end
    else
        if humanoidRootPart then resetHitbox(humanoidRootPart) end
        if head then resetHitbox(head) end
    end
end

function expandHitbox(character)
    local player = Players:GetPlayerFromCharacter(character)
    if not player or player == LocalPlayer then
        return
    end
    if isPlayerOnSameTeam(player) then
        resetHitbox(character:FindFirstChild("HumanoidRootPart"))
        resetHitbox(character:FindFirstChild("Head"))
        return
    end
    updateHitbox(character)
end

function updateAllHitboxes()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player ~= LocalPlayer then
            expandHitbox(player.Character)
        end
    end
end


local function ConvertVector(Vector)
	return Vector2new(Vector.X, Vector.Y)
end

local function CancelLock()
	Environment.Locked = nil
	Environment.FOVCircle.Color = Environment.FOVSettings.Color
	UserInputService.MouseDeltaSensitivity = OriginalSensitivity

	if Animation then
		Animation:Cancel()
	end
end

local function GetClosestPlayer()
	if not Environment.Locked then
		RequiredDistance = (Environment.FOVSettings.Enabled and Environment.FOVSettings.Amount or 2000)

		for _, v in next, Players:GetPlayers() do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(Environment.Settings.LockPart) and v.Character:FindFirstChildOfClass("Humanoid") then
				if Environment.Settings.TeamCheck and v.TeamColor == LocalPlayer.TeamColor then continue end
				if Environment.Settings.AliveCheck and v.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end
				if Environment.Settings.WallCheck and #(Camera:GetPartsObscuringTarget({v.Character[Environment.Settings.LockPart].Position}, v.Character:GetDescendants())) > 0 then continue end

				local Vector, OnScreen = Camera:WorldToViewportPoint(v.Character[Environment.Settings.LockPart].Position); Vector = ConvertVector(Vector)
				local Distance = (UserInputService:GetMouseLocation() - Vector).Magnitude

				if Distance < RequiredDistance and OnScreen then
					RequiredDistance = Distance
					Environment.Locked = v
				end
			end
		end
	elseif (UserInputService:GetMouseLocation() - ConvertVector(Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position))).Magnitude > RequiredDistance then
		CancelLock()
	end
end

local function Load()
	OriginalSensitivity = UserInputService.MouseDeltaSensitivity

	ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
		if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
			Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
			Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
			Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
			Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
			Environment.FOVCircle.Color = Environment.FOVSettings.Color
			Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
			Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
			Environment.FOVCircle.Position = Vector2new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
		else
			Environment.FOVCircle.Visible = false
		end

		if Running and Environment.Settings.Enabled then
			GetClosestPlayer()

			if Environment.Locked then
				if Environment.Settings.ThirdPerson then
					local Vector = Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position)

					mousemoverel((Vector.X - UserInputService:GetMouseLocation().X) * Environment.Settings.ThirdPersonSensitivity, (Vector.Y - UserInputService:GetMouseLocation().Y) * Environment.Settings.ThirdPersonSensitivity)
				else
					if Environment.Settings.Sensitivity > 0 then
						Animation = TweenService:Create(Camera, TweenInfonew(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFramenew(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
						Animation:Play()
					else
						Camera.CFrame = CFramenew(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
					end

					UserInputService.MouseDeltaSensitivity = 0
				end

				Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor
			end
		end
	end)

	ServiceConnections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input)
		if not Typing then
			pcall(function()
				if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode == Enum.KeyCode[#Environment.Settings.TriggerKey == 1 and stringupper(Environment.Settings.TriggerKey) or Environment.Settings.TriggerKey] or Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
					if Environment.Settings.Toggle then
						Running = not Running

						if not Running then
							CancelLock()
						end
					else
						Running = true
					end
				end
			end)
		end
	end)

	ServiceConnections.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input)
		if not Typing then
			if not Environment.Settings.Toggle then
				pcall(function()
					if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode == Enum.KeyCode[#Environment.Settings.TriggerKey == 1 and stringupper(Environment.Settings.TriggerKey) or Environment.Settings.TriggerKey] or Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
						Running = false; CancelLock()
					end
				end)
			end
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if hitboxEnabled then
            expandHitbox(character)
            character.ChildAdded:Connect(function(child)
                if hitboxEnabled and (child.Name == "HumanoidRootPart" or child.Name == "Head") then
                    updateHitbox(character)
                end
            end)
        end
        ToggleHighlight(HighlightEnabled)
    end)
end)

for _, player in pairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function(character)
        if hitboxEnabled then
            expandHitbox(character)
        end
        ToggleHighlight(HighlightEnabled)
    end)
    if player.Character then
        if hitboxEnabled then
            expandHitbox(player.Character)
        end
        ToggleHighlight(HighlightEnabled)
    end
end

RunService.Stepped:Connect(function()
    if hitboxEnabled then
        updateAllHitboxes()
    end
end)

ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
	Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
	Typing = false
end)

local PepsisWorld = library:CreateWindow({
    Name = "Pepsi's World",
    Themeable = {
        Info = "Discord Server: VzYTJ7Y"
    }
})

local GeneralTab = PepsisWorld:CreateTab({
    Name = "General"
})

local HighlightSection = GeneralTab:CreateSection({
    Name = "Highlight Control",
    Side = "Right"
})

HighlightSection:AddToggle({
    Name = "Enable Highlight",
    Flag = "HighlightSection_EnableHighlight",
    Value = HighlightEnabled,
    Callback = function(value)
        HighlightEnabled = value
        ToggleHighlight(HighlightEnabled)
    end
})

HighlightSection:AddToggle({
    Name = "Team Check",
    Flag = "HighlightSection_TeamCheck",
    Value = TeamCheckEnabled,
    Callback = function(value)
        TeamCheckEnabled = value
        ToggleHighlight(false)
        ToggleHighlight(HighlightEnabled)
    end
})

HighlightSection:AddToggle({
    Name = "Auto Team Color",
    Flag = "HighlightSection_AutoTeamColor",
    Value = AutoTeamColorEnabled,
    Callback = function(value)
        ToggleAutoTeamColor(value)
    end
})

HighlightSection:AddColorPicker({
    Name = "Fill Color",
    Flag = "HighlightSection_FillColor",
    Value = FillColor,
    Callback = function(value)
        FillColor = value
        ToggleHighlight(HighlightEnabled)
    end
})

HighlightSection:AddColorPicker({
    Name = "Outline Color",
    Flag = "HighlightSection_OutlineColor",
    Value = OutlineColor,
    Callback = function(value)
        OutlineColor = value
        ToggleHighlight(HighlightEnabled)
    end
})

HighlightSection:AddSlider({
    Name = "Fill Transparency",
    Flag = "HighlightSection_FillTransparency",
    Value = FillTransparency,
    Min = 0,
    Max = 1,
    Precise = 2,
    Callback = function(value)
        FillTransparency = value
        ToggleHighlight(HighlightEnabled)
    end
})

HighlightSection:AddSlider({
    Name = "Outline Transparency",
    Flag = "HighlightSection_OutlineTransparency",
    Value = OutlineTransparency,
    Min = 0,
    Max = 1,
    Precise = 2,
    Callback = function(value)
        OutlineTransparency = value
        ToggleHighlight(HighlightEnabled)
    end
})

local HitboxSection = GeneralTab:CreateSection({
    Name = "Hitbox Expansion"
})

HitboxSection:AddToggle({
    Name = "Enable Hitbox Expansion",
    Flag = "HitboxSection_Enabled",
    Callback = function(value)
        hitboxEnabled = value
        updateAllHitboxes()
    end
})

HitboxSection:AddSlider({
    Name = "Hitbox Size",
    Flag = "HitboxSection_Size",
    Value = hitboxSize,
    Min = 1,
    Max = 20,
    Callback = function(value)
        hitboxSize = value
        updateAllHitboxes()
    end
})

HitboxSection:AddSlider({
    Name = "Hitbox Transparency",
    Flag = "HitboxSection_Transparency",
    Value = hitboxTransparency,
    Min = 0,
    Max = 1,
    Precise = 2,
    Callback = function(value)
        hitboxTransparency = value
        updateAllHitboxes()
    end
})

HitboxSection:AddToggle({
    Name = "Team Check Enabled",
    Flag = "HitboxSection_TeamCheck",
    Callback = function(value)
        hitboxTeamCheckEnabled = value
        updateAllHitboxes()
    end
})

HitboxSection:AddDropdown({
    Name = "Target Part",
    Flag = "HitboxSection_TargetPart",
    List = {"HumanoidRootPart", "Head"},
    Callback = function(value)
        hitboxTargetPart = value
        updateAllHitboxes()
    end
})

local AimbotSettingsSection = GeneralTab:CreateSection({
    Name = "Aimbot Settings",
    Side = "Right"
})

local FOVSettingsSection = GeneralTab:CreateSection({
    Name = "FOV Settings"
})

AimbotSettingsSection:AddToggle({
    Name = "Enabled",
    Flag = "AimbotSettings_Enabled",
    Callback = function(state)
        Environment.Settings.Enabled = state
    end
})

AimbotSettingsSection:AddToggle({
    Name = "Team Check",
    Flag = "AimbotSettings_TeamCheck",
    Callback = function(state)
        Environment.Settings.TeamCheck = state
    end
})

AimbotSettingsSection:AddToggle({
    Name = "Alive Check",
    Flag = "AimbotSettings_AliveCheck",
    Callback = function(state)
        Environment.Settings.AliveCheck = state
    end
})

AimbotSettingsSection:AddToggle({
    Name = "Wall Check",
    Flag = "AimbotSettings_WallCheck",
    Callback = function(state)
        Environment.Settings.WallCheck = state
    end
})

AimbotSettingsSection:AddSlider({
    Name = "Sensitivity",
    Flag = "AimbotSettings_Sensitivity",
    Value = Environment.Settings.Sensitivity,
    Min = 0,
    Max = 1,
    Precise = 2,
    Callback = function(value)
        Environment.Settings.Sensitivity = value
    end
})

AimbotSettingsSection:AddToggle({
    Name = "Third Person",
    Flag = "AimbotSettings_ThirdPerson",
    Callback = function(state)
        Environment.Settings.ThirdPerson = state
    end
})

AimbotSettingsSection:AddSlider({
    Name = "Third Person Sensitivity",
    Flag = "AimbotSettings_ThirdPersonSensitivity",
    Value = Environment.Settings.ThirdPersonSensitivity,
    Min = 1,
    Max = 5,
    Callback = function(value)
        Environment.Settings.ThirdPersonSensitivity = value
    end
})

AimbotSettingsSection:AddDropdown({
    Name = "Lock Part",
    Flag = "AimbotSettings_LockPart",
    List = {"Head", "Torso", "HumanoidRootPart"},
    Value = Environment.Settings.LockPart,
    Callback = function(value)
        Environment.Settings.LockPart = value
    end
})

FOVSettingsSection:AddToggle({
    Name = "Enabled",
    Flag = "FOVSettings_Enabled",
    Callback = function(state)
        Environment.FOVSettings.Enabled = state
    end
})

FOVSettingsSection:AddToggle({
    Name = "Visible",
    Flag = "FOVSettings_Visible",
    Callback = function(state)
        Environment.FOVSettings.Visible = state
    end
})

FOVSettingsSection:AddSlider({
    Name = "Amount",
    Flag = "FOVSettings_Amount",
    Value = Environment.FOVSettings.Amount,
    Min = 0,
    Max = 360,
    Callback = function(value)
        Environment.FOVSettings.Amount = value
    end
})

FOVSettingsSection:AddColorPicker({
    Name = "FOV Color",
    Flag = "FOVSettings_Color",
    Value = Environment.FOVSettings.Color,
    Callback = function(color)
        Environment.FOVSettings.Color = color
    end
})

FOVSettingsSection:AddColorPicker({
    Name = "Locked FOV Color",
    Flag = "FOVSettings_LockedColor",
    Value = Environment.FOVSettings.LockedColor,
    Callback = function(color)
        Environment.FOVSettings.LockedColor = color
    end
})

FOVSettingsSection:AddSlider({
    Name = "Transparency",
    Flag = "FOVSettings_Transparency",
    Value = Environment.FOVSettings.Transparency,
    Min = 0,
    Max = 1,
    Precise = 2,
    Callback = function(value)
        Environment.FOVSettings.Transparency = value
    end
})

FOVSettingsSection:AddSlider({
    Name = "Sides",
    Flag = "FOVSettings_Sides",
    Value = Environment.FOVSettings.Sides,
    Min = 3,
    Max = 100,
    Callback = function(value)
        Environment.FOVSettings.Sides = value
    end
})

FOVSettingsSection:AddSlider({
    Name = "Thickness",
    Flag = "FOVSettings_Thickness",
    Value = Environment.FOVSettings.Thickness,
    Min = 1,
    Max = 10,
    Callback = function(value)
        Environment.FOVSettings.Thickness = value
    end
})

FOVSettingsSection:AddToggle({
    Name = "Filled",
    Flag = "FOVSettings_Filled",
    Callback = function(state)
        Environment.FOVSettings.Filled = state
    end
})

--// Load
Load()
