-- DOBUILD: 1
-- TppDefine.lua
-- tex modfying some values via other modules
-- most of the location and mission data added to via InfMission with addons.
InfCore.Log"Load TppDefine.lua"--tex --DEBUG
local this={}

local StrCode32=InfCore.StrCode32--tex was Fox.StrCode32
local bnot=bit.bnot
local band,bor,bxor=bit.band,bit.bor,bit.bxor

--NMC GOTCHA TppDefine.Enum indexed from 0, Tpp.Enum indexed from one.
--GOTCHA pulls via pairs, so could use a non array table TODO review in light of this
function this.Enum(enumNames)
  if type(enumNames)~="table"then
    return
  end
  local enumTable={}
  for i,enumName in pairs(enumNames)do
    enumTable[enumName]=i-1--NMC: lua tables indexed from 1, enums indexed from 0
  end
  return enumTable
end
this.SMALL_DIAMOND_GMP=10000
this.LARGE_DIAMOND_GMP=100000
this.MAX_32BIT_UINT=4294967295
this.EXCEPTION_QUEUE_MAX=255
this.PICKABLE_MAX=16
this.PLACED_MAX=8
this.DEFAULT_EQUIP_MISSION_BLOCK_GROUP_SIZE=1677721
this.MISSION_COUNT_MAX=64
this.DEFAULT_SOLDIER_STATE_COUNT=160
this.DEFAULT_SOLDIER_OPTION_VARS_COUNT=160
this.DEFAULT_PASSAGE_INFO_COUNT=64
this.DEFAULT_PASSAGE_FLAG_COUNT=this.DEFAULT_PASSAGE_INFO_COUNT*5
this.DEFAULT_NOTICE_INFO_COUNT=24
this.DEFAULT_HOSTAGE_STATE_COUNT=32
this.ENEMY_FOVA_UNIQUE_SETTING_COUNT=16
this.DEFAULT_ENEMY_HELI_STATE_COUNT=1--NMC: despite the heli svar declarations being set up for an array like all the other object save vars, the actual saving may be to a non array? see TppEnemy.RestoreOnContinueFromCheckPoint2, RestoreOnMissionStart2, though that's just the reset, actual save/restore is in exe so not sure what its actually doing
this.DEFAULT_WALKER_GEAR_STATE_COUNT=4--tex added
this.DEFAULT_UAV_STATE_COUNT=0--tex added, search MAX_UAV_COUNT (set on fob)
this.MAX_HOLD_RECOVERED_STATE_COUNT=32
this.MAX_HOLD_VEHICLE_BROKEN_STATE_COUNT=32
this.MAX_ANIMAL_RECOVERED_HISTORY_SIZE=50
this.MAX_SECURITY_CAMERA_COUNT=64
this.MAX_UAV_COUNT=16
this.SEARCH_TARGET_COUNT=8
this.CHECK_POINT_MAX=64
this.QUEST_MAX=250
this.QUEST_FACE_MAX=32
this.QUEST_ENEMY_MAX=8
this.REVENGE_MINE_BASE_MAX=20
this.MISSION_CLEAR_HISTORY_LIMIT=36
this.MAX_MISSION_TASK_COUNT=8
this.MAX_TAKING_OVER_HOSTAGE_COUNT=4
this.MAX_MB_DEMO_PLAYFLAG_MAX=4
this.INIT_HELI_ROUTE=0
this.PLAYSTYLE_SAVE_INDEX_MAX=20
this.PLAYSTYLE_HISTORY_MAX=2
this.MAX_TIPS_GUIDE_SHOWN_ONCE=256
this.MAX_CONTROL_GUIDE_SHOWN_ONCE=128
this.MESSAGE_GENERATION={[StrCode32"GameObject"]={[StrCode32"Fulton"]=0,[StrCode32"VehicleBroken"]=0}}
this.DEFAULT_MESSAGE_GENERATION=1
this.ELAPSED_MISSION_COUNT_MAX=14
this.ELAPSED_MISSION_COUNT={INIT=-127,DONE_EVENT=-1,NOW_OCCURRING=0}
this.ELAPSED_QUEST_COUNT={INIT=-127,DONE_EVENT=-1,NOW_OCCURRING=0}
this.MISSION_START_RECOVER_DEMO_TYPE={NONE=0,VEHICLE=1,WALKER_GEAR=2}
this.REWARD_MAX={MISSION=16,MB_MANAGEMENT=64,QUEST=8}
this.REWARD_PARAM={TYPE=0,ARG1=1,ARG2=2,MAX=3}
this.TRAP_TYPE=this.Enum{"NORMAL","TRIGGER"}
this.TRAP_STATE=this.Enum{"ENABLE","DISABLE"}
this.HOSTAGE_GM_TYPE=this.Enum{TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2,TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE,TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2}
this.FULTONABLE_GIMMICK_TYPE=this.Enum{TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,TppGameObject.GAME_OBJECT_TYPE_MORTAR,TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN}
this.QUEST_MINE_TYPE_LIST={TppEquip.EQP_SWP_DMine,TppEquip.EQP_SWP_DMine_G01,TppEquip.EQP_SWP_DMine_G02}
this.BUDDY_GM_TYPE_TO_BUDDY_TYPE={
  [TppGameObject.GAME_OBJECT_TYPE_HORSE2]=BuddyType.HORSE,
  [TppGameObject.GAME_OBJECT_TYPE_BUDDYQUIET2]=BuddyType.QUIET,
  [TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2]=BuddyType.QUIET,
  [TppGameObject.GAME_OBJECT_TYPE_BUDDYDOG2]=BuddyType.DOG,
  [TppGameObject.GAME_OBJECT_TYPE_BUDDYPUPPY]=BuddyType.DOG
}
this.ANIMAL_GAMEOBJECT_TYPE=this.Enum{
  TppGameObject.GAME_OBJECT_TYPE_GOAT,
  TppGameObject.GAME_OBJECT_TYPE_NUBIAN,
  TppGameObject.GAME_OBJECT_TYPE_CRITTER_BIRD,
  TppGameObject.GAME_OBJECT_TYPE_STORK,
  TppGameObject.GAME_OBJECT_TYPE_EAGLE,
  TppGameObject.GAME_OBJECT_TYPE_RAT,
  TppGameObject.GAME_OBJECT_TYPE_ZEBRA,
  TppGameObject.GAME_OBJECT_TYPE_WOLF,
  TppGameObject.GAME_OBJECT_TYPE_JACKAL,
  TppGameObject.GAME_OBJECT_TYPE_BEAR
}
this.MISSION_CLEAR_STATE_LIST={"INIT","NOT_CLEARED_YET","ESTABLISHED_CLEAR","MISSION_GAME_END","SHOW_CREDIT_END","BLACK_TELEPHOHE_END","REWARD_END","MISSION_FINALIZED"}
this.MISSION_CLEAR_STATE=this.Enum(this.MISSION_CLEAR_STATE_LIST)
--tex popupIds expanded from other references in init_sequence ERROR_POPUP_ID (local), 
--TppException SHOW_EXECPTION_DIALOG, TppUiCommand.ShowErrorPopup,TppUiCommand.IsShowPopup calls
--those with _UNK suffix are my own guessed names, pretty anything that's not the original TppDefine.ERROR_IDs
--TODO: throw the popups up, search the text in lng files and use the langId names as hints
--tpp_dialog.eng.lng2 has ids right in langId ex system_3001_all
--but those are often using the langIds directly rather than error ids
--also tpp_system_stm (platform specific messages, theres _xb1, _ps4 etc, but only for eng?)
--some that dont show in testing possibly are the platform specific ones (ex SAVE_FAILED_CANNOT_FIND_STORAGE=1103, shows nothing, but has system_1103_x36 , x360 entry)
--none of this hugely useful at the moment beyond providing InfLookup popupId lookup for PrintOnMessage (and even then a heap of these use langId directly instead of their errorid)
this.ERROR_ID={
  CONFIRM_AUTO_SAVE=1000,--TppDefine.ERROR_ID--<Entry LangId="system_1000_stm" Color="1" Value="This game has an autosave feature.&#xA;A notification will appear on screen when the game is saving.&#xA;Do not close the application during this time." />

  MAKE_NEW_SAVE_DATA=1100,--TppDefine.ERROR_ID -- <Entry LangId="system_1100_stm" Color="1" Value="Creating save data...&#xA;Do not close the application." />
  SAVE_FAILED_NOT_ENOUGH_STORAGE_CAPACITY=1101,--TppDefine.ERROR_ID-- <Entry LangId="system_1101_stm" Color="1" Value="There is insufficient data storage space.&#xA;At least %s %s of free space is required to play&#xA;METAL GEAR SOLID V: THE PHANTOM PAIN." />
  SAVE_FAILED_UNKNOWN_REASON=1102,--TppDefine.ERROR_ID-- <Entry LangId="system_1102_all" Color="1" Value="Failed to create save data.&#xA;Exit the game and delete save data." />
  SAVE_FAILED_CANNOT_FIND_STORAGE=1103,--TppDefine.ERROR_ID

  CREATE_OR_SAVE_DATA_NOT_NEW_UNK=1120,--init_sequence CreateOrLoadSaveData--IMPORT_RESULT_FAILED
  CREATE_OR_SAVE_DATA_IMPORT_RESULT_FAILED_UNK=1121,--init_sequence CreateOrLoadSaveData--IMPORT_RESULT_FAILED
  
  LOADING_SAVE_DATA=1200,--TppDefine.ERROR_ID-- <Entry LangId="system_1200_stm" Color="1" Value="Loading save data...&#xA;Do not close the application." />
  LOAD_RESULT_OWNER_ERROR=1202,--TppDefine.ERROR_ID
  LOAD_RESULT_BACKUP_ERROR=1203,--TppDefine.ERROR_ID-- <Entry LangId="system_1203_all" Color="1" Value="Save data is corrupted.  &#xA;Restoring to previous save." />
  LOAD_RESULT_FILE_CORRUPT_ERROR=1204,--TppDefine.ERROR_ID-- <Entry LangId="system_1204_all" Color="1" Value="Failed to load save data.&#xA;The data could be corrupted.&#xA;&#xA;Create new save data?&#xA;Current data will be overwritten.&#xA;&#xA;Select &quot;NO&quot; to attempt to load current data again." />
  LOAD_RESULT_VERSION_ERROR=1205,--TppDefine.ERROR_ID-- <Entry LangId="system_1205_stm" Color="1" Value="Save data version and game version are different.&#xA;Sign in to Steam and download the latest game version.&#xA;Exiting game..." />
  --1206,--nothing shown (no langid hits for system_)
  LOAD_RESULT_CONFIG_FILE_CORRUPT_ERROR=1207,--TppDefine.ERROR_ID-- <Entry LangId="system_1207_all" Color="1" Value="Failed to load save data.&#xA;Game progress was saved, but part of the data is corrupted.&#xA;Repairing save data." />

  NOT_SELECT_STORAGE=1300,--TppDefine.ERROR_ID
  CHECKING_STORAGE_FREE_SPACE_SIZE=1301,--TppDefine.ERROR_ID
  CANNOT_FIND_STORAGE_IN_GAME=1302,--TppDefine.ERROR_ID

  --1200,--?? (no langid hits for system_)
  START_NOT_SIGN_IN=2001,--TppDefine.ERROR_ID- <Entry LangId="system_2001_stm" Color="1" Value="Since you are not signed in, the game cannot be saved. Your game progress will not be saved if you continue without signing in." />

  SIGNIN_USER_CHANGED=2100,--TppDefine.ERROR_ID
  
  DISCONNECT_FROM_PSN=2200,--TppDefine.ERROR_ID-- <Entry LangId="system_2200_all" Color="1" Value="You have signed out.&#xA;You will not be able to use online features." />
  
  BANNED_FROM_MP_UNK=2300,-- <Entry LangId="system_2300_stm" Color="1" Value="You have been banned from multiplayer. You will not be able to use online features. Game will begin in offline mode.&#xA;&#xA;*You will not be able to use GMP or resources stored on your FOBs.&#xA;Connect online again to access your FOB inventory." />
  PROFILE_RESTRICTED_FROM_USER_CONTENT_UNK=2301,-- <Entry LangId="system_2301_stm" Color="1" Value="The currently signed-in profile is restricted from viewing user-created content, so you are unable to use the exchange feature to send/receive user-created content such as emblems." />
  PROFILE_RESTRICTED_FROM_VOICE_CHAT_UNK=2302,-- <Entry LangId="system_2302_stm" Color="1" Value="The currently signed-in profile is restricted from using voice chat, so you will be unable to use the voice chat feature." />
  PROFILE_RESTRICTED_FROM_MP_UNK=2303,-- <Entry LangId="system_2310_stm" Color="1" Value="Online multiplayer access has been restricted.&#xA;You will not be able to fight other players personally during online base defenses, so the rewards for successfully defending your base will not be as great.&#xA;We recommend enabling multiplayer to get added enjoyment out of the game." />
  NO_CONTROLLER_CONNECTED_UNK=2304,-- <Entry LangId="system_2400_stm" Color="1" Value="No controller connected.&#xA;Please connect a controller." />

  --3000,--?? (no langid hits for system_)
  DID_NOT_ACCEPT_TERMS_OF_USE_UNK=3001,-- <Entry LangId="system_3001_all" Color="1" Value="As you have not agreed to the Terms of Use, you will not be able to use online features such as uploading rankings or records. You must agree to the Terms of Use in order to use online features.&#xA;&#xA;Begin game in offline mode?" />
  CANNOT_USE_FEATURE_IN_OFFLINE_MODE_UNK=3002,-- <Entry LangId="system_3002_all" Color="1" Value="You cannot use this feature because you are in offline mode." />
  --uhh what? theres already a 3002 -- Jikan tanshuku 'Time saving' <Entry LangId="system_3002_jikantansyuku" Color="1" Value="Reduced Time features cannot be used in offline mode." />
  CANNOT_USE_FEATURE_IN_OFFLINE_MODE_3_UNK=3003,-- <Entry LangId="system_3003_all" Color="1" Value="Unable to use this feature since you are in offline mode.&#xA;&#xA;To switch to online mode, select CONNECT ONLINE from the Pause menu." />
  CANNOT_USE_FEATURE_IN_OFFLINE_MODE_4_UNK=3004,-- <Entry LangId="system_3004_all" Color="1" Value="Unable to use this feature since you are in offline mode.&#xA;&#xA;To switch to online mode, select CONNECT ONLINE from the Pause menu in the Aerial Command Center (ACC)." />
  NOT_SIGNED_IN_UNK=3005,-- <Entry LangId="system_3005_stm" Color="1" Value="You must be signed in to use this feature." />

  --3100,--nothing shown (no langid hits for system_)
  NOT_CONNECTED_TO_INTERNET_UNK=3101,-- <Entry LangId="system_3101_stm" Color="1" Value="As you are not connected to the internet, you will not be able to use online features such as uploading rankings or records to the server. Game will begin in offline mode.&#xA;&#xA;*You will not be able to use GMP or resources stored on your FOBs.&#xA;Connect online again to access your FOB inventory." />

  LOGGING_IN_UNK=3200,-- <Entry LangId="system_3200_all" Color="1" Value="Logging in to server..." />
  LOGGING_IN_FAILED_UNK=3201,-- <Entry LangId="system_3201_all" Color="1" Value="Logged in to server." />
  LOGGING_IN_FAILED_2_UNK=3202,-- <Entry LangId="system_3202_all" Color="1" Value="Failed to log in to server.&#xA;You will not be able to use online features." />
  LOGGING_IN_FAILED_3_UNK=3203,-- <Entry LangId="system_3203_all" Color="1" Value="Failed to log in to server.&#xA;You will not be able to use online features." />
  SERVER_UNDERGOING_MAINTENANCE_UNK=3204,-- <Entry LangId="system_3204_all" Color="1" Value="The server is undergoing maintenance. You will not be able to use online features such as uploading rankings or records. Game will begin in offline mode.&#xA;&#xA;For maintenance information, visit the official game website." />
  ONLINE_SERVICES_CONCLUDED_UNK=3205,-- <Entry LangId="system_3205_all" Color="1" Value="Online services have concluded. You will not be able to use online features such as uploading rankings or records. Game will begin in offline mode. &#xA;&#xA;For further information, visit the official game website." />
  SERVER_HIGH_TRAFFIC_UNK=3206,-- <Entry LangId="system_3206_all" Color="1" Value="Failed to establish connection with server due to high traffic. You will not be able to use online features such as uploading rankings or records. Game will begin in offline mode." />
  DISCONNECT_FROM_KONAMI=3207,--TppDefine.ERROR_ID-- <Entry LangId="system_3207_all" Color="1" Value="Failed to establish connection with server. You will not be able to use online features such as uploading rankings or records. Game will begin in offline mode." />
  SERVER_CONNECTION_FAILED_2_UNK=3208,-- <Entry LangId="system_3208_all" Color="1" Value="Failed to establish connection with server. You will not be able to use online features such as uploading rankings or records. Game will begin in offline mode." />
  ACCOUNT_BANNED_UNK=3209,-- <Entry LangId="system_3209_all" Color="1" Value="This account is banned from logging in to the game server.&#xA;Rankings and other online functions will be disabled.&#xA;Starting Game..." />
  --3210,--nothing shown (no langid hits for system_)
  CONNECTING_TO_SERVER_UNK=3211,-- <Entry LangId="system_3211_all" Color="1" Value="Connecting to server..." />
  ALLREADY_CONNECTED_UNK=3212,-- <Entry LangId="system_3212_all" Color="1" Value="You are already connected to the server." />

  DISCONNECT_FROM_NETWORK=3300,--TppDefine.ERROR_ID-- <Entry LangId="system_3300_all" Color="1" Value="A network error has occurred.&#xA;You will not be able to use online features." />
  
  NETWORK_ERROR_WHILE_PROCESSING_MB_COINS_UNK=3310,-- <Entry LangId="system_3310_all" Color="1" Value="A network error occurred while processing your MB Coin transaction.&#xA;The game will continue in offline mode.&#xA;You may confirm your MB Coin transaction the next time you are online." />

  SESSION_DISCONNECT_FROM_HOST=4180,--TppDefine.ERROR_ID-- <Entry LangId="system_4180_all" Color="1" Value="You have been disconnected from session." />
  SESSION_DELETE_MEMBER_UNK=4181,--TppException msg Nt.SessionDeleteMember-- <Entry LangId="system_4181_all" Color="1" Value="Other player has left session." />

  ANOTHER_PLAYER_ALREADY_INFILTRATING_UNK=4200,-- <Entry LangId="system_4200_all" Color="1" Value="Another player is already infiltrating.&#xA;FOB infiltration aborted." />
  INFILTRATOR_NO_LONGER_PRESENT_UNK=4201,-- <Entry LangId="system_4201_all" Color="1" Value="Infiltrator no longer present.&#xA;Aborting FOB defense." />
  ANOTHER_PLAYER_IS_DEFENDING_UNK=4202,-- <Entry LangId="system_4202_all" Color="1" Value="Another player is defending.&#xA;Aborting FOB defense." />
  INTRUDER_LEFT_UNK=4203,-- <Entry LangId="system_4203_all" Color="1" Value="Intruder has already vacated FOB." />

  FAILED_TO_ADD_TO_SUPPORTING_LIST_UNK=4300,-- <Entry LangId="system_4300_all" Color="1" Value="Failed to add to Supporting List." />
  FAILED_TO_DISCONTINUE_SUPPORT_UNK=4301,-- <Entry LangId="system_4301_all" Color="1" Value="Failed to discontinue support." />
  SUPPORTING_LIST_FULL_UNK=4302,-- <Entry LangId="system_4302_all" Color="1" Value="Your Supporting List has reached maximum capacity. &#xA;Discontinue support of players you no longer require, and try again." />
  
  GET_MGO_INVITATION=5000,--TppDefine.ERROR_ID-- <Entry LangId="system_5000_all" Color="1" Value="Invite received from MGO.&#xA;Starting MGO." />
  MGO_INVITATION_ACCEPT_UNK=5001,--TppException.SHOW_EXECPTION_DIALOG TYPE.INVITATION_ACCEPT GetCurrentGameMode()==this.GAME_MODE.TPP_FOB-- <Entry LangId="system_5001_all" Color="1" Value="Accept MGO invite?&#xA;If you accept, all game progress since last checkpoint will be lost." />
  VERIFY_GO_TO_MGO=5002,-- <Entry LangId="system_5002_all" Color="1" Value="Are you sure you want to go to METAL GEAR ONLINE?" />
  INVITATION_PATCH_DLC_ERROR_TOU_UNK=5003,--TppException.SHOW_EXECPTION_DIALOG TYPE.INVITATION_PATCH_DLC_ERROR-- <Entry LangId="system_5003_all" Color="1" Value="You have received an invitation to play Metal Gear Online, &#xA;but you cannot accept since you have not agreed to the terms of use." />
  INVITATION_MUST_COMPLETE_FIRST_STORY_MISSION_UNK=5004,--TppException.SHOW_EXECPTION_DIALOG TYPE.INVITATION_ACCEPT not TppStory.CanPlayMgo-- <Entry LangId="system_5004_all" Color="1" Value="You have received an invitation to play Metal Gear Online, &#xA;but you cannot accept until you have proceeded further into the game." />
  INVITATION_ACCEPT_BY_OTHER=5005,--TppException.SHOW_EXECPTION_DIALOG TYPE.INVITATION_ACCEPT_BY_OTHER
  INVITATION_PATCH_DLC_DOES_NOT_EXIST=5006,--init_sequence Seq_Demo_CheckMgoInvitation not PatchDlc.DoesExistPatchDlc
  
  MGO_INVITATION_CANCEL=5010,--TppException.MGO_INVITATION_CANCEL_POPUP_ID, --TppException.SHOW_EXECPTION_DIALOG TYPE.INVITATION_ACCEPT GetCurrentGameMode()==this.GAME_MODE.TPP_FOB
  INVITATION_ACCEPT_WITHOUT_SIGNIN=5012,--TppException.SHOW_EXECPTION_DIALOG TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN
  IS_DISABLED_MGO_IN_CHINA_KOREA_UNK=5013,--TppException.SHOW_EXECPTION_DIALOG TYPE.INVITATION_ACCEPT IsDisabledMgoInChinaKorea
  
  MGO_INVITATION_NOT_ACCEPTED_UNK=5050,--init_sequence Seq_Demo_GoToMgo
  INVITATION_MUST_COMPLETE_FIRST_STORY_MISSION_CHECK_BOOT_MGO_UNK=5051,--init_sequence Seq_Demo_CheckBootTypeMgo
  
  IS_CHECKING_PATCH_DLC_MGO_UNK=5100,--Tpp.PatchDlcCheckCoroutine IsCheckingPatchDlc PatchDlc.PATCH_DLC_TYPE_MGO_DATA
  
  IS_CHECKING_PATCH_DLC_TPP_UNK=5150,--Tpp.PatchDlcCheckCoroutine IsCheckingPatchDlc PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA

  NOW_INSTALLATION_CHECKING=7000,--TppDefine.ERROR_ID
  INSTALL_DATA_BROKEN=7001,--init_sequence ERROR_POPUP_ID
  CANNOT_FIND_HDD=7002,--TppDefine.ERROR_ID
  NOW_INSTALLING=7003,--TppDefine.ERROR_ID-- <Entry LangId="system_7003_stm" Color="1" Value="Installing game data...&#xA;Do not close the application.&#xA;%s %%" />
  INSTALL_CANCEL=7004,--TppDefine.ERROR_ID---- <Entry LangId="system_7004_stm" Color="1" Value="Installation will be canceled.&#xA;Are you sure?" />
  INSTALL_FAILED_NOT_ENOUGH_STORAGE_CAPACITY=7005,--TppDefine.ERROR_ID
  INSTALL_FAILED_UNKNOWN_REASON=7006,--init_sequence names it INSTALL_NOSPACE

  --7050,--?? (no langid hits for system_)
  INSERT_GAME_DISK_WHEN_INSTALL_END=7051,--TppDefine.ERROR_ID
  INSERT_GAME_DISK_WHEN_ALREADY_INSTALLED=7052,--TppDefine.ERROR_ID
  
  INSERT_INSTALL_DISK_WHEN_NOT_INSTALLED=7060,--TppDefine.ERROR_ID (was in list after NOW_INSTALLATION_CHECKING=7000)
  
  DOWNLOAD_INSTALL_START=7070,--init_sequence ERROR_POPUP_ID
  DOWNLOAD_INSTALL_CANCEL=7071,--init_sequence ERROR_POPUP_ID
  DOWNLOAD_INSTALL_NEED_SIGN_IN=7072,--init_sequence ERROR_POPUP_ID
  DOWNLOAD_INSTALL_INSTALLING=7073,--init_sequence ERROR_POPUP_ID
  
  TROPHY_INITIALIZE=7100,--in ps3 (system_7100_ps3),ps4 lng files only-- <Entry LangId="system_7100_ps4" Color="1" Value="Initializing Trophy Set...&#xA;Do not turn the system off." />
  TROPHY_INSTALLING=7101,--TppDefine.ERROR_ID
  TROPHY_INSTALL_FAILED=7102,--TppDefine.ERROR_ID

  CHECKING_DLC_UNK=8000,-- <Entry LangId="system_8000_all" Color="1" Value="Checking downloadable content..." />
  DLC_DOWNLOAD_ERROR=8001,--TppDefine.ERROR_ID-- <Entry LangId="system_8001_stm" Color="1" Value="Downloadable content is corrupted.&#xA;Exit the game and delete game data.&#xA;Downloadable content can be re-downloaded from the Steam Store." />
  
  DLC_ADDED_ITEM_UNK=8010,-- <Entry LangId="system_8010_all" Color="1" Value="Downloadable content has been added.&#xA;[%s] is now available for development." />
  DLC_ADDED_STAFF_UNK=8011,-- <Entry LangId="system_8011_all" Color="1" Value="Downloadable content has been added.&#xA;[Mother Base Staff] can now join your unit.&#xA;&#xA;These staff will gradually join your unit as you progress through the game." />
  DLC_ADDED_EMBLEM_UNK=8012,-- <Entry LangId="system_8012_all" Color="1" Value="Downloadable content has been added.&#xA;Emblem part [%s] is now available." />
  DLC_STATUS_CHANGED_IN_TITLE_UNK=8013,--TppException.OnDlcStatusChanged-- <Entry LangId="system_8013_stm" Color="1" Value="Downloadable content has been added." />
  DLC_STATUS_CHANGED_UNK=8014,--TppException.OnDlcStatusChanged-- <Entry LangId="system_8014_stm" Color="1" Value="Downloadable content has been added.&#xA;You must return to the Title Menu in order to use your new downloadable content." />
  DLC_ADDED_1_UNK=8015,-- <Entry LangId="system_8015_stm" Color="1" Value="Downloadable content has been added.&#xA;You must return to the Title Menu in order to use your new downloadable content.&#xA;Returning to Title Menu now." />
  DLC_ADDED_2_UNK=8015,-- <Entry LangId="system_8016_stm" Color="1" Value="Downloadable content has been added.&#xA;You must return to the Title Menu in order to use your new downloadable content.&#xA;Return to Title Menu now?" />

  DLC_DELETED_ITEM_UNK=8020,-- <Entry LangId="system_8020_all" Color="1" Value="Downloadable content has been deleted.&#xA;[%s] is no longer available for development." />
  DLC_DELETED_STAFF_UNK=8021,-- <Entry LangId="system_8021_all" Color="1" Value="Downloadable content has been deleted.&#xA;[Mother Base Staff] can no longer join your unit." />
  DLC_DELETED_EMBLEM_UNK=8022,-- <Entry LangId="system_8022_all" Color="1" Value="Downloadable content has been deleted.&#xA;Emblem part [%s] is no longer available.&#xA;&#xA;If this part was in use, your emblem will revert to its default status." />
  DLC_FROM_SAVE_NOT_FOUND_UNK=8023,-- <Entry LangId="system_8023_stm" Color="1" Value="This save data cannot be used, as the relevant downloadable content was not found.&#xA;&#xA;Downloadable content can be re-downloaded from the Steam Store." />
 
  GZ_DOWNLOAD_DATA_UNK=9000,-- <Entry LangId="system_9000_all" Color="1" Value="METAL GEAR SOLID V: GROUND ZEROES&#xA;save data will be downloaded.&#xA;Downloaded save data can be carried over to&#xA;METAL GEAR SOLID V: THE PHANTOM PAIN.&#xA;Download save data?" />
  GZ_NO_DATA_UNK=9001,-- <Entry LangId="system_9001_all" Color="1" Value="No save data found.&#xA;Canceling download.&#xA;&#xA;*To carry over save data, you must first start&#xA;METAL GEAR SOLID V: GROUND ZEROES&#xA;and upload your save data." />
  GZ_DOWNLOADING_DATA_UNK=9002,-- <Entry LangId="system_9002_all" Color="1" Value="Downloading save data..." />
  GZ_DOWNLOAD_DATA_COMPLETE_UNK=9003,-- <Entry LangId="system_9003_all" Color="1" Value="Save data download completed." />
  GZ_DOWNLOAD_DATA_FAILED_UNK=9004,-- <Entry LangId="system_9004_all" Color="1" Value="Save data download failed." />
 
  GZ_DATA_ADDED_ITEM_UNK=9010,-- <Entry LangId="system_9010_all" Color="1" Value="Save data transferred.&#xA;[%s] is now available for development." />
  GZ_DATA_ADDED_STAFF_UNK=9011,-- <Entry LangId="system_9011_all" Color="1" Value="Save data transferred.&#xA;[Mother Base Staff] can now join your unit.&#xA;&#xA;These staff will gradually join your unit as you progress through the game." />

  DLC_ERROR_NETWORK=9020,--init_sequence ERROR_POPUP_ID  -- <Entry LangId="system_9020_stm" Color="1" Value="In order for your exclusive content from &quot;METAL GEAR SOLID V: GROUND ZEROES&quot; to be reflected, you must be connected to the internet." />

  INVITATION_MUST_COMPLETE_FIRST_STORY_MISSION_PS_UNK=9030,--init_sequence Seq_Demo_CheckBootGz
  GO_TO_GZ_UNK=9031,--init_sequence Seq_Demo_GoToGz

  RETURNING_TO_TITLE_UNK=9900,-- <Entry LangId="system_9900_all" Color="1" Value="Returning to title menu." />
  FETCHING_DATA_UNK=9901,-- <Entry LangId="system_9901_all" Color="1" Value="Fetching data..." />
  NO_DATA_FOUND_UNK=9902,-- <Entry LangId="system_9902_all" Color="1" Value="No data found." />
  FAILED_TO_FETCH_DATA_UNK=9903,-- <Entry LangId="system_9903_all" Color="1" Value="Failed to fetch data." />
  EXITING_SESSION_UNK=9904,-- <Entry LangId="system_9904_all" Color="1" Value="Exiting session." />
  ENTERING_OFFLINE_MODE_UNK=9905,-- <Entry LangId="system_9905_all" Color="1" Value="Entering offline mode." />
  CREATING_SESSION_UNK=9906,-- <Entry LangId="system_9906_all" Color="1" Value="Creating session..." />
  FAILED_TO_CREATE_SESSION_UNK=9907,-- <Entry LangId="system_9907_all" Color="1" Value="Failed to create session." />
}--ERROR_ID
--tex fold in lookup>
local tmp={}--tex cant add to table you're iterating, use a temp
for name,enum in pairs(this.ERROR_ID)do
  tmp[enum]=name
