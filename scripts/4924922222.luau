local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()
local brookhavenTool = loadstring(game:HttpGet("https://raw.githubusercontent.com/Laelmano24/brookhaven-tool/refs/heads/main/src/main.luau"))()

local Window = redzlib:MakeWindow({
    Title = "Davi molestado Hub",
    SubTitle = "by Laelmano24",
    SaveFolder = ""
})

Window:AddMinimizeButton({
  Button = { Image = redzlib:GetIcon("rbxassetid://123968606273780"),
    Size = UDim2.fromOffset(60, 60),
    BackgroundTransparency = 0 },
  Corner = { CornerRadius = UDim.new(0, 6) }
})

local TabHouse = Window:MakeTab({"House", "home"})
local TabAvatar = Window:MakeTab({"Avatar", "shirt"})
local TabCar = Window:MakeTab({"Carro", "car"})
local TabPlayer = Window:MakeTab({"Player", "user"})

local ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players: Players = game:GetService("Players")
local LocalPlayer: Player = Players.LocalPlayer
local Character: Model  = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart: BasePart = Character:WaitForChild("HumanoidRootPart")

local vehicles: Folder = workspace:WaitForChild("Vehicles")
local remoteAvatar: RemoteFunction = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Wear")
local changeCharacterBody: RemoteFunction = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody")

if shared.connectCharacter then shared.connectCharacter:Disconnect() end
shared.connectCharacter = LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    HumanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
end)

--[[Tab de casinhas]]

TabHouse:AddSection({"Remover o seu banimento da casa"})

TabHouse:AddButton({"Remover o ban da casa", function()
  brookhavenTool:removeBanHouses()
end})

TabHouse:AddToggle({
  Name = "Auto remover ban",
  Description = "",
  Flag = "AutoRemoverBan",
  Callback = function(value)
    brookhavenTool:autoRemoveBanHouses(value)
  end
})

--[[Tab de carrinhos]]

TabCar:AddSection({"Puxar os carros do jogadores"})

local pullCarValue
local dropdownPullCar = TabCar:AddDropdown({
  Name = "Cars List",
  Description = "",
  Options = {},
  Default = "",
  Flag = "player list",
  Callback = function(value)
    pullCarValue = value
  end
})

local function uptadePullCars()
    local TabCars = {}
    for _, car in ipairs(vehicles:GetChildren()) do
        table.insert(TabCars, car.Name)
    end
    dropdownPullCar:Set(TabCars)
end

uptadePullCars()

TabCar:AddButton({"Atualizar lista", function()
    uptadePullCars()
end})

TabCar:AddButton({"Puxar o carro", function()
    
end})

--[[Tab de jogadores]]

TabPlayer:AddSection({"Spectar os jogadores"})

local spectarPlayerValue
local dropdownSpectarPlayers = TabPlayer:AddDropdown({
  Name = "Players List",
  Description = "",
  Options = {},
  Default = "",
  Flag = "player list",
  Callback = function(value)
    spectarPlayerValue = value
  end
})

local function uptadePlayerSpectar()
  local TabPlayers = {}
  for _, player in ipairs(Players:GetPlayers()) do
    if player.Name ~= LocalPlayer.Name then
      table.insert(TabPlayers, player.Name)
    end
  end
  if dropdownSpectarPlayers then dropdownSpectarPlayers:Set(TabPlayers) end
end

uptadePlayerSpectar()

TabPlayer:AddButton({"Atualizar lista", function()
  uptadePlayerSpectar()
end})

TabPlayer:AddToggle({
  Name = "Spectar o jogador",
  Description = "",
  Flag = "SpectarJogador",
  Callback = function(value)
    brookhavenTool:spectatePlayer({value, spectarPlayerValue})
  end
})

--[[Tab de avatar]]

TabAvatar:AddSection({"Copiar o acessorio dos jogadores"})

local avatarPlayerValue
local dropdownAvatarPlayers = TabAvatar:AddDropdown({
  Name = "Players List",
  Description = "",
  Options = {},
  Default = "",
  Flag = "player list",
  Callback = function(value)
    avatarPlayerValue = value
  end
})

local function uptadePlayerAvatar()
  local TabPlayers = {}
  for _, player in ipairs(Players:GetPlayers()) do
    if player.Name ~= LocalPlayer.Name then
      table.insert(TabPlayers, player.Name)
    end
  end
  dropdownAvatarPlayers:Set(TabPlayers)
end

uptadePlayerAvatar()

TabAvatar:AddButton({"Atualizar lista", function()
  uptadePlayerAvatar()
end})

TabAvatar:AddButton({"Copiar acessorio", function()

    local tabLocalPlayerAcessories: {number} = brookhavenTool:getIdAccessoriesPlayer(LocalPlayer.Name, "brookhaven")
    local tabBodyIds: {number} = brookhavenTool:getIdsBodyPlayer(avatarPlayerValue, "roblox")

    for _, localPlayerID in pairs(tabLocalPlayerAcessories) do
        remoteAvatar:InvokeServer(tonumber(localPlayerID))
    end

    task.wait(0.5)

    local tabTargetPlayerAcessories: {number} = brookhavenTool:getIdAccessoriesPlayer(avatarPlayerValue, "roblox")
    for _, targetPlayerID in pairs(tabTargetPlayerAcessories) do
        remoteAvatar:InvokeServer(tonumber(targetPlayerID))
    end

    changeCharacterBody:InvokeServer(tabBodyIds)
end})