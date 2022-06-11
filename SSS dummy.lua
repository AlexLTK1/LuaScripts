if self.clicked then
    self.colorBoolean = not self.colorBoolean
end

if self.colorBoolean then
    if Player.localmapid ~= 814 then
        if not MIsCasting() then
            Player:Teleport(138)
        end
    end

    if Player.localmapid == 814 then
        local nearby = MEntityList("maxdistance=5,contentid=1030409")
        if not table.valid(nearby) then
            Player:MoveTo(118.33, 55.36, 817.18)
                                else
                                                d("Arrived to your destination")
                        data = {}
                        self.colorBoolean = false
        end
    end
end