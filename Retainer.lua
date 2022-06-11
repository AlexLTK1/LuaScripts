if self.clicked then
    data.rStep = 0
    data.currentStep = 1
    self.colorBoolean = not self.colorBoolean
end

-- checks ventures between KDF runs:
if (KitanoiFuncs and KitanoiFuncs.WaitingToQueue()) and (data.lastAutoVenture == nil or TimeSince(data.lastAutoVenture) >= 60000) then
    data.rStep = 0
    data.currentStep = 1
    self.colorBoolean = true
    data.lastAutoVenture = Now()
    d("Waiting to queue, attempting to send quick ventures.")
end

-- uncomment the following code for auto checking ventures every hour:
--[[if (data.lastAutoVenture == nil or TimeSince(data.lastAutoVenture) >= 3600000) and not (KitanoiFuncs and KitanoiFuncs.AreKitanoiAddonsRunning()) and not (HusbandoMaxAddonStatus ~= nil and (HusbandoMaxAddonStatus.Assist.Enabled == true or HusbandoMaxAddonStatus.DeepDungeon.Enabled == true or HusbandoMaxAddonStatus.DungeonMaster.Enabled == true or HusbandoMaxAddonStatus.EurekaAnemos.Enabled == true or HusbandoMaxAddonStatus.EurekaHydatos.Enabled == true or HusbandoMaxAddonStatus.EurekaPagos.Enabled == true or HusbandoMaxAddonStatus.EurekaPyros.Enabled == true)) and not InInstance() and not MIsLoading() and not Busy() then
    data.rStep = 0
    data.currentStep = 1
    self.colorBoolean = true
    data.lastAutoVenture = Now()
end]]--

if self.colorBoolean then
    local retainerCount = 3 -- change 2 to number of retainers you own, it will go in order from top to bottom the number of times that you set this
    if Inventory:GetCurrencyCountByID(21072) < 2 then
        data.rStep = 0
        data.currentStep = 1
        self.colorBoolean = false
        d("Out of ventures.")
    end

    if IsControlOpen("Talk") then
        UseControlAction("Talk","Click")
    end

    if InInstance() or (KitanoiFuncs and KitanoiFuncs.InDuty()) then
        data.rStep = 0
        data.currentStep = 1
        self.colorBoolean = false
        d("Oh no, couldn't get retainers done in time. Cancelling order.")
    end

    local nearby = TensorCore.entityList("contentid=2006565;2000401;196630;2000401;2000403,nearest")
    local p = TensorCore.mGetPlayer()
    if table.valid(nearby) then
        for k,v in pairs(nearby) do
            p:MoveTo(v.pos.x, v.pos.y, v.pos.z)
            if TensorCore.getDistance2d(p.pos, v.pos) <= 4 then
                Player:Interact(k)
                Player:Stop()
            end
        end
    else
        d("No nearby summoning bells - could potentially teleport somewhere here?")
        Player:Teleport(97) -- this would teleport to my appartment, where there is a nearby summoning bell. if you want to use this, comment out the next line
        self.colorBoolean = false
    end

    if IsControlOpen("RetainerList") then
        if data.rStep < retainerCount then
            UseControlAction("RetainerList", "SelectIndex", data.rStep)
            data.currentStep = 2
            d("Selected retainer: ".. data.rStep)
        else
            d("Finished assigning ventures")
            self.colorBoolean = false
            GetControl("RetainerList"):Close()
            data.lastAutoVenture = Now()
        end
    end

    if data.currentStep == 1 and IsControlOpen("SelectString") then
        local i
        local control = GetControl("SelectString"):GetData()
        if table.valid(control) then
            for k,v in pairs(control) do
                if v == GetString("Quit.") then
                    i = k
                end
            end
        end

        if i ~= nil then 
            UseControlAction("SelectString", "SelectIndex", i)
        end
    end

    if data.currentStep == 2 and IsControlOpen("SelectString") then
        local i
        local control = GetControl("SelectString"):GetData()
        if table.valid(control) then
            for k,v in pairs(control) do
                if v == GetString("View venture report. (Complete)") then
                    i = k
                    break
                elseif v == GetString("Assign venture.") then
                    i = k
                    break
                end
                
            end
            if i == nil then i = false end
        end

        if i ~= nil and not (i == false) then 
            UseControlAction("SelectString", "SelectIndex", i) 
            d("Selected GUI action successfully, moving on.")
            data.currentStep = 3
        elseif i == false then
            d("Retainer not ready yet.")
            data.currentStep = 1
            data.rStep = data.rStep + 1
        end
    end

    if data.currentStep == 3 and IsControlOpen("SelectString") then
        local i
        local control = GetControl("SelectString"):GetData()
        if table.valid(control) then
            for k,v in pairs(control) do
                if v == GetString("Quick Exploration.") then
                    i = k
                end
            end
        end

        if i ~= nil then 
            UseControlAction("SelectString", "SelectIndex", i)
            d("Selected GUI action successfully, moving on.")
            data.currentStep = 4
        end
    end
    
    if IsControlOpen("RetainerTaskResult") then
        GetControl("RetainerTaskResult"):PushButton(25, 3)
        d("Reassigned venture successfully.")
        data.rStep = data.rStep + 1
        data.currentStep = 1
    end

    if IsControlOpen("RetainerTaskAsk") then
        UseControlAction("RetainerTaskAsk", "Assign", 0)
        d("Assigned venture successfully.")
        data.rStep = data.rStep + 1
        data.currentStep = 1
    end

end