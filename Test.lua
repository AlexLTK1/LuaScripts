if self.clicked then
    data.rStep = 0
    data.currentStep = 1
    self.colorBoolean = not self.colorBoolean
end

if self.colorBoolean then    

    if IsControlOpen("AirShipExploration") then
        GetControl("AirShipExploration"):PushButton(25, 0)
    end
end