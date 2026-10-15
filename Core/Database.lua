local addonName, CC = ...

function CC:GetCurrentGuide()
    local info = self:GetPlayerInfo()
    if not info.classFile or not info.specID then
        return nil
    end

    local classData = self.data[info.classFile]
    if not classData then
        return nil
    end

    return classData[info.specID]
end

function CC:GetGuide(classFile, specID)
    local classData = self.data[classFile]
    return classData and classData[specID] or nil
end
