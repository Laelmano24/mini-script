local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Tõ cheetos hub",
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
        local grass: Model = workspace:WaitForChild("Glass")
        if not grass then return print("Essa não existe, mané") end

        for _, model in ipairs(grass:GetChildren()) do
            if model:IsA("Model") then
                local soundInstance: Sound = model:FindFirstChild("Sound", true)
                if not soundInstance then continue end

                local part: BasePart = soundInstance.Parent
                if not part then continue end
                
                part:Destroy()
            end
        end

    end
})