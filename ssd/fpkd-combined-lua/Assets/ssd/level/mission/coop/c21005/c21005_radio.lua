local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
}




this.debugRadioLineTable = {
	Seq_Game_ExplainGeneral = {
		"AI「採掘ミッションを開始します」",
	},
	Seq_Game_Tips_General = {
		"AI「採掘ミッションは敵拠点に潜入し、エネルギーを採掘する事が目的です」",
	},
	Seq_Game_ExplainCraftBoard = {
		"AI 「採掘ミッションに備えてクラフトボードを準備しておく必要があります」",
		"AI 「倉庫メニューからクラフトボードを選択してください」",
	},
	Seq_Game_ExplainAcceptMission = {
		"AI 「それでは『採掘ミッション』を始めましょう」",
		"AI 「受注端末にアクセスして前回特定した特異点への『採掘ミッション』を受注してください」",
	},
	Seq_Game_ExplainMatching = {
		"AI 「ミッション受注状態になりました」",
	},
	Seq_Game_Tips_Matching = {
		"AI 「他サバイバーの参加を待つ場合はこのまま待機することでこのステージングエリアに迎え入れる事が出来ます」",
	},
	Seq_Game_ExplainSortie = {
		"AI 「今回は1人だけなので待つ必要ありませんね。このまま出発ゲートに向かいましょう」",
	},
	Seq_Game_ExplainNextMission = {
		"AI 「以上が「採掘ミッション」の一通りの流れです」",
		"AI 「このまま「採掘ミッション」を受注してより良い資源を求めて再挑戦も出来ますし、、、」",
		"AI 「ベースキャンプに帰還して元の世界に帰還するためのミッションを継続する（メインストーリーを進める）のも自由です」",
		"AI 「お疲れ様でした」",
	},
}

this.sequenceRadioTable = {
	Seq_Game_ExplainGeneral = "Seq_Game_ExplainGeneral",
	Seq_Game_Tips_General = "Seq_Game_Tips_General",
	Seq_Game_ExplainCraftBoard = "Seq_Game_ExplainCraftBoard",
	Seq_Game_ExplainAcceptMission = "Seq_Game_ExplainAcceptMission",
	Seq_Game_ExplainMatching = "Seq_Game_ExplainMatching",
	Seq_Game_Tips_Matching = "Seq_Game_Tips_Matching",
	Seq_Game_ExplainSortie = "Seq_Game_ExplainSortie",
	Seq_Game_ExplainNextMission = "Seq_Game_ExplainNextMission",
}




this.PlaySequenceRadio = function()
	local radioName = this.sequenceRadioTable[ TppSequence.GetCurrentSequenceName() ]
	if radioName then
		TppRadio.Play( radioName )
	end
end




return this
