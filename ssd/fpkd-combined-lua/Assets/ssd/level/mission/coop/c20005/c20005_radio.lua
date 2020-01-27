local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
}

this.debugRadioLineTable = {
	Seq_Game_ExplainArea = {
		"AI 「特異点エリアへの転送完了。酸素供給度100％、視界良好、呼吸可能です」",
	},
	Seq_Game_ExplainObjective = {
		"AI 「では改めて本ミッションの目的の確認です」",
	},
	Seq_Game_Tips_Objective = {
		"AI  「本ミッションでは特異点に設置したワームホール採掘機を通じて『アルクスエナジー』を採集し…、」",
		"AI  「集めた『アルクスエナジー』を使用して他世界へのワームホールを開通させ、通常は入手困難な貴重資源を入手することが目的となります」",
		"AI  「差しあたってのターゲットとなるのは元の世界に戻るための『帰還パーツ』と言う事になりますね」",
	},
	Seq_Game_MissionStart = {
		"AI 「まずは特異点に向かい採掘機をセットしましょう」",
	},
	Seq_Game_ExplainSingularity = {
		"AI 「そろそろ特異点が目視でも確認出来るかと思います。ワームホール採掘機を転送設置してください」",
		"AI 「付近のクリーチャーは排除しておいた方が良いでしょう」",
	},
	Seq_Game_ExplainMenu = {
		"AI 「ワームホール採掘機転送完了」",
		"AI 「さっそく採掘を開始したいところですが…、その前に≪転送クラフト≫についてご説明します」",
		"AI 「ワームホール採掘機にアクセスしてください」",
	},
	Seq_Game_ExplainMap = {
		"AI 「採掘中は、またいつものようにクリーチャーを引き寄せてしまうため、採掘機を防衛する必要があります」",
		"AI 「幸いこの特異点エリアの酸素濃度であればクリーチャーの出現予測を立てることが出来ます」",
	},
	Seq_Game_BeforeWave = {
		"AI 「防衛準備が整ったら、採掘機メニューより採掘を開始してください」",
	},
	Seq_Game_DefenseWave1_2 = {
		"AI 「別の方向からも敵が来ました。この地点の防衛をお願いします」",
	},
	Seq_Game_DefenseBreak1 = {
		"AI 「1回目の採掘が終了しました。次の採掘開始までに準備を整えてください」",
	},
	Seq_Game_DefenseWave2 = {
		"AI 「採掘を再開しました。採掘機を防衛してください。」",
		"AI 「採掘中は採掘機メニューから「加速」を行うことで（クバンエナジーを消費して）『アルクスエナジー』採掘効率を高めることが出来ます」",
		"AI 「また、ステージ中に出現する『アルクストラペゾヘドロン』を直接採集することでも『アルクスエナジー』を獲得できます」",
	},
	Seq_Game_DefenseBreak2 = {
		"AI 「2回目の採掘が終了しました。次の採掘開始までに準備を整えてください。」",
		"AI 「今回は次の採掘開始までに余裕がありそうですね…」",
		"AI 「今のうちに、より多くの報酬獲得が期待できる≪ステルスエリア≫の攻略に挑戦してみましょう」",
	},
	Seq_Game_Tips_StealthArea = {
		"AI 「ステルスエリアは周辺よりもはるかにLvの高いクリーチャーの巣窟になっています」",
		"AI 「多数の『アルクストラペゾヘドロン』や貴重素材等の獲得が期待できる反面、ステルスエリアの攻略には大きなリスクを伴います」",
		"AI  「現時点ではあまり無理せず、武器装備や獲得スキルを充実させてから本格的に挑戦するのをお勧めします」",
	},
	Seq_Game_StealthArea = {
		"AI  「今回は手近な『アルクストラペゾヘドロン』の採集に留めておきましょう」",
	},
	Seq_Game_ReturnToMine = {
		"AI 「なお、他サバイバーとの協力プレイであれば、採掘機の防衛とステルスエリア攻略とで手分けをして挑むのも良いでしょう。」",
		"AI 「そろそろ次の採掘が始まりますね。採掘機まで戻ってください」",
	},
	Seq_Game_ExplainRetreat = {
		"AI 「採掘ミッションには採掘可能な最大回数が決まっています。」",
		"AI 「可能な限り『アルクスエナジー』を採集するのが目的ですから可能な限り採掘を繰り返していただきたいのですが…、」",
		"AI 「万が一防衛に失敗して採掘機が破壊されてしまうと、集めた『アルクスエナジー』の一部が四散してしまいます。」",
		"AI 「そのため、これ以上の採掘をあきらめる「撤退申請」が採掘機メニューには存在します」",
	},
	Seq_Game_ExplainWave3 = {
		"AI 「それでは残りの採掘を続けてください。勿論、途中で勇気ある撤退を選択していただいてもかまいません」",
	},
	Seq_Game_ExplainReward = {
		"AI 「採掘ミッション完了。続いて収集した『アルクスエナジー』を用いて≪報酬ワームホール採掘≫を行います」",
	},
	Seq_Game_Reward = {
		"AI 「採掘した結果、様々な物資が獲得できました」",
	},
	Seq_Game_Clear = {
		"AI 「ミッション完了。ステージングエリアに転送します」",
	},
}

this.sequenceRadioTable = {
	Seq_Game_ExplainArea = "Seq_Game_ExplainArea",
	Seq_Game_ExplainObjective = "Seq_Game_ExplainObjective",
	Seq_Game_Tips_Objective = "Seq_Game_Tips_Objective",
	Seq_Game_MissionStart = "Seq_Game_MissionStart",
	Seq_Game_ExplainSingularity = "Seq_Game_ExplainSingularity",
	Seq_Game_ExplainMenu = "Seq_Game_ExplainMenu",
	Seq_Game_ExplainMap = "Seq_Game_ExplainMap",
	Seq_Game_BeforeWave = "Seq_Game_BeforeWave",
	Seq_Game_DefenseWave1_2 = "Seq_Game_DefenseWave1_2",
	Seq_Game_DefenseBreak1 = "Seq_Game_DefenseBreak1",
	Seq_Game_DefenseWave2 = "Seq_Game_DefenseWave2",
	Seq_Game_DefenseBreak2 = "Seq_Game_DefenseBreak2",
	Seq_Game_Tips_StealthArea = "Seq_Game_Tips_StealthArea",
	Seq_Game_StealthArea = "Seq_Game_StealthArea",
	Seq_Game_ReturnToMine = "Seq_Game_ReturnToMine",
	Seq_Game_ExplainRetreat = "Seq_Game_ExplainRetreat",
	Seq_Game_DefenseWave3 = "Seq_Game_DefenseWave3",
	Seq_Game_ExplainReward = "Seq_Game_ExplainReward",
	Seq_Game_Reward = "Seq_Game_Reward",
	Seq_Game_Clear = "Seq_Game_Clear",
}




this.PlaySequenceRadio = function()
	Fox.Log( "c20005_radio.PlaySequenceRadio()" )
	local radioName = this.sequenceRadioTable[ TppSequence.GetCurrentSequenceName() ]
	if radioName then
		TppRadio.Play( radioName )
	end
end




return this
