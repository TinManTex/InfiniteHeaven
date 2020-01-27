--InfMBStaff.lua
local this={}

this.saveName="ih_priority_staff.lua"

--tex don't lose existing on modulereload
ih_priority_staff=ih_priority_staff or {
  staffIds={}
}

function this.BuildSaveText(saveName)
  local saveTextList={
    "-- "..saveName,
    "-- This is the list of staff ids for the staff priority on MB feature.",
    "local this={}",
  }

  IvarProc.BuildTableText("staffIds",ih_priority_staff.staffIds,saveTextList)

  saveTextList[#saveTextList+1]="return this"

  return saveTextList
end

function this.Save()
  InfCore.LogFlow"InfMBStaff.Save"
  local saveName=this.saveName
  local saveTextList=this.BuildSaveText(saveName)
  IvarProc.WriteSave(saveTextList,saveName)
end

function this.LoadSave()
  InfCore.LogFlow"InfMBStaff.LoadSave"
  local saveName=this.saveName
  local filePath=InfCore.paths.saves..saveName
  local ih_save_chunk,loadError=LoadFile(filePath)--tex WORKAROUND Mock
  if ih_save_chunk==nil then
    local errorText="LoadSave Error: loadfile error: "..tostring(loadError)
    InfCore.Log(errorText,true,true)
    return nil
  end

  local sandboxEnv={}
  if setfenv then
    setfenv(ih_save_chunk,sandboxEnv)
  end
  local ih_save=ih_save_chunk()

  if ih_save==nil then
    local errorText="LoadSave Error: ih_save==nil"
    InfCore.Log(errorText,true,true)

    return nil
  end

  if type(ih_save)~="table"then
    local errorText="LoadSave Error: ih_save==table"
    InfCore.Log(errorText,true,true)

    return nil
  end

  return ih_save
end

function this.AddPlayerStaff()
  local staffIds=ih_priority_staff.staffIds
  --tex staffId will be 0 when player not DD
  --will be that of staff selected when mission joined (or rather the last actually selected through proper sortie character selection)
  --so will stay same when changing between dd male/female, and still be 0 on switching to dd if joined map as snake/avatar
  --TODO: how to make clear to user in helispace, or anywhere of this?
  --On sortie character select
  --save playerType
  --save playerStaffId
  --save faceId??
  --if playerstaffid==0
  --elseif playerType~=lastSortieSelectedPlayerType
  --print current player type different from last selected
  local staffId=Player.GetStaffIdAtInstanceIndex(0)
  --InfCore.Log("playerStaffId:"..tostring(staffId),false,true)--DEBUG

  if staffId==0 then
    InfMenu.PrintLangId"please_select_dd"
  else
    if staffIds[staffId] then
      InfMenu.PrintFormatLangId("staff_id_exists",staffId)
    else
      InfMenu.PrintFormatLangId("add_staff_id",staffId)

      staffIds[staffId]=true
    end
  end
end

function this.RemovePlayerStaff()
  local staffIds=ih_priority_staff.staffIds

  local staffId=Player.GetStaffIdAtInstanceIndex(0)
  --InfCore.Log("playerStaffId:"..tostring(staffId),false,true)--DEBUG

  if staffId==0 then
    InfMenu.PrintLangId"please_select_dd"
  else
    if staffIds[staffId] then
      staffIds[staffId]=false
      InfMenu.PrintFormatLangId("removing_staff_id",staffId)
    else
      InfMenu.PrintFormatLangId("staff_id_not_exist",staffId)
    end
  end
end

function this.AddMarkerStaff()
  if vars.missionCode~=30050 then
    InfMenu.PrintLangId"only_on_mb"
    return
  end

  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    --InfCore.DebugPrint("lastMarkerIndex==nil")
    InfMenu.PrintLangId"no_marker_found"
    return
  end

  local gameId=vars.userMarkerGameObjId[lastMarkerIndex]
  if gameId==GameObject.NULL_ID then
    InfMenu.PrintLangId"soldier_not_marked"
    return
  end

  local typeIndex=GameObject.GetTypeIndex(gameId)
  if typeIndex~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    InfMenu.PrintLangId"soldier_not_marked"
    return
  end

  local staffIds=ih_priority_staff.staffIds
  local staffId=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=gameId}
  --InfCore.Log("playerStaffId:"..tostring(staffId),false,true)--DEBUG

  if staffId==0 then
  --InfCore.Log("WARNING staffId==0 ",true,true)--DEBUG
  else
    if staffIds[staffId] then
      InfMenu.PrintFormatLangId("staff_id_exists",staffId)
    else
      InfMenu.PrintFormatLangId("add_staff_id",staffId)

      staffIds[staffId]=true
    end
  end
end

function this.RemoveMarkerStaff()
  if vars.missionCode~=30050 then
    InfMenu.PrintLangId"only_on_mb"
    return
  end

  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    --InfCore.DebugPrint("lastMarkerIndex==nil")
    InfMenu.PrintLangId"no_marker_found"
    return
  end

  local gameId=vars.userMarkerGameObjId[lastMarkerIndex]
  if gameId==GameObject.NULL_ID then
    InfMenu.PrintLangId"soldier_not_marked"
    return
  end

  local typeIndex=GameObject.GetTypeIndex(gameId)
  if typeIndex~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    InfMenu.PrintLangId"soldier_not_marked"
    return
  end

  local staffIds=ih_priority_staff.staffIds
  local staffId=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=gameId}
  --InfCore.Log("playerStaffId:"..tostring(staffId),false,true)--DEBUG

  if staffId==0 then
  --InfCore.Log("WARNING staffId==0 ",true,true)--DEBUG
  else
    if staffIds[staffId] then
      staffIds[staffId]=false
      InfMenu.PrintFormatLangId("removing_staff_id",staffId)
    else
      InfMenu.PrintFormatLangId("staff_id_not_exist",staffId)
    end
  end
end

function this.ClearPriorityStaff()
  ih_priority_staff.staffIds={}
  InfMenu.PrintLangId"staff_clear"
end

function this.IsPriorityStaff(staffId)
  --tex trying to match direct staffList value to ih_priority_staff doesnt work due to some difference in original float value and value after is been converted to text for the save file and back.
  --UGH, but it works.
  local staffStr=tostring(staffId)
  staffId=tonumber(staffStr)

  return ih_priority_staff.staffIds[staffId]
end

return this
