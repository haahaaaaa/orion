local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/haahaaaaa/orion/refs/heads/main/mainlib.lua')))()
local Window = OrionLib:MakeWindow({Name = "BloopUI 🌠", HidePremium = false, IntroText = "Welcome! :D", SaveConfig = true, ConfigFolder = "BloopUI"})
--[[
Name = <string> - The name of the UI.
HidePremium = <bool> - Whether or not the user details shows Premium status or not.
SaveConfig = <bool> - Toggles the config saving in the UI.
ConfigFolder = <string> - The name of the folder where the configs are saved.
IntroEnabled = <bool> - Whether or not to show the intro animation.
IntroText = <string> - Text to show in the intro animation.
IntroIcon = <string> - URL to the image you want to use in the intro animation.
Icon = <string> - URL to the image you want displayed on the window.
CloseCallback = <function> - Function to execute when the window is closed.
]]

local NotifSound = Instance.new("Sound")
NotifSound.SoundId = "rbxassetid://1053296915"
NotifSound.PlaybackSpeed = 1.2

local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://9119056442"
ClickSound.PlaybackSpeed = 1

local Player = game.Players.LocalPlayer

local HomeTab = Window:MakeTab({
	Name = "Home",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local PlayerTab = Window:MakeTab({
	Name = "Player",
    Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local MiscTab = Window:MakeTab({
	Name = "Misc",
    Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local VisualTab = Window:MakeTab({
	Name = "Visual",
    Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local ScriptsTab = Window:MakeTab({
	Name = "Scripts",
    Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

VisualTab:AddToggle({
	Name = "3D Rendering Enabled",
	Default = true,
	Callback = function(Value)
		game:GetService("RunService"):Set3dRenderingEnabled(Value)
        ClickSound:Play()
	end    
})

HomeTab:AddParagraph("Credits","OrionLib for template, BloopUI by xvxv")

MiscTab:AddButton({
	Name = "Infinite Yield",
	Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
        OrionLib:MakeNotification({
            Name = "BloopUI",
            Content = "Infinite Yield loaded",
            Image = "rbxassetid://4483345998",
            Time = 5,
            NotifSound:Play()
        })
  	end    
})

MiscTab:AddButton({
	Name = "FE Animation GUI (R6)",
	Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/MelonsStuff/f018928d2f010789a150b4924e279b16/raw/8de399eb9cbccbde430fcd37270cd4ff171f8b8e/AnimationGUI.txt"))()
        OrionLib:MakeNotification({
            Name = "BloopUI",
            Content = "FE Animation GUI (R6) loaded",
            Image = "rbxassetid://4483345998",
            Time = 5,
            NotifSound:Play()
        })
  	end    
})

ScriptsTab:AddButton({
	Name = "Nivex Hub",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Nivex123456/main/refs/heads/main/Loader.lua"))()
        OrionLib:MakeNotification({
            Name = "BloopUI",
            Content = "Nivex Hub loaded",
            Image = "rbxassetid://4483345998",
            Time = 5,
            NotifSound:Play()
        })
  	end    
})

ScriptsTab:AddButton({
	Name = "KAT zKing script",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zReal-King/Knife-Ability-Test/main/Gui" ))()
        OrionLib:MakeNotification({
            Name = "BloopUI",
            Content = "KAT zKing loaded",
            Image = "rbxassetid://4483345998",
            Time = 5,
            NotifSound:Play()
        })
  	end    
})

ScriptsTab:AddButton({
	Name = "RGD Gui",
	Callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/haahaaaaa/orion/refs/heads/main/rgd.lua'))()

        OrionLib:MakeNotification({
            Name = "BloopUI",
            Content = "RGD Gui loaded",
            Image = "rbxassetid://4483345998",
            Time = 5,
            NotifSound:Play()
        })
  	end    
})

ScriptsTab:AddButton({
	Name = "Prison Life script prisonware",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Denverrz/scripts/master/PRISONWARE_v1.3.txt"))()
        OrionLib:MakeNotification({
            Name = "BloopUI",
            Content = "Prisonware loaded",
            Image = "rbxassetid://4483345998",
            Time = 5,
            NotifSound:Play()
        })
  	end    
})

ScriptsTab:AddButton({
	Name = "Universal hitbox extender, aimbot",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Systemsdey23/bloop/refs/heads/main/Loader.lua"))()
        OrionLib:MakeNotification({
            Name = "BloopUI",
            Content = "Universal script loaded",
            Image = "rbxassetid://4483345998",
            Time = 5,
            NotifSound:Play()
        })
  	end    
})


PlayerTab:AddSlider({
	Name = "WalkSpeed",
	Min = 0,
	Max = 500,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "WalkSpeed",
	Callback = function(Value)
		Player.Character.Humanoid.WalkSpeed = Value
        ClickSound:Play()
	end    
})

PlayerTab:AddSlider({
	Name = "JumpPower",
	Min = 0,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "JumpPower",
	Callback = function(Value)
		Player.Character.Humanoid.JumpPower = Value
        ClickSound:Play()
	end    
})

PlayerTab:AddSlider({
	Name = "HipHeight",
	Min = 0,
	Max = 500,
	Default = 0,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "HipHeight",
	Callback = function(Value)
		Player.Character.Humanoid.HipHeight = Value
        ClickSound:Play()
	end    
})

--[[
Name = <string> - The name of the slider.
Min = <number> - The minimal value of the slider.
Max = <number> - The maxium value of the slider.
Increment = <number> - How much the slider will change value when dragging.
Default = <number> - The default value of the slider.
ValueName = <string> - The text after the value number.
Callback = <function> - The function of the slider.
]]

local DangerSection = HomeTab:AddSection({
	Name = "Danger"
})

DangerSection:AddButton({
	Name = "Destroy UI",
	Callback = function()
        OrionLib:MakeNotification({
            Name = "BloopUI",
            Content = "Destroying UI, thanks for using!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        OrionLib:Destroy()
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]

--[[
Name = <string> - The name of the section.
]]

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

OrionLib:MakeNotification({
	Name = "BloopUI",
	Content = "Loaded successfully, thanks for using!",
	Image = "rbxassetid://4483345998",
	Time = 5,
    NotifSound:Play()
})

--[[
Title = <string> - The title of the notification.
Content = <string> - The content of the notification.
Image = <string> - The icon of the notification.
Time = <number> - The duration of the notfication.
]]


OrionLib:Init()
