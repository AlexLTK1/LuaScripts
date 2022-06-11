if self.clicked then
    self.colorBoolean = not self.colorBoolean
    if not data.gSkipTalkSet then
        gSkipTalk = true
    end
    data.currentStep = 0
    data.currentStep2 = 0
    data.buff1 = 0
    data.buff2 = 0
end

if self.colorBoolean then

    if Player.localmapid~=129 and Player.localmapid~=128 and Player.localmapid~=177 then
        if not MIsCasting() then
            Player:Teleport(8)
            sleepTime=os.time()+10
        end
    elseif Player.localmapid==129 then -- In Lower Limsa Lominsa
          local nearby=MEntityList("maxdistance=5,contentid=8")
          if not table.valid(nearby) then
              Player:MoveTo(-80.165000544922,18.900321968449,-1.5230312347412)
              local ac=ActionList:Get(1,3)
              if MissingBuff(Player,50) and ac.cd==0 then
                  ac:Cast()
              end
          else
              d('Maelstrom GC Using Aethernet...')
              if IsControlOpen("SelectString") then
                  UseControlAction("SelectString","SelectIndex",0)
              elseif IsControlOpen("TelepotTown") then
                  UseControlAction("TelepotTown","Teleport",1)
                  sleepTime=os.time()+5
              else
                  Player:SetTarget(next(nearby))
                  Player:Interact(Player:GetTarget().id)
              end
          end
      elseif Player.localmapid==177 then -- In the Limsa Lominsa Inn
          local nearby=MEntityList("maxdistance=5,contentid=2001010")
          if not table.valid(nearby) then
              Player:MoveTo(0.23255725204945,0.007000000216066,6.0894904136658)
              local ac=ActionList:Get(1,3)
              if MissingBuff(Player,50) and ac.cd==0 then
                   ac:Cast()
              end
          elseif IsControlOpen("SelectYesno") then
              UseControlAction("SelectYesno","Yes")
              sleepTime=os.time()+5
          else
              Player:SetTarget(next(nearby))
              Player:Interact(Player:GetTarget().id)
          end
     end
    
    if  Player.localmapid == 128 then
        
        local buff1 = 0
        local buff2 = 0
        

        local nearby = MEntityList("maxdistance=5,contentid=1002389")
        if not table.valid(nearby) then
            Player:MoveTo(93.94, 40.40, 67.64)
        end

        if not IsControlOpen("SelectString") then
            Player:SetTarget(next(nearby))
            Player:Interact(Player:GetTarget().id)

        elseif IsControlOpen("SelectString") then
            UseControlAction("SelectString", "SelectIndex", 0)
        end

        if IsControlOpen("FreeCompanyExchange") and data.currentStep < 2 then
-- Press #2 one time to locate "Reduced Rates II" 
            PressKey(104) 
            data.currentStep = data.currentStep + 1
        end
        if IsControlOpen("SelectYesno") then
            UseControlAction("SelectYesno","No")
-- Change "Yes" to "No" above if you are testing
        end
        if data.buff2 == 8 then
            PressKey(27)
            self.colorBoolean = false
        end
        if IsControlOpen("FreeCompanyExchange") and data.buff1 < 9 then
            PressKey(96)
            data.buff1 = data.buff1 + 1
        end
        if IsControlOpen("FreeCompanyExchange") and data.buff1 == 9 and data.currentStep2 < 17 then 
-- Press #2 sixteen times from "Reduced Rates II" to locate "The Heat of Battle II"
            PressKey(104) 
            data.currentStep2 = data.currentStep2 + 1
        end
        
        if IsControlOpen("FreeCompanyExchange") and data.currentStep2 == 17 and data.buff2 < 8 then
            PressKey(96)
            data.buff2 = data.buff2 + 1
        end
        
    end
end