--DEBUGNOW
return InfCore.PCall(function()

    local this = {}
    local StrCode32 = Fox.StrCode32
    local StrCode32Table = Tpp.StrCode32Table

    this.requires = {}

    this.soldierDefine = {
      afc0_main_cp = {
        "sol_main_0000",
        "sol_main_0001",
        "sol_main_0002",
        "sol_main_0003",
        "sol_main_0004",
        "sol_main_0005",
      },
    }

    this.routeSets = {
      afc0_main_cp = {
        priority = {
          "groupA",
        },
        sneak_day = {
          groupA = {
            "rt_main_d_0000",
            "rt_main_d_0001",
            "rt_main_d_0002",
            "rt_main_d_0003",
            "rt_main_d_0004",
            "rt_main_d_0005",
            "rt_main_d_0006",
            "rt_main_d_0007",
          },
        },
        sneak_night= {
          groupA = {
            "rt_main_n_0000",
            "rt_main_n_0001",
            "rt_main_n_0002",
            "rt_main_n_0003",
            "rt_main_n_0004",
            "rt_main_n_0005",
            "rt_main_n_0006",
            "rt_main_n_0007",
          },
        },
        caution = {
          groupA = {
            "rt_main_c_0000",
            "rt_main_c_0001",
            "rt_main_c_0002",
            "rt_main_c_0003",
            "rt_main_c_0004",
            "rt_main_c_0005",
            "rt_main_c_0006",
            "rt_main_c_0007",
          },
        },
      },
    }

    this.combatSetting = {
      nil
    }

    this.InitEnemy = function ()
    end

    this.SetUpEnemy = function ()
      --DEBUGNOW
      local gameObjectId
      local seed = { 84, 64 }
      local seedNum = 1

      for i, enemyId in pairs(this.soldierDefine.afc0_main_cp)do
        gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", enemyId )
        GameObject.SendCommand( gameObjectId, { id = "ChangeFova",  balaclavaFaceId=TppEnemyFaceId.dds_balaclava6, seed = seed[seedNum] } )

        if seedNum == 1 then
          seedNum = 2
        else
          seedNum = 1
        end
      end
      
    end


    this.OnLoad = function ()
    end

    return this

end)--DEBUGNOW