end--for ERROR_ID<
for enum,name in pairs(tmp)do
  this.ERROR_ID[enum]=name
end--for tmp
tmp=nil--<
this.UI_STATUS_TYPE_ALL={
  CallMenu="INVALID",
  PauseMenu="INVALID",
  EquipHud="INVALID",
  EquipPanel="INVALID",
  CqcIcon="INVALID",
  ActionIcon="INVALID",
  AnnounceLog="SUSPEND_LOG",
  BaseName="INVALID",
  Damage="INVALID",
  Notice="INVALID",
  HeadMarker="INVALID",
  WorldMarker="INVALID",
  HudText="INVALID",
  GmpInfo="INVALID",
  AtTime="INVALID",
  InfoTypingText="INVALID"
}
this.GAME_STATUS_TYPE_ALL={S_DISABLE_PLAYER_PAD=true,S_DISABLE_NPC=true,S_DISABLE_TARGET=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true}
this.SAVE_FILE_LOAD_RESULT=this.Enum{"NOT_EXIST_FILE","OK","OK_LOAD_BACKUP","DIFFER_FROM_CURRENT_VERSION","ERROR_LOAD_FAILED"}
this.SAVE_FILE_LOAD_RESULT.INIT=-1
this.SAVE_SLOT={
  GLOBAL=0,
  CHECK_POINT=1,
  RETRY=2,
  MB_MANAGEMENT=3,
  QUEST=4,
  MISSION_START=5,
  CHECK_POINT_RESTARTABLE=6,
  CONFIG=7,
  SAVING=8,
  CONFIG_SAVE=9,
  PERSONAL=10,
  PERSONAL_SAVE=11,
  MGO=12,
  MGO_SAVE=13
}
this.PROGRAM_SAVE_FILE_VERSION_OFFSET=65535
this.GAME_SAVE_FILE_NAME="TPP_GAME_DATA"
this.GAME_SAVE_FILE_NAME_TMP="TPP_GAME_DATA_TMP"
this.MGO_MAIN_SAVE_FILE_NAME="MGO_MAIN_DATA"
this.CONFIG_SAVE_FILE_NAME="TPP_CONFIG_DATA"
this.MGO_SAVE_FILE_NAME="MGO_GAME_DATA"
this.PERSONAL_DATA_SAVE_FILE_NAME="PERSONAL_DATA"
this.CATEGORY_MISSION_RESTARTABLE=2
this.SAVE_FILE_INFO={
  [TppScriptVars.CATEGORY_GAME_GLOBAL]={version=107,slot=this.SAVE_SLOT.GLOBAL},--RETAILPATCH: 1006, version bump
  [TppScriptVars.CATEGORY_MISSION]={version=115,slot=this.SAVE_SLOT.CHECK_POINT},--RETAILPATCH: 1.0.11, version bump 114 to 115,
  [TppScriptVars.CATEGORY_RETRY]={version=105,slot=this.SAVE_SLOT.RETRY},
  [TppScriptVars.CATEGORY_MB_MANAGEMENT]={version=112,slot=this.SAVE_SLOT.MB_MANAGEMENT},--RETAILPATCH: 1090, version bump 111 to 112
  [TppScriptVars.CATEGORY_QUEST]={version=104,slot=this.SAVE_SLOT.QUEST},
  [TppScriptVars.CATEGORY_CONFIG]={version=103,slot=this.SAVE_SLOT.CONFIG},
  [this.CATEGORY_MISSION_RESTARTABLE]={version=100,slot=this.SAVE_SLOT.CHECK_POINT_RESTARTABLE,missionStartSlot=this.SAVE_SLOT.MISSION_START},
  [TppScriptVars.CATEGORY_PERSONAL]={version=100,slot=this.SAVE_SLOT.PERSONAL}
}
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  this.SAVE_FILE_INFO[TppScriptVars.CATEGORY_MGO]={version=102,slot=this.SAVE_SLOT.MGO}--NMC this overrides CATEGORY_MISSION_RESTARTABLE
end
this.PROGRAM_SAVE_FILE_VERSION=TppScriptVars.GetProgramVersionTable()
this.VARS_GROUP_GAME_DATA_ON_START_MISSION=bor(TppScriptVars.GROUP_BIT_GVARS,TppScriptVars.GROUP_BIT_VARS)
this.MISSION_LOAD_TYPE=this.Enum{"MISSION_FINALIZE","MISSION_ABORT","MISSION_RESTART","CONTINUE_FROM_CHECK_POINT"}
this.LOCATION_ID={
  INIT=1,AFGH=10,MAFR=20,CYPR=30,GNTN=40,OMBS=45,MTBS=50,MBQF=55,HLSP=60,FLYK=70,
  afgh=10,mafr=20,cypr=30,gntn=40,ombs=45,mtbs=50,mbqf=55,hlsp=60,flyk=70,
  SAND_AFGH=91,SAND_MAFR=92,SAND_MTBS=95,
  sand_afgh=91,sand_mafr=92,sand_mtbs=95
}
this.LOCATION_CHUNK_INDEX_TABLE={
  [this.LOCATION_ID.AFGH]=Chunk.INDEX_AFGH,
  [this.LOCATION_ID.MAFR]=Chunk.INDEX_MAFR,
  [this.LOCATION_ID.CYPR]=Chunk.INDEX_CYPR,
  [this.LOCATION_ID.MTBS]=Chunk.INDEX_MTBS,
  [this.LOCATION_ID.MBQF]=Chunk.INDEX_MTBS
}
this.WEATHER={SUNNY=0,CLOUDY=1,RAINY=2,SANDSTORM=3,FOGGY=4,POURING=5}
--NMC includes MISSING_NUMBER_MISSIONs
this.MISSION_LIST={
  "10010",--1
  "10020",--2
  "10030",--3
  "10036",--4
  "10043",--5
  "10033",--6
  "10040",--7
  "10041",--8
  "10044",--9
  "10052",--10
  "10054",--11
  "10050",--12
  "10070",--13
  "10080",--14
  "10086",--15
  "10082",--16
  "10090",--17
  "10195",--18
  "10091",--19
  "10100",--20
  "10110",--21
  "10121",--22
  "10115",--23
  "10120",--24
  "10085",--25
  "10200",--26
  "10211",--27
  "10081",--28
  "10130",--29
  "10140",--30
  "10150",--31
  "10151",--32
  "10045",--33
  "10156",--34
  "10093",--35
  "10171",--36
  "10240",--37
  "10260",--38
  "10280",--39
  "10230",--40-no number mission40
  "11043",--41
  "11041",--42-no number mission
  "11054",--43
  "11085",--44-no number mission
  "11082",--45
  "11090",--46
  "11036",--47-no number mission
  "11033",--48
  "11050",--49
  "11091",--50-no number mission
  "11195",--51-no number mission
  "11211",--52-no number mission
  "11140",--53
  "11200",--54-no number mission
  "11080",--55
  "11171",--56-no number mission
  "11121",--57
  "11115",--58-no number mission
  "11130",--59
  "11044",--60
  "11052",--61-no number mission
  "11151",--62
  nil
}
--tex ADDON all this mission stuff -^--v- managed by InfMission for addon locations and missions, see the addon locationInfo, missionInfo examples commented in the header of InfMission
this.MISSION_ENUM=this.Enum(this.MISSION_LIST)
if Mission.RegisterMissionCodeList then
  Mission.RegisterMissionCodeList{codeList=this.MISSION_LIST}
