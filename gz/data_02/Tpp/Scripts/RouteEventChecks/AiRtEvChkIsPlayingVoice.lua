






AiRtEvChkIsPlayingVoice = {








EnableCheck = function( chara )

	
	local plgVoice = chara:FindPlugin( "ChVoicePlugin" )
	if Entity.IsNull( plgVoice ) then
		plgVoice = chara:FindPlugin( "ChVoicePlugin2" )
		if Entity.IsNull( plgVoice ) then
			return false
		end
	end
	
	return true
end,








EndCheck = function( chara )
	
	local plgVoice = chara:FindPlugin( "ChVoicePlugin" )
	if Entity.IsNull( plgVoice ) then
		plgVoice = chara:FindPlugin( "ChVoicePlugin2" )
		if Entity.IsNull( plgVoice ) then
			return true
		end
	end

	
	if not plgVoice:IsPlaying() then
		return true
	end

	return false
end,
}
