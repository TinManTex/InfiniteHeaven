gz_install_message = {

events = {
	GzInstallMessage = {
 		EndInstall		= "OnEndInstall",
	},
},


OnEndInstall = function()
	Fox.Log( "=== OnEndInstall ===" )

	
	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:UnLoadUiDefalutBlock()

	
	TppGameSequence.RequestTitle(1)

	Fox.Log( "=== End OnEndInstall ===" )
end,

}
