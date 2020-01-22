





local this = {}





this.SerializeEvent = function( stream, fromId, eventCode, triggeringTeam, triggerId  )



    local hasTrigger = stream:SerializeBoolean(triggerId ~= nil)
    local serialFromId = stream:SerializeInteger(fromId)
    local serialEventCode = stream:SerializeInteger(eventCode)
    local serialTriggeringTeam = stream:SerializeInteger(triggeringTeam)
    local serialTriggerId = -1
    if hasTrigger then
        serialTriggerId = stream:SerializeInteger(triggerId)
    end









    return serialFromId, serialEventCode, serialTriggeringTeam, serialTriggerId

end







return this