end
this.HARD_MISSION_LIST={"11043","11041","11054","11085","11082","11090","11036","11033","11050","11091","11195","11211","11140","11200","11080","11171","11121","11115","11130","11044","11052","11151"}
this.HARD_MISSION_ENUM=this.Enum(this.HARD_MISSION_LIST)
this.MISSING_NUMBER_MISSION_LIST={"11041","11085","11036","11091","11195","11211","11200","11171","11115","11052","10230"}
this.MISSING_NUMBER_MISSION_ENUM=this.Enum(this.MISSING_NUMBER_MISSION_LIST)
this.SYS_MISSION_ID={INIT=1,TITLE=5,AFGH_FREE=30010,MAFR_FREE=30020,MTBS_FREE=30050,MTBS_ZOO=30150,MTBS_WARD=30250,AFGH_HELI=40010,MAFR_HELI=40020,MTBS_HELI=40050,HELI_SPACE=40060,FOB=50050,SELECT=6e4}
this.NO_ORDER_BOX_MISSION_LIST={"10010","10020","10030","10050","11050","10070","10080","11080","10115","11115","10140","11140","10150","10151","11151","10240","10260","10280"}
this.NO_ORDER_BOX_MISSION_ENUM=this.Enum(this.NO_ORDER_BOX_MISSION_LIST)
this.NO_ORDER_FIX_HELICOPTER_ROUTE={[10240]="rt_drp_mbqf_N",[10260]="drp_s10260"}
this.NO_HELICOPTER_ROUTE_MISSION_LIST={"10010","10020","10030","10050","11050","10070","10080","11080","10140","11140","10150","10151","11151","10240","10280"}
this.NO_HELICOPTER_ROUTE_ENUM=this.Enum(this.NO_HELICOPTER_ROUTE_MISSION_LIST)
--tex NMC used in LoadingPositionFromHeliSpace,LoadingPositionToFree if no heli_missionStartRoute.
this.NO_HELICOPTER_MISSION_START_POSITION={
  [10010]={-39.127,106.175,-1719.5},
  [10050]={-1820.706,348.982,-146.444},
  [11050]={-1820.706,348.982,-146.444},
  [10070]={-647.4362,541.0834,-1637.894},
  [10080]={-458,-20,1316},
  [11080]={-458,-20,1316},
  [10140]={1118.691,-10.92584,656.2424},
  [11140]={1118.691,-10.92584,656.2424},
  [10150]={-1626,359.51,-416},
  [10151]={-750,532,-1676},
  [11151]={-750,532,-1676},
  [10240]={-162.75,1.092,-2097.899},
  [10280]={-39.127,106.175,-1719.5}
}
--tex shifted from loadPositionFuncs[TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE] > LoadingPositionFromFree
this.NO_BOX_MISSION_START_POSITION={
  [10020]={1449.3460693359,339.18698120117,1467.4300537109,-104},
  [10050]={-1820.7060546875,349.78659057617,-146.44400024414,139},
  [10070]={-792.00512695313,537.3740234375,-1381.4598388672,136},
  [10080]={-439.28802490234,-20.472593307495,1336.2784423828,-151},
  [10140]={499.91635131836,13.07358455658,1135.1315917969,79},
  [10150]={-1732.0286865234,543.94067382813,-2225.7587890625,162},
  [10260]={-1260.0454101563,298.75305175781,1325.6383056641,51}
}
this.NO_BOX_MISSION_START_POSITION[11050]=this.NO_BOX_MISSION_START_POSITION[10050]
this.NO_BOX_MISSION_START_POSITION[11080]=this.NO_BOX_MISSION_START_POSITION[10080]
this.NO_BOX_MISSION_START_POSITION[11140]=this.NO_BOX_MISSION_START_POSITION[10140]
this.NO_BOX_MISSION_START_POSITION[10151]=this.NO_BOX_MISSION_START_POSITION[10150]
this.NO_BOX_MISSION_START_POSITION[11151]=this.NO_BOX_MISSION_START_POSITION[10150]
--<
this.EMERGENCY_MISSION_LIST={10115,50050}
this.EMERGENCY_MISSION_ENUM=this.Enum(this.EMERGENCY_MISSION_LIST)
--NMC probably would have been better to have it as [missioncode]=location
--NOTE: mbqf missions are actually mtbs (locationCode 50), it's only the interior of 10240 shining in lights thats 55 mbqf.
--Used in TppPackList.GetLocationNameFormMissionCode
--and added to by IH in InfMission.AddInMissions
--Also see and TppLocation.GetLocationName
this.LOCATION_HAVE_MISSION_LIST={
  INIT={5},
  AFGH={10020,10033,10034,10036,10040,10041,10043,10044,10045,10050,10052,10054,10060,10070,10150,10151,10153,10156,10164,10199,10260,30010,40010,65020,11036,11043,11041,11033,11050,11054,11044,11052,11151},
  MAFR={10080,10081,10082,10085,10086,10090,10091,10093,10100,10110,10120,10121,10130,10140,10154,10160,10162,10171,10200,10195,10211,30020,40020,65060,11085,11082,11090,11091,11195,11211,11140,11200,11080,11171,11121,11130},
  CYPR={10010,10280},
  MTBS={10030,10115,11115,10240,30050,30150,30250,40050,50050,65030},
  OMBS={},
  HLSP={40060},
  FLYK={10230}
}
this.OFFLINE_MOHTER_BASE_LAYOUT_CODE=0
this.STORY_MISSION_LAYOUT_CODE={
  [10030]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
  [10115]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
  [11115]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
  [10240]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
  [30050]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
  [30051]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
  [30150]=500,
  [30250]=this.OFFLINE_MOHTER_BASE_LAYOUT_CODE
}
this.INVALID_LAYOUT_CODE=65535
this.STORY_MISSION_CLUSTER_ID={
  [10030]=0,
  [10115]=2,
  [11115]=2,
  [10240]=7,
  [30050]=0,
  [30150]=0,
  [30250]=7
}
this.INVALID_CLUSTER_ID=255
this.STORY_SEQUENCE_LIST={
  "STORY_START",
  "CLEARD_ESCAPE_THE_HOSPITAL",
  "CLEARD_RECUE_MILLER",
  "CLEARD_TO_MATHER_BASE",
  "CLEARD_FLAG_MISSIONS_AFTER_TO_MATHER_BASE",
  "CLEARD_FIND_THE_SECRET_WEAPON",
  "CLEARD_FLAG_MISSIONS_AFTER_FIND_THE_SECRET_WEAPON",
  "CLEARD_RESCUE_HUEY",
  "CLEARD_DESTROY_THE_FLOW_STATION",
  "CLEARD_LINGUA_FRANKA",
  "CLEARD_FLAG_MISSIONS_AFTER_DESTROY_THE_FLOW_STATION",
  "CLEARD_TAKE_OUT_THE_CONVOY",
  "CLEARD_RESCUE_INTEL_AGENTS",
  "CLEARD_ELIMINATE_THE_POWS",
  "CLEARD_DEATH_FACTORY",
  "CLEARD_CAPTURE_THE_WEAPON_DEALER",
  "CLEARD_WHITE_MAMBA",
  "CLEARD_FLAG_MISSIONS_AFTER_WHITE_MAMBA",
  "CLEARD_ELIMINATE_THE_COMMANDER",
  "CLEARD_RESCUE_THE_BETRAYER",
  "CLEARD_CODE_TALKER",
  "CLEARD_METALLIC_ARCHAEA",
  "CLEARD_SKULLFACE",
  "CLEARD_OKB_ZERO",
  "CLEARD_RETRIEVE_VOLGIN",
  "CLEARD_RETRIEVE_CHILD_DESERTER",
  "CLEARD_FLAG_MISSIONS_BEFORE_ENDRESS_PROXY_WAR",
  "CLEARD_ENDRESS_PROXY_WAR",
  "CLEARD_FLAG_MISSIONS_BEFORE_MURDER_INFECTORS",
  "CLEARD_MURDER_INFECTORS",
  "CLEARD_AFTER_MURDER_INFECTORS_ONE_MISSION",
  "CLEARD_AFTER_MURDER_INFECTORS_TWO_MISSIONS",
  "CLEARD_THE_TRUTH",
  "STORY_FINISH",
  nil
}
this.STORY_SEQUENCE=this.Enum(this.STORY_SEQUENCE_LIST)
this.MISSION_COMMON_PACK={
  AFGH_SCRIPT="/Assets/tpp/pack/location/afgh/pack_common/afgh_script.fpk",
  MAFR_SCRIPT="/Assets/tpp/pack/location/mafr/pack_common/mafr_script.fpk",
  CYPR_SCRIPT="/Assets/tpp/pack/location/cypr/pack_common/cypr_script.fpk",
  MTBS_SCRIPT="/Assets/tpp/pack/location/mtbs/pack_common/mtbs_script.fpk",
  AFGH_MISSION_AREA="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
  MAFR_MISSION_AREA="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
  MTBS_MISSION_AREA="/Assets/tpp/pack/mission2/common/mis_com_mtbs.fpk",
  AFGH_HOSTAGE="/Assets/tpp/pack/mission2/common/mis_com_afgh_hostage.fpk",
  MAFR_HOSTAGE="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage.fpk",
  MAFR_HOSTAGE_WOMAN="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage_woman.fpk",
  HELICOPTER="/Assets/tpp/pack/mission2/common/mis_com_helicopter.fpk",
  ENEMY_HELI="/Assets/tpp/pack/mission2/common/mis_com_enemy_heli.fpk",
  ORDER_BOX="/Assets/tpp/pack/mission2/common/mis_com_order_box.fpk",
  CODETALKER="/Assets/tpp/pack/mission2/common/mis_com_codetalker.fpk",
  HUEY="/Assets/tpp/pack/mission2/common/mis_com_huey.fpk",
  LIQUID="/Assets/tpp/pack/mission2/common/mis_com_liquid.fpk",
  MANTIS="/Assets/tpp/pack/mission2/common/mis_com_mantis.fpk",
  MILLER="/Assets/tpp/pack/mission2/common/mis_com_miller.fpk",
  OCELOT="/Assets/tpp/pack/mission2/common/mis_com_ocelot.fpk",
  QUIET="/Assets/tpp/pack/mission2/common/mis_com_quiet.fpk",
  SAHELAN="/Assets/tpp/pack/mission2/common/mis_com_sahelan.fpk",
  SKULLFACE="/Assets/tpp/pack/mission2/common/mis_com_skullface.fpk",
  PF_SOLIDER="/Assets/tpp/pack/mission2/common/mis_com_pf_solider.fpk",
  SOVIET_SOLIDER="/Assets/tpp/pack/mission2/common/mis_com_soviet_solider.fpk",
  DD_SOLDIER_WAIT="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",
  VOLGIN="/Assets/tpp/pack/mission2/common/mis_com_volgin.fpk",
  WALKERGEAR="/Assets/tpp/pack/mission2/common/mis_com_walkergear.fpk",
  CHILD_SOLDIER="/Assets/tpp/pack/mission2/common/mis_com_child_soldier.fpk",
  XOF_SOLDIER="/Assets/tpp/pack/mission2/common/mis_com_xof_soldier.fpk",
  DD_SOLDIER_ATTACKER="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",
  DD_SOLDIER_SNEAKING="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",
  DD_SOLDIER_BTRDRS="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",
  DD_SOLDIER_ARMOR="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_armor.fpk",
  FOB_HOSTAGE="/Assets/tpp/pack/mission2/common/mis_com_fob_hostage.fpk",
  DD_SOLDIER_SWIM_SUIT="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit.fpk",--RETAILPATCH: 1.10
  DD_SOLDIER_SWIM_SUIT2="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit2.fpk",--RETAILPATCH 1.0.11
  DD_SOLDIER_SWIM_SUIT3="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit3.fpk",--RETAILPATCH 1.0.11
  AFGH_DECOY="/Assets/tpp/pack/collectible/decoy/decoy_svs.fpk",
  MAFR_DECOY="/Assets/tpp/pack/collectible/decoy/decoy_pf.fpk",
  MTBS_DECOY="/Assets/tpp/pack/collectible/decoy/decoy_fob.fpk",
  BEAR="/Assets/tpp/pack/mission2/common/mis_com_bear.fpk",
  RAVEN="/Assets/tpp/pack/mission2/common/mis_com_raven.fpk",
  RAT="/Assets/tpp/pack/mission2/common/mis_com_rat.fpk",
  LYCAON="/Assets/tpp/pack/mission2/common/mis_com_lycaon.fpk",
  JACKAL="/Assets/tpp/pack/mission2/common/mis_com_jackal.fpk",
  EAST_LV="/Assets/tpp/pack/mission2/common/veh_mc_east_lv.fpk",
  EAST_TANK="/Assets/tpp/pack/mission2/common/veh_mc_east_tnk.fpk",
  EAST_TRUCK="/Assets/tpp/pack/mission2/common/veh_mc_east_trc.fpk",
  EAST_TRUCK_AMMUNITION="/Assets/tpp/pack/mission2/common/veh_mc_east_trc_crg_ammunition.fpk",
  EAST_TRUCK_DRUM="/Assets/tpp/pack/mission2/common/veh_mc_east_trc_crg_drum.fpk",
  EAST_TRUCK_GENERATOR="/Assets/tpp/pack/mission2/common/veh_mc_east_trc_crg_generator.fpk",
  EAST_TRUCK_MATERIAL="/Assets/tpp/pack/mission2/common/veh_mc_east_trc_crg_material.fpk",
  EAST_WAV="/Assets/tpp/pack/mission2/common/veh_mc_east_wav.fpk",
  EAST_WAV_ROCKET="/Assets/tpp/pack/mission2/common/veh_mc_east_wav_rocket.fpk",
  WEST_LV="/Assets/tpp/pack/mission2/common/veh_mc_west_lv.fpk",
  WEST_TANK="/Assets/tpp/pack/mission2/common/veh_mc_west_tnk.fpk",
  WEST_TRUCK="/Assets/tpp/pack/mission2/common/veh_mc_west_trc.fpk",
  WEST_TRUCK_CISTERN="/Assets/tpp/pack/mission2/common/veh_mc_west_trc_crg_cistern.fpk",
  WEST_TRUCK_CONTAINER="/Assets/tpp/pack/mission2/common/veh_mc_west_trc_crg_container.fpk",
  WEST_TRUCK_ITEMBOX="/Assets/tpp/pack/mission2/common/veh_mc_west_trc_crg_itembox.fpk",
  WEST_TRUCK_HOOD="/Assets/tpp/pack/mission2/common/veh_mc_west_trc_hood.fpk",
  WEST_WAV="/Assets/tpp/pack/mission2/common/veh_mc_west_wav.fpk",
  WEST_WAV_CANNON="/Assets/tpp/pack/mission2/common/veh_mc_west_wav_trt_cannon.fpk",
  WEST_WAV_MACHINE_GUN="/Assets/tpp/pack/mission2/common/veh_mc_west_wav_trt_machinegun.fpk",
  AMBULANCE="/Assets/tpp/pack/mission2/common/veh_mc_ambulance.fpk",
  AVATAR_EDIT="/Assets/tpp/pack/mission2/common/mis_com_avatar_edit.fpk",
  AVATAR_ASSET_LIST={
    "/Assets/tpp/pack/player/avatar/deform/avm_dfrm_men_mtar.fpk",
    "/Assets/tpp/pack/player/avatar/face/plfova_avm0_type0_v00.fpk",
    "/Assets/tpp/pack/player/avatar/face/plfova_avm0_type1_v00.fpk",
    "/Assets/tpp/pack/player/avatar/face/plfova_avm0_type2_v00.fpk",
    "/Assets/tpp/pack/player/avatar/face/plfova_avm0_type3_v00.fpk",
    "/Assets/tpp/pack/player/avatar/face/plfova_avm0_type4_v00.fpk",
    "/Assets/tpp/pack/player/avatar/face/plfova_avm0_type5_v00.fpk",
    "/Assets/tpp/pack/player/avatar/face/plfova_avm0_type6_v00.fpk",
    "/Assets/tpp/pack/player/avatar/face/plfova_avm0_type7_v00.fpk",
    "/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type0_v00.fpk",
    "/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type1_v00.fpk",
    "/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type2_v00.fpk",
    "/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type3_v00.fpk",
    "/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type4_v00.fpk",
    "/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type5_v00.fpk",
    "/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type6_v00.fpk",
    "/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type7_v00.fpk",
    "/Assets/tpp/pack/player/avatar/hair/plfova_avm_hair_a0_v00.fpk",
    "/Assets/tpp/pack/player/avatar/hair/plfova_avm_hair_b0_v00.fpk",
    "/Assets/tpp/pack/player/avatar/hair/plfova_avm_hair_c0_v00.fpk",
    "/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk",
    "/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c00.fpk",
    "/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c01.fpk",
    "/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c02.fpk",
    "/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c03.fpk",
    "/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c04.fpk",
    "/Assets/tpp/pack/ui/ui_avatar_edit_men.fpk"
  }
}--MISSION_COMMON_PACK
this.SOLIDER2_COMMON_PACK={
  default="/Assets/tpp/pack/soldier/common/Soldier2Common.fpk",
  s10150_special="/Assets/tpp/pack/mission2/story/s10150/s10150_special_npc.fpk",
  s10151_special="/Assets/tpp/pack/mission2/story/s10151/s10151_special_npc.fpk",
  s10151_ending="/Assets/tpp/pack/mission2/story/s10151/s10151_ending_npc.fpk"
}
for name,packPath in pairs(this.SOLIDER2_COMMON_PACK)do
  --RETAILBUG since it's working-in-place it eventually hits the strcode keys it added earlier, no actual probem, but added fix to stop my intercepted StrCode32 function from complaining
  if type(name)~="number" then--tex dont work on the strcoded keys that have been added
    this.SOLIDER2_COMMON_PACK[StrCode32(name)]=packPath
  end
