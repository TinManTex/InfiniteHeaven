




TppUiPrefetchTexture = {

InitTable = function()

	
	
	if Fox.GetPlatformName() == 'Windows' then
		UiDaemon.SetPrefetchTextureTable {
			
			"/Assets/tpp/ui/ModelAsset/mb_photo/Pictures/ui_mb_photo_icon_a.ftex",
		}
	end

	
	UiDaemon.SetPrefetchTextureTable {
		"/Assets/tpp/ui/ModelAsset/cmn_loadmark/Pictures/cmn_loadmark_logo_mini.ftex",
		"/Assets/tpp/ui/ModelAsset/cmn_loadmark/Pictures/cmn_loadmark_icon_a_alp.ftex",
	}

end,

}

