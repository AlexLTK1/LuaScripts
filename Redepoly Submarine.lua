if self.clicked then
    data.rStep = 0
    data.currentStep = 1
    self.colorBoolean = not self.colorBoolean
    if not data.gSkipTalkSet then
        gSkipTalk = true
    end
end

if self.colorBoolean then


    if Player.localmapid ~= 979 and Player.localmapid ~= 981 and Player.localmapid ~= 984 then
        if not MIsCasting() then
            Player:Teleport(164)
        end
    elseif Player.localmapid == 979 then
        local nearby = MEntityList("maxdistance=5,contentid=2002737")
        local yesno = GetControl("SelectYesno")
        if not table.valid(nearby) then
            Player:MoveTo(-744.8, -28.47, -581.2)
        else
            if not IsControlOpen("SelectString") then
                Player:SetTarget(next(nearby))
                Player:Interact(Player:GetTarget().id)
                if (yesno) then
                    yesno:Action("Yes")
                end
           end
        end

    elseif Player.localmapid == 981 then
        local nearby = MEntityList("maxdistance=5,contentid=2011571")
        if not table.valid(nearby) then
            Player:MoveTo(-5.9, 0.2, -5.87)
        else
            if not IsControlOpen("SelectString") then
                Player:SetTarget(next(nearby))
                Player:Interact(Player:GetTarget().id)
            else
                if IsControlOpen("SelectString") then
                    UseControlAction("SelectString", "SelectIndex", 0)
                end
            end
        end

    elseif Player.localmapid == 984 then
        Player:MoveTo(3.21, 0, 6.89)
        d("Arrived to company workshop")
    end


    local nearby = TensorCore.entityList("contentid=2011587")
    local p = TensorCore.mGetPlayer()
    if table.valid(nearby) then
        for k,v in pairs(nearby) do
            p:MoveTo(v.pos.x, v.pos.y, v.pos.z)
            if TensorCore.getDistance2d(p.pos, v.pos) <= 4 then
                Player:Interact(k)
                Player:Stop()
            end
        end
    end

    if data.currentStep == 1 and IsControlOpen("SelectString") then
        local i
        local control = GetControl("SelectString"):GetData()
        if table.valid(control) then
            for k,v in pairs(control) do
                if v == GetString("Submersible Management") then
                    i = k
                    break
                end
                
            end
            if i == nil then i = false end
        end

        if i ~= nil and not (i == false) then 
            UseControlAction("SelectString", "SelectIndex", i) 
            d("Selected GUI action successfully, moving on.")
            data.currentStep = 2
        end
    end

    if data.currentStep == 2 and IsControlOpen("SelectString") then
        UseControlAction("SelectString", "SelectIndex", data.rStep) 
        d("Selected GUI action successfully, moving on.")
        data.currentStep = 3
    end

    if data.currentStep == 3 and IsControlOpen("SelectString") then
        local i
        local control = GetControl("SelectString"):GetData()
        if table.valid(control) then
            for k,v in pairs(control) do
                if v == GetString("Quit") then
                    i = k
                    break
                end
                
            end
            if i == nil then i = false end
        end

        if i ~= nil and not (i == false) then 
            UseControlAction("SelectString", "SelectIndex", i) 
            d("Selected GUI action successfully, moving on.")
            data.rStep = data.rStep + 1
            data.currentStep = 2
        end
    end

    if IsControlOpen("AirShipExplorationResult") then
        GetControl("AirShipExplorationResult"):PushButton(25, 0)
        d("Got the Submarine result successfully.")
        data.rStep = data.rStep + 1
        data.currentStep = 2
    end
    

    if IsControlOpen("AirShipExplorationDetail") then
        GetControl("AirShipExplorationDetail"):PushButton(25, 0)
        d("Reassigned Submarine successfully.")
        data.rStep = data.rStep + 1
        data.currentStep = 2
    end

end