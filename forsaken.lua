if game.PlaceId == 18687417158 then
    game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Forsaken Script", -- Required
	Text = "Script by obstruction_ on discord (me)", -- Required
	Icon = "rbxassetid://133992837986106" -- Optional
    })
else
    game:GetService("StarterGui"):SetCore("SendNotification",{
	    Title = "Forsaken Script", -- Required
	    Text = "You are not in forsaken..", -- Required
	    Icon = "rbxassetid://133992837986106" -- Optional
    })
    return
end


local killers = workspace:FindFirstChild("Players"):FindFirstChild("Killers")
local survivors = workspace:FindFirstChild("Players"):FindFirstChild("Survivors")
local ragdolls = workspace:FindFirstChild("Ragdolls")
local map = workspace:FindFirstChild("Map").Ingame

local lighting = game:GetService("Lighting")
local runservice = game:GetService("RunService")
local players = game:GetService("Players")

print("Forsaken Script Loaded!!")

local function esp()
    for i, v in ipairs(killers:GetChildren()) do
        if v:FindFirstChild("ESPNEW") then 
            pcall(function()
                v:FindFirstChild("Torso").ESPHP:FindFirstChild("TextLabel").Text = tostring(math.round(v:FindFirstChild("Humanoid").Health)).. "/".. tostring(v:FindFirstChild("Humanoid").MaxHealth)
            end)
            continue
        end

        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPNEW"
        highlight.Parent = v
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineTransparency = 1

        local billboard = Instance.new("BillboardGui")
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(5, 0, 3, 0)
        billboard.StudsOffset = Vector3.new(0, -2, 0)
        billboard.Parent = v:FindFirstChild("Torso")

        local text = Instance.new("TextLabel")
        text.Text = v.Name
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.fromRGB(255, 50, 50)
        text.TextScaled = true
        text.Font = Enum.Font.Fantasy
        text.TextStrokeTransparency = 1
        text.Parent = billboard

        local hpb = Instance.new("BillboardGui")
        hpb.Name = "ESPHP"
        hpb.AlwaysOnTop = true
        hpb.Size = UDim2.new(5, 0, 3, 0)
        hpb.StudsOffset = Vector3.new(0, -3.5, 0)
        hpb.Parent = v:FindFirstChild("Torso")

        local hpt = Instance.new("TextLabel")
        hpt.Text = tostring(math.round(v:WaitForChild("Humanoid").Health)).. "/".. tostring(v:FindFirstChild("Humanoid").MaxHealth)
        hpt.Size = UDim2.new(1, 0, 1, 0)
        hpt.BackgroundTransparency = 1
        hpt.TextColor3 = Color3.fromRGB(255, 50, 50)
        hpt.TextScaled = true
        hpt.Font = Enum.Font.Fantasy
        hpt.TextStrokeTransparency = 1
        hpt.Parent = hpb

        local stroke2 = Instance.new("UIStroke")
        stroke2.Thickness = 1
        stroke2.Parent = hpt

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Parent = text
    end
    for i, v in ipairs(survivors:GetChildren()) do
        if v:FindFirstChild("ESPNEW") then 
            pcall(function()
                v:FindFirstChild("Torso").ESPHP:FindFirstChild("TextLabel").Text = tostring(math.round(v:FindFirstChild("Humanoid").Health)).. "/".. tostring(v:FindFirstChild("Humanoid").MaxHealth)
            end)
            continue
        end

        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPNEW"
        highlight.Parent = v
        highlight.FillColor = Color3.fromRGB(200, 200, 200)
        highlight.OutlineTransparency = 1

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESPNEW"
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(5, 0, 3, 0)
        billboard.StudsOffset = Vector3.new(0, -2, 0)
        billboard.Parent = v:FindFirstChild("Torso")

        local text = Instance.new("TextLabel")
        text.Text = v.Name
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.fromRGB(200, 200, 200)
        text.TextScaled = true
        text.Font = Enum.Font.Fantasy
        text.TextStrokeTransparency = 1
        text.Parent = billboard

        local hpb = Instance.new("BillboardGui")
        hpb.Name = "ESPHP"
        hpb.AlwaysOnTop = true
        hpb.Size = UDim2.new(5, 0, 3, 0)
        hpb.StudsOffset = Vector3.new(0, -3.5, 0)
        hpb.Parent = v:FindFirstChild("Torso")

        local hpt = Instance.new("TextLabel")
        hpt.Text = tostring(math.round(v:WaitForChild("Humanoid").Health)).. "/".. tostring(v:FindFirstChild("Humanoid").MaxHealth)
        hpt.Size = UDim2.new(1, 0, 1, 0)
        hpt.BackgroundTransparency = 1
        hpt.TextColor3 = Color3.fromRGB(200, 200, 200)
        hpt.TextScaled = true
        hpt.Font = Enum.Font.Fantasy
        hpt.TextStrokeTransparency = 1
        hpt.Parent = hpb

        local stroke2 = Instance.new("UIStroke")
        stroke2.Thickness = 1
        stroke2.Parent = hpt

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Parent = text
    end

    for i, v in ipairs(map:GetChildren()) do
        if v:IsA("Tool") then
            if v:FindFirstChild("ESPNEW") then 
                continue
            end

            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(0, 0, 255)
            highlight.Parent = v
            highlight.Name = "ESPNEW"
            highlight.OutlineTransparency = 1

            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESPNEW"
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(5, 0, 3, 0)
            billboard.StudsOffset = Vector3.new(0, -2, 0)
            billboard.Parent = v

            local text = Instance.new("TextLabel")
            text.Text = v.Name
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.TextColor3 = Color3.fromRGB(0, 0, 255)
            text.TextScaled = true
            text.Font = Enum.Font.Fantasy
            text.TextStrokeTransparency = 1
            text.Parent = billboard

            local stroke = Instance.new("UIStroke")
            stroke.Thickness = 1
            stroke.Parent = text
        end
    end
    
    if map:FindFirstChild("Map") then
        for i, v in ipairs(map.Map:GetChildren()) do
        if v:IsA("Model") and v.Name == "Generator" then
            if v.Instances.Generator:FindFirstChild("ESPNEW") then 
                pcall(function()
                    if v:FindFirstChild("Progress").Value == 100 then
                        v.Instances.Generator:FindFirstChild("ESPNEW").Enabled = false
                        v.Instances.Generator:FindFirstChild("ESPNEWB").Enabled = false
                    end
                end)
                continue
            end

                pcall(function()
                    if v:FindFirstChild("Progress").Value == 100 then
                        v.Instances.Generator:FindFirstChild("ESPNEW").Enabled = false
                        v.Instances.Generator:FindFirstChild("ESPNEWB").Enabled = false
                    end
                end)

            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(255, 255, 0)
            highlight.Parent = v.Instances.Generator
            highlight.Name = "ESPNEW"
            highlight.OutlineTransparency = 1

            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESPNEWB"
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(5, 0, 3, 0)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.Parent = v.Instances.Generator

            local text = Instance.new("TextLabel")
            text.Text = v.Name
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.TextColor3 = Color3.fromRGB(255, 255, 0)
            text.TextScaled = true
            text.Font = Enum.Font.Fantasy
            text.TextStrokeTransparency = 1
            text.Parent = billboard

            local stroke = Instance.new("UIStroke")
            stroke.Thickness = 1
            stroke.Parent = text
        end
    end
    end

    for i, v in ipairs(ragdolls:GetChildren()) do
	    if v:FindFirstChild("Head") then
            if v.Head:FindFirstChild("ESPNEW") then
               v.Head:FindFirstChild("ESPNEW"):Destroy()
               v.Head:FindFirstChild("ESPHP"):Destroy()
           end
	    end
    end

    lighting.Brightness = 2
    lighting.ClockTime = 14
    lighting.FogEnd = 100000
    lighting.GlobalShadows = false
    lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)

    lighting.FogEnd = 100000
    for i,v in ipairs(lighting:GetDescendants()) do
	    if v:IsA("Atmosphere") then
		    v:Destroy()
	    end
    end
end

local function deathlog(plr)
    pcall(function()
        plr.Character:FindFirstChild("Humanoid").Died:Connect(function()
            game:GetService("StarterGui"):SetCore("SendNotification",{
	            Title = "Forsaken Script", -- Required
	            Text = plr.Character.Name.. " (@"..players:GetPlayerFromCharacter(plr.Character).Name..") has died.", -- Required
	            Icon = "rbxassetid://133992837986106" -- Optional
            })
        end)
    end)
end

for i, v in ipairs(players:GetPlayers()) do
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