end
this.DEFAULT_SOLIDER2_COMMON_PACKAGE=StrCode32"default"
this.SOLIDER2_COMMON_PACK_PREREQUISITES={s10150_special={"mission_block"},s10151_special={"mission_block"},s10151_ending={"mission_block"}}
this.AFR_ARMOR={TYPE_CFA=1,TYPE_ZRS=2,TYPE_RC=3}
this.QUEST_DEFINE={--NMC if you need a list of valid player quests use TppQuest questInfoTable instead of this
  "waterway_q99010",
  "waterway_q99012",
  "sovietBase_q99020",
  "sovietBase_q99030",
  "tent_q99040",
  "cliffTown_q99080",
  "field_q30010",
  "outland_q40010",
  "sovietBase_q99070",
  "outland_q99071",
  "tent_q99072",
  "tent_q20910",
  "fort_q20911",
  "sovietBase_q20912",
  "outland_q20913",
  "lab_q20914",
  "waterway_q39010",
  "pfCamp_q39012",
  "lab_q39011",
  "ruins_q19010",
  "outland_q19011",
  "hill_q19012",
  "commFacility_q19013",
  "sovietBase_q60110",
  "sovietBase_q60111",
  "citadel_q60112",
  "outland_q60113",
  "pfCamp_q60114",
  "tent_q10010",
  "field_q10020",
  "ruins_q10030",
  "waterway_q10040",
  "cliffTown_q10050",
  "commFacility_q10060",
  "sovietBase_q10070",
  "fort_q10080",
  "citadel_q10090",
  "outland_q10100",
  "pfCamp_q10200",
  "savannah_q10300",
  "hill_q10400",
  "banana_q10500",
  "diamond_q10600",
  "lab_q10700",
  "tent_q11010",
  "tent_q11020",
  "waterway_q11030",
  "cliffTown_q11040",
  "cliffTown_q11050",
  "fort_q11060",
  "fort_q11070",
  "commFacility_q11080",
  "outland_q11090",
  "outland_q11100",
  "pfCamp_q11200",
  "savannah_q11300",
  "savannah_q11400",
  "hill_q11500",
  "banana_q11600",
  "banana_q11700",
  "tent_q71010",
  "field_q71020",
  "tent_q71030",
  "waterway_q71040",
  "cliffTown_q71050",
  "cliffTown_q71060",
  "sovietBase_q71070",
  "fort_q71080",
  "field_q71090",
  "outland_q71200",
  "savannah_q71300",
  "banana_q71400",
  "diamond_q71500",
  "lab_q71600",
  "lab_q71700",
  "commFacility_q80060",
  "field_q80020",
  "outland_q80100",
  "pfCamp_q80200",
  "diamond_q80600",
  "hill_q80400",
  "tent_q80010",
  "lab_q80700",
  "fort_q80080",
  "waterway_q80040",
  "ruins_q60010",
  "tent_q60011",
  "cliffTown_q60012",
  "fort_q60013",
  "sovietBase_q60014",
  "pfCamp_q60020",
  "hill_q60021",
  "lab_q60022",
  "banana_q60023",
  "outland_q60024",
  "quest_q20015",
  "quest_q20025",
  "quest_q20035",
  "quest_q20045",
  "quest_q20055",
  "quest_q20065",
  "quest_q20075",
  "quest_q20085",
  "quest_q20095",
  "quest_q20105",
  "quest_q20205",
  "quest_q20305",
  "quest_q20405",
  "quest_q20505",
  "quest_q20605",
  "quest_q20705",
  "quest_q20805",
  "quest_q20905",
  "quest_q21005",
  "quest_q22005",
  "quest_q52010",
  "quest_q52020",
  "quest_q52030",
  "quest_q52040",
  "quest_q52050",
  "quest_q52060",
  "quest_q52070",
  "quest_q52015",
  "quest_q52025",
  "quest_q52035",
  "quest_q52045",
  "quest_q52055",
  "quest_q52065",
  "quest_q52075",
  "Mtbs_SmokingSoldierCommand",
  "Mtbs_SmokingSoldierCombat",
  "Mtbs_child_dog",
  "mtbs_wait_quiet",
  "mtbs_q99050",
  "mtbs_q99011",
  "mtbs_q99060",
  "mtbs_q101210",
  "mtbs_q101220",
  "Mtbs_ddog_walking",
  "ruins_q60115",
  "quest_q52080",
  "quest_q52090",
  "quest_q52100",
  "quest_q52110",
  "quest_q52120",
  "quest_q52130",
  "quest_q52140",
  "quest_q52085",
  "quest_q52095",
  "quest_q52105",
  "quest_q52115",
  "quest_q52125",
  "quest_q52135",
  "quest_q52145",
  "quest_q23005",
  "quest_q24005",
  "quest_q25005",
  "quest_q26005",
  "quest_q27005",
  "mtbs_q42010",
  "mtbs_q42020",
  "mtbs_q42030",
  "mtbs_q42040",
  "mtbs_q42050",
  "mtbs_q42060",
  "mtbs_q42070",
  "mtbs_return_quiet"
}--QUEST_DEFINE
this.NUM_VANILLA_QUEST_DEFINES=167--tex added
this.QUEST_RANDOM_FACE_DEFINE={
  "quest_q20015",
  "quest_q20025",
  "quest_q20035",
  "quest_q20045",
  "quest_q20055",
  "quest_q20065",
  "quest_q20075",
  "quest_q20085",
  "quest_q20095",
  "quest_q20105",
  "quest_q20205",
  "quest_q20305",
  "quest_q20405",
  "quest_q20505",
  "quest_q20605",
  "quest_q20705",
  "quest_q20805",
  "quest_q20905",
  "quest_q21005",
  "quest_q22005",
  "quest_q23005",
  "quest_q24005",
  "quest_q25005",
  "quest_q26005",
  "quest_q27005"
}
this.QUEST_HELI_DEFINE={
  "outland_q20913",
  "quest_q52015",
  "quest_q52045",
  "quest_q52055",
  "quest_q52050",
  "quest_q52060",
  "quest_q52065",
  "quest_q52070",
  "quest_q52075",
  "quest_q52085",
  "quest_q52095",
  "quest_q52105",
  "quest_q52115",
  "quest_q52125",
  "quest_q52135",
  "quest_q52140",
  "quest_q52145",
  "quest_q52100",
  "quest_q52130",
  "quest_q52110",
  "quest_q52120",
  "quest_q20405",
  "quest_q20705",
  "quest_q27005"
}
this.REMOVAL_TROPHY_QUEST=this.Enum{
  "ruins_q60010",
  "tent_q60011",
  "cliffTown_q60012",
  "fort_q60013",
  "sovietBase_q60014",
  "pfCamp_q60020",
  "hill_q60021",
  "lab_q60022",
  "banana_q60023",
  "outland_q60024"
}
this.QUEST_TYPE={STORY=1,RECOVERED=2,ELIMINATE=3,ANIMAL_RECOVERED=4,DEVELOP_RECOVERED=5,GIMMICK_RECOVERED=6,MSF_RECOVERED=7,SHOOTING_PRACTIVE=8,}--GOTCHA: typo: PRACTIVE, also TppQuest category enum is TARGET_PRACTICE rather than SHOOTING
this.QUEST_CLEAR_TYPE={NONE=1,CLEAR=2,FAILURE=3,UPDATE=4,SHOOTING_CLEAR=5,SHOOTING_RETRY=6}
this.QUEST_RACE_TYPE={CAUCASIAN=0,BROWN=1,BLACK=2,ASIA=3}
this.QUEST_GENDER_TYPE={MAN=0,WOMAN=1}
if#this.QUEST_DEFINE>this.QUEST_MAX then
end
this.QUEST_INDEX=this.Enum(this.QUEST_DEFINE)
if#this.QUEST_RANDOM_FACE_DEFINE>this.QUEST_FACE_MAX then
end
this.QUEST_RANDOM_FACE_INDEX=this.Enum(this.QUEST_RANDOM_FACE_DEFINE)
this.QUEST_RANK_LIST={"S","A","B","C","D","E","F","G","H","I"}
this.QUEST_RANK=Tpp.Enum(this.QUEST_RANK_LIST)
this.QUEST_BONUS_GMP={
  [this.QUEST_RANK.S]=300000,
  [this.QUEST_RANK.A]=200000,
  [this.QUEST_RANK.B]=180000,
  [this.QUEST_RANK.C]=140000,
  [this.QUEST_RANK.D]=120000,
  [this.QUEST_RANK.E]=100000,
  [this.QUEST_RANK.F]=90000,
  [this.QUEST_RANK.G]=80000,
  [this.QUEST_RANK.H]=60000,
  [this.QUEST_RANK.I]=30000
}
this.QUEST_RANK_TABLE={
  [this.QUEST_INDEX.waterway_q99012]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.sovietBase_q99020]=this.QUEST_RANK.H,
  [this.QUEST_INDEX.sovietBase_q99030]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.tent_q99040]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.cliffTown_q99080]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.field_q30010]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.outland_q40010]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.sovietBase_q99070]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.outland_q99071]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.tent_q99072]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.tent_q20910]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.fort_q20911]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.sovietBase_q20912]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.outland_q20913]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.lab_q20914]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.waterway_q39010]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.pfCamp_q39012]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.lab_q39011]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.ruins_q19010]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.outland_q19011]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.hill_q19012]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.commFacility_q19013]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.sovietBase_q60110]=this.QUEST_RANK.H,
  [this.QUEST_INDEX.sovietBase_q60111]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.citadel_q60112]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.outland_q60113]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.pfCamp_q60114]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.ruins_q60115]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.tent_q10010]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.field_q10020]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.ruins_q10030]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.waterway_q10040]=this.QUEST_RANK.H,
  [this.QUEST_INDEX.cliffTown_q10050]=this.QUEST_RANK.H,
  [this.QUEST_INDEX.commFacility_q10060]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.sovietBase_q10070]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.fort_q10080]=this.QUEST_RANK.H,
  [this.QUEST_INDEX.citadel_q10090]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.outland_q10100]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.pfCamp_q10200]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.savannah_q10300]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.hill_q10400]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.banana_q10500]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.diamond_q10600]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.lab_q10700]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.tent_q11010]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.tent_q11020]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.waterway_q11030]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.cliffTown_q11040]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.cliffTown_q11050]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.fort_q11060]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.fort_q11070]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.commFacility_q11080]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.outland_q11090]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.outland_q11100]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.pfCamp_q11200]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.savannah_q11300]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.savannah_q11400]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.hill_q11500]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.banana_q11600]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.banana_q11700]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.tent_q71010]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.field_q71020]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.tent_q71030]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.waterway_q71040]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.cliffTown_q71050]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.cliffTown_q71060]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.sovietBase_q71070]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.fort_q71080]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.field_q71090]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.outland_q71200]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.savannah_q71300]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.banana_q71400]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.diamond_q71500]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.lab_q71600]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.lab_q71700]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.commFacility_q80060]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.field_q80020]=this.QUEST_RANK.H,
  [this.QUEST_INDEX.outland_q80100]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.pfCamp_q80200]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.diamond_q80600]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.hill_q80400]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.tent_q80010]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.lab_q80700]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.fort_q80080]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.waterway_q80040]=this.QUEST_RANK.S,
  [this.QUEST_INDEX.ruins_q60010]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.tent_q60011]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.cliffTown_q60012]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.fort_q60013]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.sovietBase_q60014]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.pfCamp_q60020]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.hill_q60021]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.lab_q60022]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.banana_q60023]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.outland_q60024]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.quest_q20015]=this.QUEST_RANK.H,
  [this.QUEST_INDEX.quest_q20025]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.quest_q20035]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.quest_q20045]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.quest_q20055]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.quest_q20065]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.quest_q20075]=this.QUEST_RANK.H,
  [this.QUEST_INDEX.quest_q20085]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.quest_q20095]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.quest_q20105]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q20205]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q20305]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.quest_q20405]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.quest_q20505]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q20605]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q20705]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.quest_q20805]=this.QUEST_RANK.H,
  [this.QUEST_INDEX.quest_q20905]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.quest_q21005]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.quest_q22005]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.quest_q23005]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.quest_q24005]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q25005]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q26005]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q27005]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q52010]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.quest_q52020]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.quest_q52030]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.quest_q52040]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.quest_q52050]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.quest_q52060]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.quest_q52070]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q52080]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.quest_q52090]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.quest_q52100]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.quest_q52110]=this.QUEST_RANK.S,
  [this.QUEST_INDEX.quest_q52120]=this.QUEST_RANK.S,
  [this.QUEST_INDEX.quest_q52130]=this.QUEST_RANK.S,
  [this.QUEST_INDEX.quest_q52140]=this.QUEST_RANK.S,
  [this.QUEST_INDEX.quest_q52015]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.quest_q52025]=this.QUEST_RANK.E,
  [this.QUEST_INDEX.quest_q52035]=this.QUEST_RANK.G,
  [this.QUEST_INDEX.quest_q52045]=this.QUEST_RANK.F,
  [this.QUEST_INDEX.quest_q52055]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.quest_q52065]=this.QUEST_RANK.B,
  [this.QUEST_INDEX.quest_q52075]=this.QUEST_RANK.C,
  [this.QUEST_INDEX.quest_q52085]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.quest_q52095]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.quest_q52105]=this.QUEST_RANK.A,
  [this.QUEST_INDEX.quest_q52115]=this.QUEST_RANK.S,
  [this.QUEST_INDEX.quest_q52125]=this.QUEST_RANK.S,
  [this.QUEST_INDEX.quest_q52135]=this.QUEST_RANK.S,
  [this.QUEST_INDEX.quest_q52145]=this.QUEST_RANK.S,
  [this.QUEST_INDEX.mtbs_q99011]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.mtbs_q99050]=this.QUEST_RANK.D,
  [this.QUEST_INDEX.mtbs_q42010]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.mtbs_q42020]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.mtbs_q42030]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.mtbs_q42040]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.mtbs_q42050]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.mtbs_q42060]=this.QUEST_RANK.I,
  [this.QUEST_INDEX.mtbs_q42070]=this.QUEST_RANK.I
}
this.QUEST_BODY_ID_LIST={
  AFGH_ARMOR=49,--sva0_v00_a
  MAFR_ARMOR=109,--pfa0_v00_a
  Q20910=207,--chd2_v02
  Q20911=208,--chd2_v03
  Q20912=209,--chd2_v04
  Q20913=205,--chd2_v00
  Q20914=206,--chd2_v01
  Q19010=259,--svs0_unq_v020
  Q19011=255,--pfs0_unq_v150
  Q19012=111,--prs5_main0_v00
  Q19013=110,--prs2_main0_v00
  Q99070=110,--prs2_main0_v00
  Q99071=264,--pfs0_unq_v140
  Q99072=110,--prs2_main0_v00
  MSF_01=280,--pfs0_dds0_v00--tex NMC I've listed these as the bugged TppEnemyBodyId bodyIdName (see the RETAILBUG in there), until I can lookup the correct via bodydef > fovaindex, could just assume pfs svs are swapped, theres other issues with their fovainfo anyway
  MSF_02=281,--pfs0_dds0_v01
  MSF_03=292,--svs0_dds0_v02
  MSF_04=293,--svs0_dds0_v03
  MSF_05=294,--svs0_dds0_v04
  MSF_06=295,--svs0_dds0_v05
  MSF_07=286,--pfs0_dds0_v06
  MSF_08=297,--svs0_dds0_v07
  MSF_09=288,--pfs0_dds0_v08
  MSF_10=289,--pfs0_dds0_v09
  Q99080_01=373,--prs7_main0_v00
  Q99080_02=374,--prs7_main0_v01
  MAFR_ARMOR_ZRS=TppEnemyBodyId.pfa0_v00_a,
  MAFR_ARMOR_CFA=TppEnemyBodyId.pfa0_v00_b,
  MAFR_ARMOR_RC=TppEnemyBodyId.pfa0_v00_c,
  AFGH_HOSTAGE_MALE=TppEnemyBodyId.prs2_main0_v00,
  MAFR_HOSTAGE_MALE=TppEnemyBodyId.prs5_main0_v00,
  AFGH_HOSTAGE_FEMALE=TppEnemyBodyId.prs3_main0_v00,
  MAFR_HOSTAGE_FEMALE=TppEnemyBodyId.prs6_main0_v00
}
this.QUEST_FACE_ID_LIST={
  Q19010=601,Q19011=609,Q19012=648,Q19013=647,Q99070=640,Q99071=641,Q99072=646,
  TAN=621,
  DEFAULT_MAN=0,
  DEFAULT_WOMAN=500,
  AFGH_BALACLAVA=TppEnemyFaceId.svs_balaclava,
  MAFR_BALACLAVA=TppEnemyFaceId.pfs_balaclava
}
this.MISSION_CLEAR_RANK_LIST={"S","A","B","C","D","E"}
this.MISSION_CLEAR_RANK=Tpp.Enum(this.MISSION_CLEAR_RANK_LIST)
this.MISSION_CLEAR_RANK.NOT_DEFINED=0
this.INITIAL_PLAYER_STATE={MIN=0,ON_FOOT=1,RIDEON_HELICOPTER=2,MAX=3}
this.MB_FREEPLAY_DEMO_PRIORITY_LIST={
  "GoToMotherBaseAfterQuietBattle",
  "ArrivedMotherBaseAfterQuietBattle",
  "ArrivedMotherBaseFromDeathFactory",
  "ArrivedMotherBaseLiquid",
  "QuietReceivesPersecution",
  "TheGreatEscapeLiquid",
  "ParasiticWormCarrierKill",
  "AnableDevBattleGear",
  "DevelopedBattleGear1",
  "QuietHasFriendshipWithChild",
  "QuietOnHeliInRain",
  "InterrogateQuiet",
  "DecisionHuey",
  "EntrustDdog",
  "DdogComeToGet",
  "DdogGoWithMe",
  "HappyBirthDayWithQuiet",
  "HappyBirthDay",
  "AttackedFromOtherPlayer_KnowWhereFrom",
  "AttackedFromOtherPlayer_UnknowWhereFrom",
  "QuietWishGoMission",
  "NuclearEliminationCeremony",
  "ForKeepNuclearElimination",
  "SacrificeOfNuclearElimination",
  "MoraleOfMBIsLow",
  "EliLookSnake",
  "LiquidAndChildSoldier",
  "OcelotIsPupilOfSnake",
  "CodeTalkerSunBath",
  "LongTimeNoSee_DdogSuperHighLikability",
  "LongTimeNoSee_DdogHighLikability",
  "LongTimeNoSee_DdogLowLikability",
  "LongTimeNoSee_DdogPup",
  "LongTimeNoSee_DDSoldier",
  "SnakeHasBadSmell_000",
  "SnakeHasBadSmell_001",
  "SnakeHasBadSmell_WithoutQuiet",
  "PazPhantomPain1",
  "PazPhantomPain2",
  "PazPhantomPain4",
  "PazPhantomPain4_jp",
  "DetailsNuclearDevelop",
  "EndingSacrificeOfNuclear",
  "DevelopedBattleGear2",
  "DevelopedBattleGear4",
  "DevelopedBattleGear5",
  "ArrivedMotherBaseChildren"
}
this.MB_FREEPLAY_DEMO_ENUM=this.Enum(this.MB_FREEPLAY_DEMO_PRIORITY_LIST)
this.FORCE_MB_RETURN_RADIO_LIST={
  "OpenDecisionHuey",
  "EliImprisonment",
  "PermitParasiticWormCarrierKill",
  "InterrogateQuietRadio",
  "QuietHasFriendshipWithChildRadio",
  "AnableDevBattleGearRadio",
  "ParasiticWormCarrierQuarantine",
  "CompliteDevelopBattleGearRadio",
  "DevelopedBattleGear_1Radio",
  "EliLookSnakeRadio",
  "EntrustDdogRadio",
  "DdogComeToGetRadio",
  "DdogGoWithMeRadio",
  "HappyBirthDayRadio",
  "AttackedFromOtherPlayerRadio",
  "NuclearEliminationCeremonyRadio",
  "MoraleOfMBIsLowRadio",
  "GeneralPurposeRadio",
  "QuietReceivesPersecutionRadio"
}
this.FORCE_MB_RETURN_RADIO_ENUM=this.Enum(this.FORCE_MB_RETURN_RADIO_LIST)
this.S10100_BOY_LIST={"Collect_Injury","Collect_YellowHood","Collect_Aflo","Collect_ShortAflo","Collect_BlackCoat"}
this.S10100_BOY_ENUM=this.Enum(this.S10100_BOY_LIST)
this.MB_FREEPLAY_DEMO_REQUESTFLAG_LIST={"PlayAfterQuietBattle","PlayAfterDethFactory","PlayAfterWhiteMamba"}
this.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE=this.Enum(this.MB_FREEPLAY_DEMO_REQUESTFLAG_LIST)
this.MB_FREEPLAY_LARGEDEMO={"GoToMotherBaseAfterQuietBattle","NuclearEliminationCeremony","DecisionHuey","InterrogateQuiet","TheGreatEscapeLiquid"}
this.MB_FREEPLAY_RIDEONHELI_DEMO={"DdogGoWithMe","QuietWishGoMission"}
this.MB_FREEPLAY_RIDEONHELI_DEMO_DEFINE=this.Enum(this.MB_FREEPLAY_RIDEONHELI_DEMO)
this.GAME_OVER_TYPE={
  PLAYER_DEAD=1,
  PLAYER_FALL_DEAD=2,
  HELICOPTER_DESTROYED=3,
  TARGET_DEAD=4,
  OUTSIDE_OF_MISSION_AREA=5,
  FOB_TIME_OVER=6,
  TARGET_ESCAPE=7,
  TARGET_ESCAPE_BY_HELI=8,
  PLAYER_KILL_CHILD_SOLDIER=9,
  FOB_FULTONED=10,
  ON_DISCOVERY=11,
  FOB_ABORT=12,
  FOB_ESCAPE=13,--RETAILPATCH: 1060 added
  ABORT=254,
  GAME_OVER_DEMO_MASK=255,
  MAX=256,
  S10020_TARGET_TIMEOVERDEAD=30,
  S10040_ARRIVAL_HONEY_BEE=31,
  S10054_TIME_UP=32,
  S10090_TARGET_ESCAPE=33,
  S10090_TARGET_DEAD=34,
  S10090_TARGET_FULTON_FAILED=35,
  S10010_ISHMAEL_DEAD=36,
  S10240_STAFF_DEAD=37
}
this.GAME_OVER_RADIO={
  PLAYER_DEAD=1,
  OUT_OF_MISSION_AREA=2,
  OUT_OF_MISSION_AREA_HELI=3,
  HELICOPTER_DESTROYED=4,
  PLAYER_DESTROY_HELI=5,
  RIDING_HELI_DESTROYED=6,
  TARGET_DEAD=7,
  PLAYER_KILL_TARGET=8,
  PLAYER_KILL_TARGET_WOMAN=9,
  PLAYER_KILL_CHILD_SOLDIER=10,
  PLAYER_KILL_DD=11,
  OTHERS=255,
  S10020_PLAYER_DEAD=30,
  S10020_TARGET_DEAD=31,
  S10020_TARGET_KILL=32,
  S10020_TARGET_TIMEOVERDEAD=33,
  S10020_OUT_OF_MISSION_AREA=34,
  S10020_PLAYER_DESTROY_HELI=35,
  S10020_RIDING_HELI_DESTROYED=36,
  S10030_PLAYER_DEAD=37,
  S10030_TARGET_DEAD=38,
  S10040_ARRIVAL_HONEY_BEE=39,
  S10195_TARGET_ESCAPE=40,
  S10195_TARGET_ESCAPE_UNREAL=41,
  S10054_TIME_UP=42,
  S10090_TARGET_DEAD=43,
  S10090_TARGET_DEAD_MARKING_OFF=44,
  S10090_TARGET_DEAD_MARKING_ON=45,
  S10090_TARGET_FULTON_FAILED_MARKING_OFF=46,
  S10090_TARGET_FULTON_FAILED_MARKING_ON=47,
  S10010_ISHMAEL_DEAD=48,
  S10156_FILMCASE_DESTROYED=49,
  S10120_CHILD_DEAD=50,
  S10120_TARGET_DEAD=51,
  S10260_QUIET_DEAD=52,
  S10240_STAFF_DEAD=53,
  MAX=256
}
this.GAME_OVER_TARGET_DEAD_DEMO_TIME=6
this.GAME_OVER_S10020_TARGET_TIMEOVERDEAD_DEMO_TIME=25
this.GAME_OVER_S10030_SHOT_OCELOT_BY_TULLET_TIME=1
this.GAME_OVER_S10090_TARGET_DEAD_TIME=4
this.GAME_OVER_S10090_TARGET_FULTON_FAILED_TIME=4
this.FOB_DEFENCE_GAME_OVER_TYPE={INIT=0,PLAYER_DEAD=1,HOST_ENTER_GOAL=2}
this.COMMON_RADIO={
  ENEMY_RECOVERED=1,
  HOSTAGE_RECOVERED=2,
  HOSTAGE_DEAD=3,
  HOSTAGE_DAMAGED_FROM_PC=4,
  PHASE_DOWN_OUTSIDE_HOTZONE=5,
  OUTSIDE_MISSION_AREA=6,
  OUTSIDE_HOTZONE_ALERT=7,
  OUTSIDE_HOTZONE=8,
  RETURN_HOTZONE=9,
  ABORT_BY_HELI=10,
  RECOMMEND_CURE=11,
  SUPPRESSOR_BROKEN=12,
  CALL_HELI_FIRST_TIME=13,
  CALL_HELI_FIRST_TIME_HOT_ZONE=14,
  CALL_HELI_SECOND_TIME=15,
  RESULT_RANK_S=16,
  RESULT_RANK_A=17,
  RESULT_RANK_B=18,
  RESULT_RANK_C=19,
  RESULT_RANK_D=20,
  RESULT_RANK_E=21,
  RECOVERED_RUSSIAN_INTERPRETER=22,
  CALL_SUPPROT_BUDDY=23,
  TARGET_MARKED=24,
  SEARCH_TARGET_ENABLED=25,
  RESULT_RANK_NOT_DEFINED=26,
  TARGET_RECOVERED=27,
  TARGET_ELIMINATED=28,
  CANNOT_GET_INTEL_ON_ALERT=29,
  CALL_BUDDY_QUIET_WHILE_FORCE_HOSPITALIZE=30,
  OUTSIDE_HOTZONE_CHANGE_SNEAK=31,
  UNLOCK_LANDING_ZONE=32,
  DISCOVERED_BY_SNIPER=33,
  DISCOVERED_BY_ENEMY_HELI=34,
  PLAYER_NEAR_ENEMY_HELI=35,
  HELI_LOST_CONTROL_END=36,
  HELI_LOST_CONTROL_END_ENEMY_ATTACK=37,
  HELI_DAMAGE_FROM_PLAYER=38,
  DISABLE_TRANSLATE_RUSSIAN=39,
  DISABLE_TRANSLATE_AFRIKANS=40
}
this.MISSION_CLEAR_TYPE={
  ON_FOOT=1,
  RIDE_ON_HELICOPTER=2,
  RIDE_ON_VEHILCE=3,
  FOB_GOAL=4,
  FOB_ESCAPE=5,
  FREE_PLAY_ORDER_BOX_DEMO=6,
  FROM_HELISPACE=7,
  QUEST_BOSS_QUIET_BATTLE_END=8,
  QUEST_LOST_QUIET_END=9,
  QUEST_INTRO_RESCUE_EMERICH_END=10,
  CYPRUS_GOAL=11,
  RIDE_ON_FULTON_CONTAINER=12,
  FREE_PLAY_NO_ORDER_BOX=13,
  FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR=14,
  HELI_TAX_MB_FREE_CLEAR=15,
  FOB_DO_CRIME=16
}
this.ELAPSED_MISSION_EVENT_LIST={
  "D_DOG_COME_TO_GET",
  "D_DOG_GO_WITH_ME",
  "QUIET_WITH_GO_MISSION",
  "QUIET_VISIT_MISSION",
  "DECISION_HUEY",
  "THE_GREAT_ESCAPE_LIQUID",
  "FAILED_RETAKE_THE_PLATFORM",
  "CAN_REUNION_QUIET",
  "RADIATION_LEAK_MATHER_BASE",
  "MOVE_SAHELANTHROPUS",
  "BATTLEGEAR_HANGER_LEVELUP",
  "AFTER_THE_GREAT_ESCAPE_LIQUID",
  "STORY_SEQUENCE"
}
if#this.ELAPSED_MISSION_EVENT_LIST>this.ELAPSED_MISSION_COUNT_MAX then
end
this.ELAPSED_MISSION_EVENT=this.Enum(this.ELAPSED_MISSION_EVENT_LIST)
this.INIT_ELAPSED_MISSION_COUNT={
  D_DOG_COME_TO_GET=2,
  D_DOG_GO_WITH_ME=6,
  QUIET_WITH_GO_MISSION=3,
  QUIET_VISIT_MISSION=1,
  DECISION_HUEY=1,
  THE_GREAT_ESCAPE_LIQUID=1,
  FAILED_RETAKE_THE_PLATFORM=3,
  CAN_REUNION_QUIET=11,
  POD_IN_CORPSE_01=1,
  RADIATION_LEAK_MATHER_BASE=2,
  MOVE_SAHELANTHROPUS=1,
  BATTLEGEAR_HANGER_LEVELUP=2,
  AFTER_THE_GREAT_ESCAPE_LIQUID=1,
  STORY_SEQUENCE=2
}
this.QUIET_REUNION_MISSION_COUNT=6--RETAILPATCH 1006 added
this.WEAPONSLOT={MIN=0,PRIMARY_HIP=0,PRIMARY_BACK=1,SECONDARY=2,SUPPORT_0=3,SUPPORT_1=4,SUPPORT_2=5,SUPPORT_3=6,SUPPORT_4=7,SUPPORT_5=8,SUPPORT_6=9,SUPPORT_7=10,MAX=11,GUN_WEAPON_MAX=4}
this.HONEY_BEE_EQUIP_ID=TppEquip.EQP_WP_HoneyBee
this.INIT_MAG={ASSAULT_DEFAULT=8,MACHINEGUN_DEFAULT=3,SHOTGUN_DEFAULT=10,SNIPER_DEFAULT=10,MISSILE_DEFAULT=4,HANDGAN_DEFAULT=10,SUBMACHINEGUN_DEFAULT=10}
this.SCRIPT_BLOCK_STATE={MIN=0,EMPTY=1,ALLOCATED=1,INITIALIZED=2,ACTIVATE_REQUESTED=3,WAITING_ACTIVATE=4,ACTIVATED=5,MAX=6}
this.HOSTAGE_UNLOCK_START=0
this.HOSTAGE_UNLOCK_FINISH=1
this.STOCK_DIRECTION_RIGHT=0
this.STOCK_DIRECTION_LEFT=1
this.TIPS={TIPS=1,R3_ZOOM=2,COVER=3,COVER_SHOOT=4,QUICK_DIVE=5,REFLEX_MODE=6,WEAPON_RANGE=7,RETICLE_COLOR=8,RELOAD=9,STOCK_CHANGE=10,INJURY=11,AUTO_AIM=12,VIEWPOINT_WEAPON=13,TAKE_DOWN=14,BASIC=15,SPOTTED=16,INFILTRATING=17,BINO_MARKING=18,PUT_MARKER=19,RADIO_ESPIONAGE=20,LOG=21,COMOF_STANCE=22,STEALTH_MODE=23,TRASH=24,TOILET=25,HORSE_HIDEACTION=26,ACTION_MAKENOISE=27,CALL_MENU=28,TRANQUILIZER=29,PICKUP_WEAPON=30,AMMO=31,CARRY_WEAPON_LIMIT=32,HOLD_UP=33,SUPPRESSOR=34,THROW_EQUIP=35,NVG=36,BINOCULARS=37,AUDIO_CUE=38,MARKING=39,NIGHT=40,COMBAT_ALERT=41,ELUDE=42,QUICK_CHANGE=43,CQC=44,CQC_THROW=45,CQC_ATTACK=46,CQC_HOLD_UP=47,CQC_COMB=48,CQC_HOLD=49,CQC_INTERROGATION=50,CQC_CHOKE=51,CQC_KILL=52,HOLD_UP_INTERROGATION=53,GET_DOWN=54,INTERPRETER=55,FREE_RUN=56,DAY_NIGHT_SHIFT=57,COMOF_NIGHT=58,COMOF_INGRASS=59,SAND_STORM=60,COMOF_VEHICLE=61,TRACK_HIDE=62,ROLLING=63,CRACK_CLIMB=64,BULLET_PENETRATE=65,NON_LETHAL_BULLET=66,BULLET_REFILL=67,SUPPLY_WEAPON=68,SUPPORT_HELI=69,ACC=70,TACTICAL_BUDDY=71,BUDDY_COMMAND=72,BUDDY_HORSE=73,ANIMALS=74,SAVE_ANIMAL=75,PLANT=76,DIAMOND=77,MATERIAL=78,COMMUNICATOR=79,ELECTRICITY=80,RADAR=81,SEARCH_LIGHT=82,GUN_LIGHT=83,SNIPER_RIFLE=84,FLARE_GRENADE=85,ITEM=86,CARDBOARD_BOX=87,PHANTOM_CIGAR_TOILET=88,MICROPHONE=89,MB_DEVICE=90,FULLTON_DEVICE=91,SHOWER_ROOM=92,MB_CLASS_FUNCTION=93,FULTON_CLASS_FUNCTION_STOP=94,GMP=95,LOSS_GMP=96,RANK=97,MORALE=98,EMBLEM=99,RECO_TRANQUILIZER=100,FREE=101,SKILL=102,WOOD_BOX=103,RED_DRUMS=104,FOG=105,MAP_SHORTCUT=106,FULLTON_RECOVERY=107,FULTON_MACHINEGUN=108,DEV_DOCUMENT=109,BOX_MOVE=110,SUPPORT_ATTACK=111,HEROISM=112,CODENAMES=113,DEVELOPMENT=114,TANK=115,GUNSHIP=116,BUDDY_DOG=117,DECOY=118,MINE=119,ACTIVE_SONAR=120,BUDDY_WALKER=121,FULTON_COMMON_VEHICLE=122,FULTON_CONTAINER=123,RAIN=124,UNDER_BARREL=125,BUDDY_QUIET=126,SLEEP_GUS=127,TROUBLE=128,FOB_WORM_HOLE=129,INJURY_2=130,BULLET_PENETRATE_FAIL=131,ANIMAL_CAGE=132,FULTON_MORTAR=133,FULTON_ANTI_AIRCRAFT=134,PHANTOM_CIGAR_TRASH=135,FOB_ABILITY=136,WORM_HOLE=137,FOB_SHIELD=138,ESP_POINT=139,STAFF_RANK_BONUS=140,FOB_GOAL=141,FOB_GOAL_BONUS=142,DIRECT_CONTRACTS=143,REVENGE_WORM_HOLE=144,NUCLEAR_WEAPON=145,FOB_HERO=146,EQUIPPED_GUARDS=147,PF_RATING=148,PF_POINT=149,FOB_SUPPORT=150,FOB_RESCUE_STAFF=151,EMERGENCES=152,FOB_CONSTRUCT=153,ONLINE_DISPATCH_MISSION=154}
this.TIPS_REDUNDANT_REF={[this.TIPS.INJURY_2]=this.TIPS.INJURY,[this.TIPS.BULLET_PENETRATE_FAIL]=this.TIPS.BULLET_PENETRATE,[this.TIPS.ANIMAL_CAGE]=this.TIPS.SAVE_ANIMAL,[this.TIPS.FULTON_MORTAR]=this.TIPS.FULTON_MACHINEGUN,[this.TIPS.FULTON_ANTI_AIRCRAFT]=this.TIPS.FULTON_MACHINEGUN,[this.TIPS.PHANTOM_CIGAR_TRASH]=this.TIPS.PHANTOM_CIGAR_TOILET}
this.CONTINUE_TIPS_TABLE={[this.STORY_SEQUENCE.STORY_START]={"BASIC","SPOTTED"},[this.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL]={"AUDIO_CUE","MARKING","NIGHT","COMBAT_ALERT"},[this.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE]={"TRANQUILIZER"},[this.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON]={"DEVELOPMENT","GUNSHIP","TANK"}}
this.CONTROL_GUIDE={MB_DEVICE=1,BINO=2,BINO_ZOOM=3,OPTIONALRADIO=4,CUSTUMMARKER=5,ADVICE=6,HORSE_CALL=7,HORSE_HIDE=8,HORSE_HIDE_CHANGE=9,HORSE_RUN=10,HORSE_RIDEON=11,HORSE_GETOFF=12,GET_INTEL=13,ATTACK=14,RELOAD=15,CURE=16,JUMP=17,STANCE=18,LOOK_IN=19,ELUDE_UP=20,ELUDE_DOWN=21,CLIMEB_UP=22,ROLLING=23,COVER_ATTACK=24,SHOULDER=25,SHOULDER_THROW=26,HULTON=27,PIPE_UP=28,FREECLIMD=29,GARBAGEBOX_HIDE=30,CQC=31,CQC_PUNCH=32,CQC_THROW=33,RESTRAINT2=34,NONE=35,INTERROGATION=36,SWOON=37,KILL=38,C4_SET=39,C4_EXPLODING=40,ACCELARATER=41,BRAKE=42,HELI_RIDEON=43,HELI_GETOFF=44,CQC_COMBO=45,EQUIPMENT_WP=46,CAMERA_MOVE=47,CAMERA_ZOOM=48,CAMERA_CHANGE=49,PLAY_MOVE=50,PLAY_COVER=51,PLAY_DASH=52,PLAY_EVADE=53,ORDER_CHILD=54,MACHINEGUN=55,MORTAR=56,ANTI_AIRCRAFT=57,SEARCH_LIGHT=58,UNDER_BARREL=59,MOVE_IN_HELI=60,BOOSTER_SCOPE=61,DRIVE_COMMON_VEHICLE=62,DRIVE_WALKER_GEAR=63,RIDE_HORSE=64,SNIPER_RIFLE=65,SHIELD=66,STANCE_SQUAT=67,STANCE_CRAWL=68,STEP_FENCE=69,ATTACK_VEHICLE_SHOOT=70,ATTACK_VEHICLE_CAMERA=71,VEHICLE_LIGHT=72}
this.PAUSE_CONTROL_GUIDE={[this.CONTROL_GUIDE.DRIVE_COMMON_VEHICLE]="vehicle",[this.CONTROL_GUIDE.DRIVE_WALKER_GEAR]="walker-gear",[this.CONTROL_GUIDE.RIDE_HORSE]="horse"}
this.CONTROL_GUIDE_LANG_ID_LIST={"tutorial_mb_device","tutorial_bino","tutorial_bino_zoom","tutorial_optionalradio","tutorial_set_marker","tutorial_advice","tutorial_horse_call","tutorial_horse_hide","tutorial_horse_hide_change","tutorial_horse_run","tutorial_horse_rideon","tutorial_horse_getoff","tutorial_get_intel","tutorial_attack","tutorial_reload","tutorial_cure","tutorial_jump","tutorial_stance","tutorial_look_in","tutorial_elude_up","tutorial_elude_down","tutorial_climeb_up","tutorial_rolling","tutorial_cover_attack","tutorial_shoulder","tutorial_shoulder_throw","tutorial_hulton","tutorial_pipe","tutorial_cliff","tutorial_garbagebox_hide","tutorial_cqc","tutorial_cqc_punch","tutorial_cqc_throw","tutorial_restraint2","","tutorial_interrogation","tutorial_swoon","tutorial_kill","tutorial_C4_set","tutorial_C4_exploding","tutorial_accelarater","tutorial_brake","tutorial_heli_rideon","tutorial_heli_getoff","tutorial_cqc_combo","tutorial_equipment_wp","tutorial_camera_move","tutorial_camera_zoom","tutorial_camera_change","tutorial_play_move","tutorial_play_cover","tutorial_play_dash","tutorial_play_evade","tutorial_order_child","tutorial_attack_machinegun","tutorial_attack_mortar","tutorial_attack_anti_aircraft","tutorial_searchlight_onoff","tutorial_change_barrel","tutorial_play_move","tutorial_bino_zoom","tutorial_show_controller","tutorial_show_controller","tutorial_show_controller","tutorial_change_camera","tutorial_shield2","tutorial_stance3","tutorial_stance2","tutorial_fence_jump","tutorial_v_attack","tutorial_v_fps_tps","tutorial_searchlight_onoff"}
this.GMP_COST_TYPE={FULTON=1,SUPPORT_SUPPLY=2,SUPPORT_ATTACK=3,CALL_HELLI=4,BUDDY=5,CLEAR_SIDE_OPS=6,DESTROY_SUPPORT_HELI=7}
this.CLUSTER_NAME={"Command","Combat","Develop","Support","Medical","Spy","BaseDev"}
this.CLUSTER_DEFINE=this.Enum(this.CLUSTER_NAME)
this.PLNT_NAME={"Special","Common1","Common2","Common3"}
this.PLNT_DEFINE=this.Enum(this.PLNT_NAME)
this.SECURITY_SETTING={
  numInSpecialPlatform={
    soldier={4,8,12,4,8,12,4,8,12,4,8,12,4,8,12,4,8,12,4,8,12},
    camera={1,1,1,1,1,2,1,2,3,2,3,4,2,3,5,3,4,6,3,5,8},
    decoy={1,1,1,1,1,2,2,3,4,2,4,6,3,5,8,3,6,10,4,8,12},
    mine={1,1,1,1,1,2,2,3,4,2,4,6,3,5,8,3,6,10,4,8,12},
    uav={1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,2,3,2,3,4},
    ir_sensor={1,1,1,1,1,1,1,1,2,1,1,2,1,2,3,2,3,4,3,4,5},
    alarm={1,1,1,1,1,2,1,2,3,1,2,4,2,2,4,2,3,4,2,3,4}
  },
  numInCommonPlatform={
    soldier={2,4,8,2,4,8,2,4,8,2,4,8,2,4,8,2,4,8,2,4,8},
    camera={1,1,1,1,1,2,1,2,3,2,3,4,2,4,5,3,4,6,3,5,7},
    decoy={1,1,1,1,1,2,1,2,4,2,3,6,2,4,7,3,5,8,3,6,9},
    mine={1,1,1,1,1,2,1,2,4,2,3,6,2,4,7,3,5,8,3,6,9},
    uav={1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,2,1,1,2},
    ir_sensor={1,1,1,1,1,1,1,1,2,1,2,2,1,2,3,2,3,4,3,4,5},
    alarm={1,1,1,1,1,1,1,2,2,2,3,4,2,4,6,3,5,8,4,7,10}},
  numInCommandPlatform={alarm={1,1,1,1,1,2,1,2,3,2,3,4,2,3,5,2,4,6,3,5,6}},
  numInBaseDevPlatform={alarm={1,1,1,1,1,2,2,4,6,3,6,10,4,9,14,6,12,18,7,14,22}}
}
this.FOB_EVENT_ID_LIST={
  ARMOR={3},
  HOSTAGE={3},
  ZOMBIE={5},--RETAILPATCH 1070
  PARASITE_METAL={5}--RETAILPATCH 1070
}
this.STATION_LIST={
  afgh={"bridge","enemyBase","field","fort","tent","cliffTown","commFacility","powerPlant","remmnants","slopedTown","sovietBase","village"},
  mafr={"banana","diamond","lab","flowStation","hill","outland","pfCamp","savannah","swamp"},
  mtbs={"Command","Combat","Develop","Support","Medical","Spy","BaseDev"}
}
this.STAFF_TYPE_ID={NORMAL=1,COMBAT=2,DEVELOP=3,BASE_DEV=4,SUPPORT=5,SPY=6,MEDICAL=7}
this.UNIQUE_STAFF_TYPE_ID={
  SNEAK=248,
  OCELOT=249,
  MILLER=250,
  QUIET=251,
  HUEY=252,
  CODETALKER=253,
  INITIAL_STAFF_01=0,
  INITIAL_STAFF_02=1,
  INITIAL_STAFF_03=2,
  FULTON_LESSON_STAFF_01=3,
  FULTON_LESSON_STAFF_02=4,
  FULTON_LESSON_STAFF_03=5,
  FULTON_LESSON_STAFF_04=6,
  FULTON_LESSON_STAFF_05=7,
  FULTON_LESSON_STAFF_06=8,
  FULTON_LESSON_STAFF_07=9,
  FULTON_LESSON_STAFF_08=10,
  FULTON_LESSON_STAFF_09=33,
  FULTON_LESSON_STAFF_10=34,
  FULTON_LESSON_STAFF_11=35,
  FULTON_LESSON_STAFF_12=36,
  FULTON_LESSON_STAFF_13=45,
  FULTON_LESSON_STAFF_14=46,
  S10080_GUN_SMITH=11,
  S10080_ENGINEER=12,
  S10054_HOSTAGE_01=58,
  S10054_HOSTAGE_02=93,
  S10054_HOSTAGE_03=94,
  S10054_HOSTAGE_04=95,
  S10054_HOSTAGE_05=96,
  S10054_HOSTAGE_06=97,
  S10043_INTERPRETER=14,
  S10086_INTERPRETER=15,
  S10036_COMMANDER=16,
  S10040_DEAF_HOSTAGE=17,
  S10052_MALAK=18,
  S10052_DRIVER=19,
  S10085_FEMALE_HOSTAGE=20,
  S10120_OUTLAND_HOSTAGE=102,
  S10121_PF_OPERATOR=21,
  S10121_WEAPON_DEALER=22,
  S10200_TARGET_HOSTAGE=23,
  S10200_BONUS_HOSTAGE=24,
  S10200_CHILD_COMMANDER=25,
  S10100_BANANA_TARGET=26,
  S10171_BONUS_SOLIDER=27,
  S10085_HOSTAGE=28,
  S10041_FIELD_COMMANDER=29,
  S10041_VILLAGE_COMMANDER=30,
  S10041_ENEMY_BASE_COMMANDER=31,
  S10041_FIELD_DRIVER=47,
  S10041_FIELD_BODYGUARD=48,
  S10041_ENEMY_BASE_DRIVER=49,
  S10041_ENEMY_BASE_BODYGUARD=50,
  S10044_CLIFFTOWN_VIP=62,
  S10044_CLIFFTOWN_HOSTAGE=92,
  S10033_TARGET_HOSTAGE=32,
  S10211_TRAFFICKER=37,
  S10211_BODYGUARD_01=51,
  S10211_BODYGUARD_02=52,
  S10211_BODYGUARD_03=53,
  S10211_BODYGUARD_04=54,
  S10211_BODYGUARD_05=55,
  S10045_TARGET_HOSTAGE=38,
  S10045_EXECUTIONER=39,
  S10115_MOSQUITO=40,
  S10195_TARGET=41,
  S10195_TRACER=42,
  S10195_HOSTAGE=43,
  S10020_ENEMY_BASE_COMMANDER=56,
  S10020_DRIVER=57,
  S10086_HOSTAGE_A=44,
  S10086_HOSTAGE_B=63,
  S10086_HOSTAGE_C=64,
  S10086_HOSTAGE_D=65,
  S10091_EXECUTEUNIT_A=66,
  S10091_EXECUTEUNIT_B=67,
  S10091_SWAMPNEAR_HOSTAGE=100,
  S10091_TRUCK_DRIVER=101,
  S10156_HOSTAGE=109,
  S10043_HOSTAGE_A=87,
  S10043_HOSTAGE_B=88,
  S10082_HOSTAGE_A=98,
  S10082_HOSTAGE_B=99,
  S10045_HOSTAGE_A=107,
  S10045_HOSTAGE_B=108,
  S10045_HOSTAGE_TARGET=38,
  S10045_EXECUTION=39,
  S10033_HOSTAGE=89,
  S10093_ZRS_CAPTAIN=68,
  S10041_HOSTAGE_A=90,
  S10041_HOSTAGE_B=91,
  S10211_HOSTAGE_A=103,
  S10211_HOSTAGE_B=104,
  S10211_HOSTAGE_C=105,
  S10211_HOSTAGE_D=106,
  QUEST_MSF_01=69,
  QUEST_MSF_02=70,
  QUEST_MSF_03=71,
  QUEST_MSF_04=72,
  QUEST_MSF_05=73,
  QUEST_MSF_06=74,
  QUEST_MSF_07=75,
  QUEST_MSF_08=76,
  QUEST_MSF_09=77,
  QUEST_MSF_10=78,
  QUEST_PASHTO=80,
  QUEST_KIKONGO=81,
  QUEST_MASTERGUNSMITH=79,
  QUEST_GUNSMITH_02=13,
  QUEST_KANTOKU=110,
  QUEST_TAN=111,
  QUEST_HOSTAGE_R_01=166,
  QUEST_HOSTAGE_R_02=156,
  QUEST_HOSTAGE_SR_01=177,
  QUEST_HOSTAGE_SR_02=179,
  QUEST_AFRLKAANS=184,
  RESCUE_SP_HOSTAGE=224,
  RESCUE_HOSTAGE_E20010_001=219,
  RESCUE_HOSTAGE_E20010_002=220,
  RESCUE_HOSTAGE_E20010_003=221,
  RESCUE_HOSTAGE_E20010_004=222,
  RESCUE_HOSTAGE_E20050_000=234,
  RESCUE_HOSTAGE_E20050_001=235,
  RESCUE_HOSTAGE_E20050_002=236,
  RESCUE_HOSTAGE_E20050_003=237,
  RESCUE_HOSTAGE_E20020_000=225,
  RESCUE_HOSTAGE_E20020_001=226,
  RESCUE_HOSTAGE_E20030_000=229,
  RESCUE_HOSTAGE_E20030_001=230,
  RESCUE_HOSTAGE_E20030_002=231,
  RESCUE_ENEMY_US_MISSION_TARGET_CENTER000=227,
  RESCUE_ENEMY_US_MISSION_TARGET_SQUAD000=228,
  RESCUE_E20030_BETRAYER=232,
  RESCUE_E20030_MASTERMIND=233,
  RESCUE_FRIENDMAN=110,
  RESCUE_GENOME_SOILDER_SAVE=238,
  S10040_ENEMY_01=59,
  S10040_ENEMY_02=60,
  S10040_ENEMY_03=61,
  STAFF_STAFF2_MSF_01=241,
  STAFF_STAFF2_MSF_02=242,
  STAFF_STAFF1_FOX_01=239,
  STAFF_STAFF1_FOX_02=240,
  STAFF_STAFF3_DD_01=243,
  STAFF_STAFF3_DD_02=244,
  STAFF_STAFF4_FOX_HOUND_01=245,
  STAFF_STAFF4_FOX_HOUND_02=246
}
this.IGNORE_EXIST_STAFF_CHECK={
  [this.UNIQUE_STAFF_TYPE_ID.SNEAK]=true,
  [this.UNIQUE_STAFF_TYPE_ID.OCELOT]=true,
  [this.UNIQUE_STAFF_TYPE_ID.MILLER]=true,
  [this.UNIQUE_STAFF_TYPE_ID.QUIET]=true,
  [this.UNIQUE_STAFF_TYPE_ID.HUEY]=true,
  [this.UNIQUE_STAFF_TYPE_ID.CODETALKER]=true,
  [this.UNIQUE_STAFF_TYPE_ID.INITIAL_STAFF_01]=true,
  [this.UNIQUE_STAFF_TYPE_ID.INITIAL_STAFF_02]=true,
  [this.UNIQUE_STAFF_TYPE_ID.INITIAL_STAFF_03]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_01]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_02]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_03]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_04]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_05]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_06]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_07]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_08]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_09]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_10]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_11]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_12]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_13]=true,
  [this.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_14]=true,
  [this.UNIQUE_STAFF_TYPE_ID.S10040_DEAF_HOSTAGE]=true
}
this.CYPR_PLAYER_INITIAL_WEAPON_TABLE={{secondary="EQP_None"},{primaryHip="EQP_None"},{primaryBack="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"}}
this.CYPR_PLAYER_INITIAL_ITEM_TABLE={"EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None"}
this.RANKING_MAX=21
this.RANKING_ENUM=Tpp.Enum{
  "TotalTacticalTakeDownCount",
  "XPersonMarkingTime",
  "FirstHeadShotTime",
  "FirstHeadShotTimeTranq",
  "FirstCommandPostAnnihilateTime",
  "CboxGlidingDistance",
  "MechaNeutralizeCount",
  "LongestBirdShotDistance",
  "XPersonPerfectStealthCQCNeutralizeTime",
  "XRocketArmNeutralizeTime",
  "FobSneakingGoalCount",
  "FobDefenceSucceedCount",
  "NuclearDisposeCount",
  "mtbs_q42010",
  "mtbs_q42020",
  "mtbs_q42030",
  "mtbs_q42040",
  "mtbs_q42050",
  "mtbs_q42060",
  "mtbs_q42070"
}
this.DEFAULT_DROP_ROUTE={
  [10033]="lz_drp_enemyBase_S0000|rt_drp_enemyBase_S_0000",
  [10036]="lz_drp_field_N0000|rt_drp_field_N_0000",
  [10040]="lz_drp_slopedTownEast_E0000|rt_drp_slopedTownEast_E_0000",
  [10041]="lz_drp_ruinsNorth_S0000|rt_drp_ruinsNorth_S_0000",
  [10043]="lz_drp_ruinsNorth_S0000|rt_drp_ruinsNorth_S_0000",
  [10044]="lz_drp_cliffTown_S0000|rt_drp_cliffTown_S_0000",
  [10052]="lz_drp_remnants_S0000|rt_drp_remnants_S_0000",
  [10054]="lz_drp_enemyBase_S0000|rt_drp_enemyBase_S_0000",
  [10081]="lz_drp_diamondSouth_W0000|rt_drp_diamondSouth_W_0000",
  [10085]="lz_drp_hillNorth_W0000|rt_drp_hillNorth_W_0000",
  [10086]="lz_drp_swamp_S0000|rt_drp_swamp_S_0000",
  [10090]="lz_drp_pfCampNorth_S0000|rt_drp_pfCampNorth_S_0000",
  [10091]="lz_drp_flowStation_E0000|lz_drp_flowStation_E_0000",
  [10100]="lz_drp_savannahWest_N0000|lz_drp_savannahWest_N_0000",
  [10110]="lz_drp_hillWest_S0000|lz_drp_hillWest_S_0000",
  [10120]="lz_drp_outland_N0000|rt_drp_outland_N_0000",
  [10121]="lz_drp_pfCamp_N0000|rt_drp_pfcamp_N_0000",
  [10156]="lz_drp_ruins_S0000|rt_drp_ruins_S_0000",
  [10171]="lz_drp_savannahEast_S0000|lz_drp_savannahEast_S_0000",
  [10195]="lz_drp_savannahEast_S0000|lz_drp_savannahEast_S_0000",
  [10200]="lz_drp_hillNorth_N0000|rt_drp_hillNorth_N_0000",
  [10211]="lz_drp_savannahEast_N0000|rt_drp_savannahEast_N_0000",
  [10130]="rts_drp_lab_S_0000",
  [10045]="lz_drp_field_N0000|rt_drp_field_N_0000",
  [10082]="lz_drp_pfCampNorth_S0000|rt_drp_pfCampNorth_S_0000",
  [10093]="lz_drp_lab_W0000|rt_drp_lab_W_0000"
}
this.DIRECTION_ZOOM_IN_CAMERA_ZOOM_INTERP_TIME=1
this.DIRECTION_ZOOM_IN_CAMERA_ROTATION_INTERP_TIME=1
this.ENEMY_HELI_COLORING_TYPE={DEFAULT=0,BLACK=1,RED=2}
InfCore.Log"/TppDefine.lua done"
return this
