-- ANTI AFK made by Muscle_legends2021 [Gio]

local VirtualUser = game:GetService('VirtualUser')

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AntiAFK loaded!",
    Text = "Made by Gio",
    Button1 = "Thanks",
    Duration = 5
})
