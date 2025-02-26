        pcall(function()
			local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("Nick's Awesome RGD Gui")

local serv = win:Server("RGD", "")

local rgd = serv:Channel("Droid/Circuits")

rgd:Button("Kill all Droids", function()
	while wait() do
		for i,v in pairs(game.Workspace.Room.Enemies:GetDescendants()) do
			if v:IsA("Humanoid") and v.Parent.Name ~= game.Players.LocalPlayer.Name then
				v.Health = 0
			end
		end
	end
end)

rgd:Seperator()

rgd:Toggle("God Mode",true, function(bool)
local plrc = game.Players.LocalPlayer.Character

plrc.Head.CanTouch = bool
plrc.HumanoidRootPart.CanTouch = bool
plrc["Left Arm"].CanTouch = bool
plrc["Right Arm"].CanTouch = bool
plrc["Right Leg"].CanTouch = bool
plrc["Left Leg"].CanTouch = bool
plrc.Torso.CanTouch = bool
end)

rgd:Label("Green = off, Grey = On")

rgd:Seperator()

_G.AutoRoom = false

rgd:Toggle("Auto Room", false, function(v)
    _G.AutoRoom = v
end)

rgd:Button("Tornado Droid God Mode", function()
	while wait() do
		for i,v in pairs(game.Workspace:GetDescendants()) do
if v.Name == "Tornado" then
v.TouchInterest:Destroy()

         end
     end
  end
end)

rgd:Seperator()

rgd:Button("Ranged Droids God Mode", function()
spawn(function()
	while wait() do
		for i,v in pairs(game.Workspace:GetDescendants()) do
if v.Name == "Bullet" then
v.TouchInterest:Destroy()

         end
     end
  end
end)
end)

rgd:Seperator()

rgd:Button("Snowball God Mode", function()
	while wait() do
		for i,v in pairs(game.Workspace:GetChildren()) do
if v.Name == "Snowball" then
v.TouchInterest:Destroy()

         end
     end
  end
end)

rgd:Seperator()

rgd:Button("Bring all Circuits", function()
local plr = game.Players.LocalPlayer.Character

while wait() do
for i,v in pairs(game.Workspace:GetDescendants()) do
			if v:IsA("UnionOperation") and v.Name == "Circuit" then
		v.CFrame = plr.HumanoidRootPart.CFrame
		v.CanCollide = false
        end
      end
    end
end)

rgd:Seperator()

rgd:Button("Anchor all Droids", function()
	while wait() do
		for i,v in pairs(game.Workspace.Room.Enemies:GetDescendants()) do
			if v:IsA("Part") and v.Name == "Head" then
				v.Anchored = true
			end
		end
	end
end)

rgd:Seperator()

rgd:Button("Un-Anchor all Droids", function()
	while wait() do
		for i,v in pairs(game.Workspace.Room.Enemies:GetDescendants()) do
			if v:IsA("Part") and v.Name == "Head" then
				v.Anchored = false
			end
		end
	end
end)


local rgd = serv:Channel("Puzzle Boxes")

rgd:Button("Solve Puzzles Red", function()

		for i,v in pairs(game.Workspace.Room.Enemies:GetDescendants()) do
			if v.Name == "PuzzleBox 1" then
			v.Box.CFrame = game:GetService("Workspace").Room.Enemies["PressurePlate 1"].Activator.CFrame

end

	end
end)

rgd:Button("Solve Puzzles Blue", function()

		for i,v in pairs(game.Workspace.Room.Enemies:GetDescendants()) do
			if v.Name == "PuzzleBox 2" then
			v.Box.CFrame = game:GetService("Workspace").Room.Enemies["PressurePlate 2"].Activator.CFrame

end

	end
end)

rgd:Button("Solve Puzzles Green", function()
for i,v in pairs(game.Workspace.Room.Enemies:GetDescendants()) do
			if v.Name == "PuzzleBox 3" then
			v.Box.CFrame = game:GetService("Workspace").Room.Enemies["PressurePlate 3"].Activator.CFrame

end

	end
end)

local rgd = serv:Channel("Map")

rgd:Button("Lava Immunity", function()
	while wait() do
		for i,v in pairs(game.Workspace:GetDescendants()) do
if v.name == "Lava" then
v.TouchInterest:Destroy()

end
end
	end
end)

rgd:Button("Water+QuickSand Immunity", function()
	while wait() do
		for i,v in pairs(game.Workspace:GetDescendants()) do
if v.name == "Killer" then
v.TouchInterest:Destroy()

end
end
	end
end)

rgd:Button("Acid Immunity", function()
	while wait() do
		for i,v in pairs(game.Workspace:GetDescendants()) do
if v.name == "Acid" then
v.TouchInterest:Destroy()

end
end
	end
end)

rgd:Button("Solidify Water", function()
	while wait() do
		for i,v in pairs(game.Workspace:GetDescendants()) do
if v.name == "Water" then
v.CanCollide = true
v.Transparency = 0

end
end
	end
end)

rgd:Button("Solidify Lava", function()
while wait() do
for i,v in pairs(game.Workspace:GetDescendants()) do
if v.name == "Lava" then
v.CanCollide = true
v.BrickColor = BrickColor.new("Cocoa")
v.Transparency = 0

end
	end

	end
end)



rgd:Button("Press all Buttons", function()
	while wait() do
		for i,v in pairs(game.Workspace.Room.Enemies:GetDescendants()) do
			if v.Name == "Button" then
			local f = 	v.ClickDetector
fireclickdetector(f)
			end
		end
	end
end)

rgd:Button("Bring all Items on the Ground", function()
	while wait() do
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v:IsA("Tool") then
v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
v.Handle.CanCollide = false
			end
		end
	end
end)

local rgd = serv:Channel("Player")

local sldr = rgd:Slider("WalkSpeed", 0, 100, 50, function(t)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (t)
end)

local sldr = rgd:Slider("JumpPower", 0, 300, 50, function(t)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = (t)
end)

rgd:Textbox("Manually Enter WalkSpeed", "Type here!", true, function(t)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (t)
end)

rgd:Textbox("Manually Enter JumpPower", "Type here!", true, function(t)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = (t)
end)

rgd:Button("HitBox+ (Laggy)", function()
game:GetService("Players").LocalPlayer.Backpack["Copper Sword"].Handle.Size = Vector3.new(60,60,60)


end)

rgd:Button("Undo HitBox+", function()
game:GetService("Players").LocalPlayer.Backpack["Copper Sword"].Handle.Size = Vector3.new(1, 0.8, 5)
end)

rgd:Label("You must have the Copper Sword in your inventory")
rgd:Label("Unequipped, IF you re-equip it after enabling it")
rgd:Label("You will be flung")
		end)
