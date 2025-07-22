local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Sacola hub",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "by Laelmano24",
    Folder = "TõCheetos",
    Size = UDim2.fromOffset(580, 200),
    Transparent = true,
    Theme = "Dark",
})

local TabMain = Window:Tab({ Title = "Main" })

TabMain:Button({
    Title = "Deletar blocos fakes da garena firo firo",
    Callback = function()
        local glasses: Folder = workspace:WaitForChild("Glasses")
        local wrong: Folder = glasses:WaitForChild("Wrong")
        wrong:Destroy()
    end
})