-- Settings
getgenv().enabled = true -- Toggle on/off
getgenv().filluseteamcolor = false -- Toggle fill color using player team color on/off
getgenv().outlineuseteamcolor = false -- Toggle outline color using player team color on/off
getgenv().fillcolor = Color3.new(0, 0, 255) -- Change fill color, no need to edit if using team color
getgenv().outlinecolor = Color3.new(0, 255, 255) -- Change outline color, no need to edit if using team color
getgenv().filltrans = 0.25 -- Change fill transparency
getgenv().outlinetrans = 0 -- Change outline transparency
getgenv().headSize = Vector3.new(2.3, 2.3, 2.3) -- Change head hitbox size
-- End Of Settings

local holder = game.CoreGui:FindFirstChild("ESPHolder") or Instance.new("Folder")
if not getgenv().enabled then
    holder:Destroy()
    return
end

if holder.Name == "Folder" then
    holder.Name = "ESPHolder"
    holder.Parent = game.CoreGui
end

local function generateUUID()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    return string.gsub(template, "[xy]", function(c)
        local v = (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format("%x", v)
    end)
end

local function addESP(model)
    local humanoidRootPart = model:FindFirstChild("HumanoidRootPart")
    local head = model:FindFirstChild("Head")
    if humanoidRootPart then
        if not model:FindFirstChild("UUID") then
            local uuidValue = Instance.new("StringValue", model)
            uuidValue.Name = "UUID"
            uuidValue.Value = generateUUID()
            print('[TridentWare] New UUID created: ' .. uuidValue.Value)
        end

        local uuid = model:FindFirstChild("UUID").Value
        local esp = holder:FindFirstChild(uuid) or Instance.new("Highlight")
        esp.Name = uuid
        esp.Parent = holder
        esp.Adornee = model

        esp.FillColor = getgenv().fillcolor
        esp.OutlineColor = getgenv().outlinecolor

        esp.FillTransparency = getgenv().filltrans
        esp.OutlineTransparency = getgenv().outlinetrans
        esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        
        -- Resize the HumanoidRootPart by adding 4 studs to each axis
        head.Size = getgenv().headSize
    end
end

while getgenv().enabled do
    holder:ClearAllChildren()

    for _, model in pairs(workspace:GetDescendants()) do
        if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
            addESP(model)
        end
    end
    
    task.wait(0.75)
end
