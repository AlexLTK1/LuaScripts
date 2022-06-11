if self.clicked then
    data.undercutStep = 0
    data.rStep = 0
    data.currentStep = 1
    data.itemtoundercut = 0
    data.movedown = 0
    data.itemselling = 5 -- undercut how many times per retainer
    self.colorBoolean = not self.colorBoolean
    if not data.gSkipTalkSet then
        gSkipTalk = true
    end
end

if self.colorBoolean then

    local retainerCount = 3


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
        Player:Teleport(97) -- teleport to my shiro house, wheres theres a summoning bell nearby
        self.colorBoolean = false
    end

    if IsControlOpen("RetainerList") and data.currentStep == 1 then
        if data.rStep < 3 then -- how many retainers you have, personally I have 3
            UseControlAction("RetainerList", "SelectIndex", data.rStep)
            data.currentStep = 2
            d("Selected retainer: ".. data.rStep)
        else
            d("Finished undercuting")
            self.colorBoolean = false
            GetControl("RetainerList"):Close()
        end
    end

    if data.currentStep == 2 and IsControlOpen("SelectString") then
        UseControlAction("SelectString", "SelectIndex", 3)
        data.currentStep = 3
    end 

    if data.currentStep == 4 and IsControlOpen("SelectString")  then
        PressKey(27)
        data.rStep = data.rStep + 1
        data.currentStep = 1
    end

    if IsControlOpen("RetainerSellList") and not IsControlOpen("RetainerSell") and data.itemtoundercut == data.itemselling then
        PressKey(27)
        data.itemtoundercut = 0
        data.currentStep = 4
    end

    if IsControlOpen("RetainerSellList") and not IsControlOpen("RetainerSell") and data.itemtoundercut < data.itemselling then
        if data.movedown == 0 then
            PressKey(98)
            data.movedown = 1
        elseif data.movedown == 1 then
            PressKey(96)
            data.movedown = 0
        end
    end

    if IsControlOpen("ContextMenu") then
        PressKey(96)
    end
   
    if IsControlOpen("RetainerSell") and data.undercutStep == 0 then
        data.undercutStep = data.undercutStep + 1

    elseif IsControlOpen("RetainerSell") and data.undercutStep == 1 then
        PressKey(104)
        data.undercutStep = data.undercutStep + 1
    
    elseif IsControlOpen("RetainerSell") and data.undercutStep == 2 then
        PressKey(96)
        data.undercutStep = data.undercutStep + 1
    
    elseif IsControlOpen("ItemSearchResult") and data.undercutStep == 3 then
        sleepTime=os.time()+10
        PressKey(27)
        data.undercutStep = data.undercutStep + 1
    
    elseif IsControlOpen("RetainerSell") and data.undercutStep == 4 then
        PressKey(98)
        data.undercutStep = data.undercutStep + 1

    elseif IsControlOpen("RetainerSell") and data.undercutStep == 5 then
        PressKey(96)
        data.undercutStep = data.undercutStep + 1
    
    elseif IsControlOpen("RetainerSell") and data.undercutStep == 6 then
        PressKey(13)
        data.undercutStep = data.undercutStep + 1
    
    elseif IsControlOpen("RetainerSell") and data.undercutStep == 7 then
        PressKey(13)
        data.undercutStep = data.undercutStep + 1
    
    elseif IsControlOpen("RetainerSell") and data.undercutStep == 8 then
        KeyDown(17)
        PressKey(86)
        data.undercutStep = data.undercutStep + 1

     elseif IsControlOpen("RetainerSell") and data.undercutStep == 9 then
        
        data.undercutStep = data.undercutStep + 1

     elseif IsControlOpen("RetainerSell") and data.undercutStep == 10 then
        KeyUp(17)
        data.undercutStep = data.undercutStep + 1

    elseif IsControlOpen("RetainerSell") and data.undercutStep == 11 then
        PressKey(13)
        data.undercutStep = data.undercutStep + 1

    elseif IsControlOpen("RetainerSell") and data.undercutStep == 12 then
        PressKey(98)
        data.undercutStep = data.undercutStep + 1

    elseif IsControlOpen("RetainerSell") and data.undercutStep == 13 then
        PressKey(98)
        data.undercutStep = data.undercutStep + 1

    elseif IsControlOpen("RetainerSell") and data.undercutStep == 14 then
        PressKey(96)
        data.undercutStep = 0
        data.itemtoundercut = data.itemtoundercut + 1
    end

end
        