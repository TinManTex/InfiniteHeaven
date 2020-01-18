local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table








this.radioList = { 
	
	"radio_MissionStart1",
	"radio_MissionStart2",
	"radio_hill",
	"radio_intel",
	"radio_StartFollowing",
	"radio_CheckStation",
	"radio_Mist",
	"radio_BeforeBridge",
	"radio_Follow",
	"radio_AfterRiver",
	"radio_BeforeOP",
	"radio_AfterOp",
	"radio_Follow2",
	"radio_BeforeTunnel",
	"radio_InTunnel",
	"radio_BeforeHumanFactory",
	"radio_AfterBedDemo",
	"radio_InRoom",
	"radio_AfterVolginDemo",
	"radio_GoToLZ",
	"radio_Run",
	"radio_GoToTunnel",
	"radio_BreakTunnel",
	"radio_Heli_Volgin_NORMAL",
	"radio_Damaged_Normal",
	"radio_Damaged_ABSORB",
	"radio_Damaged_FAINT",
	"radio_Damaged_LIGHTNING",
	"radio_Damaged_Rain",
	"radio_MANTIS_DODGED",
	"radio_MANTIS_DAMAGED",
	
	"radio_VolginChangePhase_Sneak",
	"radio_Lake",
	"radio_VolginChangePhase_Aleart",
	"radio_Damaged_Blast",
	"radio_Volgin_NORMAL",
	"radio_HeliLostControl",
	"radio_Volgin_VANISHED",
	"radio_Volgin_VANISHED_FOREVER",
	
	"radio_Heli_Volgin_VANISHED_FOREVER",
	"radio_Heli_Volgin_VANISHED",	
	"Espionage_Lake",
	"Espionage_Lake_Battle",
	"radio_FakeRv",
	"radio_TrueRv",
	"Espionage_Hill",
	"Espionage_DeadBodies",
	"Espionage_Bridge",
	"Espionage_OP",
	"Espionage_Ruins",
	"Espionage_Factory",
	"Espionage_Cliff",
	"Espionage_Radio",
	"Espionage_Target",
	"Espionage_Water_Tower0000",
	"Espionage_Water_Tower0001",
	"Espionage_Water_Tank0000",
	"Espionage_Water_Tank0001",
	"Espionage_Tank0000",
	"Espionage_Stfr0001",
	"Espionage_CorpseBag",
	"Espionage_plh",

	
	"Espionage_Lake_Battle",
	"Espionage_Cliff_Battle",
	"Espionage_Water_Tower0000_Battle",
	"Espionage_Water_Tower0001_Battle",
	"Espionage_Water_Tank0000_Battle",
	"Espionage_Water_Tank0001_Battle",
	"Espionage_Tank0000_Battle",
	"Espionage_Stfr0001_Battle",
	
	"radio_Damaged_Strong",
	"radio_Damaged_Vehicle",
	"radio_Damaged_Sleep",
	"radio_Damaged_Water",	
	"radio_Vehicle",

	
	"info_factory",
	
	"info_photo",
	
	
	
	"s0110_rtrg0010",
	"s0110_rtrg0015",
	"s0110_rtrg0020",
	"s0110_rtrg0030",
	"s0110_rtrg0040",
	"s0110_rtrg0050",
	"s0110_rtrg0060",
	"s0110_rtrg0070",
	"s0110_rtrg0080",
	"s0110_rtrg0090",
	"s0110_rtrg0100",
	"s0110_rtrg0110",
	"s0110_rtrg0120",
	"s0110_rtrg0130",
	"s0110_rtrg0140",
	"s0110_rtrg0150",
	"s0110_rtrg0260",
	"s0110_rtrg0160",
	"s0110_rtrg0170",
	"s0110_rtrg0180",
	"s0110_rtrg0190",
	"s0110_rtrg0200",
	"s0110_rtrg0210",
	"s0110_rtrg0220",
	"s0110_rtrg0230",
	"s0110_rtrg0240",	
	"s0110_rtrg0250",
	"s0110_rtrg0260",
	"s0110_rtrg0270",
	"s0110_rtrg0280",
	"s0110_rtrg0290",
	"s0110_rtrg0300",
	"s0110_rtrg0310",
	"s0110_rtrg0320",
	"s0110_rtrg0330",
	"s0110_rtrg0340",
	"s0110_rtrg0350",
	"f1000_rtrg1880",
	"s0110_rtrg0360",	
	"s0110_rtrg0370",
	"s0110_rtrg0380",
	"s0110_rtrg0390",
	"s0110_rtrg0400",
	
	"f6000_rtrg0220",
	
	"s0110_mirg0010",
	
	"s0110_mprg0010",
	"",
	"",
	"",
	"",
	"",
}

this.debugRadioLineTable = {
	radio_MissionStart1 = {
		"[dbg]ターゲットの少年、シャバニを救出してくれ。",
		"[dbg]シャバニがいると思われるのは、《悪魔の住処（現地語）》と呼ばれる廃施設。詳細は端末を確認してくれ。",
	},
	radio_MissionStart2 = {
		"[dbg]ターゲットの少年、シャバニを救出してくれ。",
		"[dbg]シャバニがいると思われるのは、《悪魔の住処（現地語）》と呼ばれる廃施設。詳細は端末を確認してくれ。",
	},
	radio_hill = {
		"[dbg]hillが見えてきたな。PF兵が拠点にしている場所だ。",
		"[dbg]諜報班によれば、《悪魔の住み処》はその拠点の先にある。",
		"[dbg]なんとか突破できないか？",
	},
	radio_intel = {
		"[dbg]｛情報←インテリジェンス・ファイル｝を入手したな。",
		"[dbg]これで《悪魔の住み処》への経路は判明した。端末を確認してくれ。",
	},
	radio_StartFollowing = {
		"[dbg]あのトラックでどこかへ荷物を運んでいるようだな。",
		"[dbg]待てよ…《悪魔の住み処》はこの拠点(hill)を抜けた先…",
		"[dbg]スネーク、俺たちの目的地へ案内してくれるかもしれんぞ。",
	},
	radio_Mist = {
		"[dbg]霧が出てきたな。",
		"[dbg]このエリアは地形の影響なのか、1年中ほとんど霧で覆われているという。",
		"[dbg]目的地に近付いているぞ。",
	},
	radio_CheckStation = {
		"[dbg]検問か。",
		"[dbg]この警戒ぶり…フェンスの向こうにある《悪魔の住み処》は、よほど重要な施設のようだな。",
		"[dbg]この先はより警備も厳重だろう。注意してくれ。",
	},
	radio_Follow = {
		"[dbg]スネーク、そっちは目的地の方向ではない。",
		"[dbg]引き返してくれ。",
	},
	radio_BeforeBridge = {
		"[dbg]橋が破壊されているな。",
		"[dbg]これでは川沿いに進むしかなさそうだ。",
		"[dbg]一旦下に降りてくれ。",
	},
	radio_BeforeOP = {
		"[dbg]シャバニが連れて行かれたのは、その監視所の先だ。突破しろ。",
	},
	radio_AfterOp = {
		"[dbg]警備拠点（ＯＰ）を突破したな、いいぞ。そのまま道なりに進んでくれ。",
	},
	radio_AfterRiver = {
		"[dbg]スネーク、そっちは目的地の方向ではない。",
		"[dbg]引き返してくれ。",
	},
	radio_Follow2 = {
		"[dbg]スネーク、そっちは目的地の方向ではない。",
		"[dbg]引き返してくれ。",
	},
	radio_BeforeTunnel = {
		"[dbg]スネーク、そのテントの先が目的地だ。",
		"[dbg]よじ登ったり、くぐり抜けられそうな場所が無いか探してみてくれ。",
	},
	radio_InTunnel = {
		"[dbg]かなり古いトンネルだな。内壁が崩れかけている。いつ崩落してもおかしくないだろう。",	
	},
	radio_BeforeHumanFactory =	{
		"[dbg]ボス、目的地に着いたようだな。",
		"[dbg]PFの姿は見当たらないようだが…逆に静かすぎる。",	
		"[dbg]周囲を警戒しつつ、シャバニを捜索してくれ。",
	},
	radio_AfterBedDemo = {
		"[dbg]これはいったい……",
	},
	radio_InRoom = {
		"[dbg]これは一体…何をしてるんだ……。",	
		"[dbg]ボス、シャバニがこの中にいるかもしれん。探すんだ。",
	},
	radio_AfterVolginDemo = {
		"[dbg]ミラー：なんだあの男は？",
		"[dbg]オセロット：逃げろ！奴に捕まれば命はない！！",
		"[dbg]オセロット：まずは、この建物から出るんだ！！",	
		"[dbg]ボス、トンネルの先にヘリを降ろす！そこまで走り抜けるんだ！",	
	},
	radio_Run = {
		"[dbg]逃げろスネーク！",
	},
	radio_GoToTunnel = {
		"[dbg]トンネルを抜ければ、もう少しでLZだ！急げ、ボス！",
	},
	radio_BreakTunnel = {
		"[dbg]くそ！逃げ道を塞がれた！",
		"[dbg]こうなっては、危険だがそのエリアにヘリを降ろすしかない。",
		"[dbg]だが、その前に奴をなんとかしてくれ。",
		"[dbg]降下中のヘリは無防備だ。簡単に撃墜されてしまうだろう。",
		"[dbg]そのエリアに新たにLZを設定した。",
		"[dbg]奴の動きを封じた上で、ヘリを呼ぶんだ。",
	},
	radio_Volgin_VANISHED_FOREVER = {
		"[dbg]よし、ヘリで離脱してくれ。",
	},
	radio_Volgin_VANISHED = {
		"[dbg]よし、ヘリで離脱してくれ。",
	},
	radio_Volgin_NORMAL = {
		"[dbg]くそ、奴は不死身か！？",
	},
	radio_Heli_Volgin_VANISHED = {
		"[dbg]スネーク、いつまた奴が動き出すか分からん。油断するな！",
	},
	radio_Heli_Volgin_NORMAL = {
		"[dbg]了解、ヘリを向かわせる。",
		"[dbg]だが、今のままでは降下中に撃墜されてしまう。",
		"[dbg]ヘリの到着までに奴の動きを封じてくれ。",		
	},
	radio_HeliLostControl = {
		"[dbg]ボス！降下中のヘリは無防備だ。",
		"[dbg]ヘリを呼ぶのは、奴の動きを封じてからにしてくれ。",
	},
	radio_VolginChangePhase_Sneak = {
		"[dbg]奴はアンタを見失っているようだ",
		"[dbg]今のうちに周囲を諜報して、奴の足止めに利用できそうなものを探すんだ",
	},
	radio_VolginChangePhase_Aleart = {
		"[dbg]見つかったか！逃げろスネーク！",
	},
	radio_Lake = {
		"[dbg]その池…",
		"[dbg]そこに奴を突き落とすことができれば…しかしどうやって…",
	},
	radio_Cliff = {
		"[dbg]その先は崖だな",
		"[dbg]この高さ…奴をここから突き落とすことができれば、さすがに簡単には戻って来れないだろうが…",
		"[dbg]しかし一体どうやって…",	
	},
	radio_FakeRv = {
		"[dbg]スネーク、その炎ではヘリが近づけない！そのRVは放棄する！",
		"[dbg]第2RVを設定した、急ぎ向かってくれ！",
	},
	radio_TrueRv = {
		"[dbg]ヘリは到着している！早く乗れ！」",
	},
	
	radio_Vehicle = {
		"[dbg]その車輌、利用できそうか？",
	},
	radio_Damaged_Normal = {
		"[dbg]ボス、病院を思い出せ",	
		"[dbg]奴に銃弾は効かない",	
		"[dbg]足止めするにもショットガンクラスのストッピングパワーが必要だ",
		"[dbg]必要なら、補給を要請してくれ",
	},
	radio_Damaged_Strong = {
		"[dbg]よし、その調子で接近を許すな！",	
	},
	radio_Damaged_Blast = {
		"[dbg]さすがの奴も爆発の衝撃までは防ぎきれなかったか",
		"[dbg]だが、これだけでは一時しのぎにしかならんようだ",
		"[dbg]いったいどうすれば…",
	},
	radio_Damaged_Vehicle = {
		"[dbg]そのまま轢き飛ばしてやれ！",	
	},
	radio_Damaged_Sleep = {
		"[dbg]スネーク！そんな攻撃は通じないぞ！",	
	},
	radio_Damaged_Water = {
		"[dbg]奴の炎が弱まっている！効いてるぞ！",
	},	
	radio_Damaged_ABSORB = {
		"[dbg]ボス、奴は爆発物を吸収しているようだぞ。",	
		"[dbg]一体どうなってるんだ。",	
	},
	radio_Damaged_FAINT = {
		"[dbg]ボス、その武器は足止め程度の効果しかないようだ。",	
		"[dbg]一体どうなってるんだ。",		
	},
	radio_Damaged_LIGHTNING = {
		"[dbg]ボス、やったぞ。",	
		"[dbg]まさか、雷がこんなに効くとは。",
		"[dbg]よし、今のうちにヘリで離脱してくれ。",
	},
	radio_Damaged_Rain = {
		"[dbg]奴が消えた？スネーク、天が味方してくれたようだな。そこから離脱してくれ。",	
	},
	radio_MANTIS_DODGED = {
		"[dbg]ボス、そいつに銃弾は当たらないようだ。",
		"[dbg]なにか方法があるのか…",		
	},
	radio_MANTIS_DAMAGED = {
		"[dbg]なんと、そんな手が…",
		"[dbg]あの少年…たまらず待避したようだな。",	
		"[dbg]やるな、ボス。",
		"[dbg]奴もなぜか止まったままだ。",
		"[dbg]今がチャンスだ。",
		"[dbg]ヘリで離脱してくれ。",		
	},	
	

	Espionage_Hill = {
		"[dbg]《悪魔の住み処》はこの拠点の先だな。",
		"[dbg]この拠点の警備網を突破しないと先に進めそうにないな。",	
	},
	Espionage_DeadBodies = {
		"[dbg]この死体の数…ここで何が行われていたんだ……",
	},
	Espionage_Bridge = {
		"[dbg]人為的に破壊された形跡があるな。",
		"[dbg]ルートを絞り、不審者を見つけやすくしているのだろう。",		
	},
	Espionage_OP = {
		"[dbg]警備拠点か。その先へ誰も入れたくないと見える。突破出来るか？",
	},
	Espionage_Ruins = {
		"[dbg]この建物…すっかり廃れてしまって使われている様子がないな。",
		"[dbg]シャバニはここにはいないだろう。",
	},
	Espionage_Factory = {
		"[dbg]この建物は、外から覗けないようにしてあるようだな。",
		"[dbg]何かを隠そうとしているのか…",
		"[dbg]どこかに入れる場所はないか？",
	},
	Espionage_Radio = {
		"[dbg]ベッドの人間に音声を聞かせているらしい。",
		"[dbg]音による洗脳か…？",	
		"[dbg]しかし、どれも言語がバラバラ、内容も当たり障りの無いもののように聴こえるが…",
	},
	Espionage_Target = {
		"[dbg]あれは…ターゲットか？",
		"[dbg]近くによって確認してくれ。",	
	},
	Espionage_Water_Tower0000 = {
		"[dbg]それは給水塔か",
		"[dbg]昔はあの廃墟に水を供給していたみたいだが…",
	},
	Espionage_Water_Tower0000_Battle = {
		"[dbg]こいつを破壊して中の水を浴びせることができれば、奴の炎を弱めることができるかもしれん。試してみてくれ。",
	},
	Espionage_Water_Tower0001 = {
		"[dbg]それは給水塔か",
		"[dbg]昔はあの廃墟に水を供給していたみたいだが…",
	},
	Espionage_Water_Tower0001_Battle = {
		"[dbg]こいつを破壊して中の水を浴びせることができれば、奴の炎を弱めることができるかもしれん。試してみてくれ。",
	},
	Espionage_Lake = {
		"[dbg]池(いけ)か。",
		"[dbg]水浴びでもするか？その水位じゃ仰向けにでもなるしかないだろうが。",
		"[dbg]シャワーは任務が終わってからだ。",
	},
	Espionage_Lake_Battle = {
		"[dbg]その池(いけ)…",
		"[dbg]そこに奴を突き落とすことができれば…しかしどうやって…",
	},
	Espionage_Cliff = {
		"[dbg]ここから落ちればいくらアンタでも無事じゃ済まないだろう。気を付けてくれよ。",
	},
	Espionage_Cliff_Battle = {
		"[dbg]この高さ…奴をここから突き落とすことができれば、あるいは…",
	},
	Espionage_Water_Tank0000 = {
		"[dbg]こいつを通して水が供給されているらしい。",	
		"[dbg]使われなくなって久しいようだが、まだ中に水が入っているみたいだな。",	
	},
	Espionage_Water_Tank0000_Battle = {
		"[dbg]そいつを破壊して奴に水を浴びせることができれば、やつにダメージを与えられるかもしれん！",	
		"[dbg]うまく誘い出して、試してみてくれ！",	
	},
	Espionage_Water_Tank0001 = {
		"[dbg]こいつを通して水が供給されているらしい。",	
		"[dbg]使われなくなって久しいようだが、まだ中に水が入っているみたいだな。",	
	},
	Espionage_Water_Tank0001_Battle = {
		"[dbg]そいつを破壊して奴に水を浴びせることができれば、やつにダメージを与えられるかもしれん！",	
		"[dbg]うまく誘い出して、試してみてくれ！",
	},
	Espionage_Tank0000 = {
		"[dbg]古いが、まだ中に燃料が入っているかもしれん。",	
		"[dbg]火気を近づけないように注意してくれ。",	
	},
	Espionage_Tank0000_Battle = {
		"[dbg]これだけの大きさのタンク、爆発させればその衝撃も半端では無いはずだ。",	
		"[dbg]こいつの爆発に上手く奴を巻き込めないか？",
	},
	Espionage_Stfr0001 = {
		"[dbg]相当朽ちているな。スネーク、できるだけその下を歩くのは避けた方がいいだろう。"
	},
	Espionage_Stfr0001_Battle = {
		"[dbg]タンクの爆発で強い衝撃を与えてやれば崩れ落ちそうだな。",
		"[dbg]こいつが頭上に降ってくれば、さすがに奴も無傷ってわけにはいかないだろう。",
	},
	Espionage_CorpseBag = {
		"[dbg]それは…死体袋か？"
	},
	Espionage_plh = {
		"[dbg]なんなんだこいつらは……見たところ首にばかり施術痕がみられるが……",
	},
	vol_factory_0000 = {
		"[dbg]ボス、病院で出会った男だ。",
		"[dbg]奴に銃弾は効かない。",
		"[dbg]足止めするにもショットガンクラスのストッピングパワーが必要だぞ。",
	},

	info_factory = {
		"[dbg]状況から推測して、シャバニが連れて行かれた場所は失踪した大人達と同じ、鉱山そばにある旧施設だ。",
		"[dbg]悪魔の住み処（現地語）だといわれ、恐れて誰も近寄らない。",
		"[dbg]1年中霧に覆われている上、現地PFによる厳重な警備下にあり、諜報班も手が出せない。",
		"[dbg]詳細な位置は不明だが、なんとか探し出してくれ。",
	},
	

	info_photo = {
		"[dbg]状況から推測して、シャバニが連れて行かれた場所は失踪した大人達と同じ、鉱山そばにある旧施設だ。",
		"[dbg]悪魔の住み処（現地語）だといわれ、恐れて誰も近寄らない。",
		"[dbg]1年中霧に覆われている上、現地PFによる厳重な警備下にあり、諜報班も手が出せない。",
		"[dbg]詳細な位置は不明だが、なんとか探し出してくれ。",
	},
}




this.optionalRadioList = {
	"Set_s0110_oprg0010",
	"Set_s0110_oprg0020",
	"Set_s0110_oprg0030",
	"Set_s0110_oprg0040",
	"Set_s0110_oprg0050",
	"Set_s0110_oprg0060",
	"Set_s0110_oprg0070",
	"Set_s0110_oprg0080",
	"Set_s0110_oprg0090",
}






this.intelRadioList = {
	Espionage_Hill = "s0110_esrg0010",
	Espionage_DeadBodies = "s0110_esrg0020",
	Espionage_Bridge = "s0110_esrg0040",
	Espionage_OP = "s0110_esrg0050",
	Espionage_Ruins = "s0110_esrg0060",
	Espionage_Factory = "s0110_esrg0070",
	
	Espionage_Target = "s0110_esrg0100",
	
	
	
	
	
	
	
	
	
	Espionage_plh = "s0110_esrg0080",
	
	Vehicle2Locator0000 = "s0110_esrg0030",
}

this.intelRadioListDeadDriver = {
	Espionage_Hill = "s0110_esrg0010",
	Espionage_DeadBodies = "s0110_esrg0020",
	Espionage_Bridge = "s0110_esrg0040",
	Espionage_OP = "s0110_esrg0050",
	Espionage_Ruins = "s0110_esrg0060",
	Espionage_Factory = "s0110_esrg0070",
	Espionage_Target = "s0110_esrg0100",
	Espionage_plh = "s0110_esrg0080",
	Vehicle2Locator0000 = "Invalid",
}

this.intelRadioListSearchTarget = {
	Espionage_Hill = "s0110_esrg0010",
	Espionage_DeadBodies = "s0110_esrg0020",
	Espionage_Bridge = "s0110_esrg0040",
	Espionage_OP = "s0110_esrg0050",
	Espionage_Ruins = "s0110_esrg0060",
	Espionage_Factory = "s0110_esrg0070",
	Espionage_Radio = "s0110_esrg0090",
	Espionage_plh = "s0110_esrg0080",
	Espionage_Target = "s0110_esrg0100",
}


this.intelRadioListEscape = {
	Espionage_Hill = "Invalid",
	Espionage_DeadBodies = "Invalid",
	Espionage_Bridge = "Invalid",
	Espionage_OP = "Invalid",
	Espionage_Ruins = "Invalid",
	Espionage_Factory = "Invalid",
	Espionage_Radio = "Invalid",
	Espionage_Target = "Invalid",
	Espionage_Water_Tower0000 = "Invalid",
	Espionage_Water_Tower0001 = "Invalid",
	Espionage_Lake = "Invalid",
	Espionage_Cliff = "Invalid",
	Espionage_Water_Tank0000 = "Invalid",
	Espionage_Water_Tank0001 = "Invalid",
	Espionage_Tank0000 = "Invalid",
	Espionage_Stfr0001 = "Invalid",
	Espionage_CorpseBag = "Invalid",
	Espionage_plh = "Invalid",
	vol_factory_0000 = "s0110_esrg0110",
	TppMantis2GameObjectLocator = "s0110_esrg0190",
}

this.intelRadioListEscape2 = {
	Espionage_Lake = "s0110_esrg0135",
	Espionage_Cliff = "s0110_esrg0200",
	Espionage_Water_Tower0000 = "s0110_esrg0150",
	Espionage_Water_Tower0001 = "s0110_esrg0150",
	Espionage_Water_Tank0000 = "s0110_esrg0170",
	Espionage_Water_Tank0001 = "s0110_esrg0170",
	Espionage_Tank0000 = "s0110_esrg0140",
	Espionage_Stfr0001 = "s0110_esrg0160",
	vol_factory_0000 = "s0110_esrg0120",
	TppMantis2GameObjectLocator = "s0110_esrg0190",
}





this.blackTelephoneDisplaySetting = {
	f6000_rtrg0220 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_01.ftex", 0.6,"cast_skull_face" }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_03.ftex", 4.5 }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_02.ftex", 4.8, }, 
			{ "hide", "main_1", 8.5 }, 
			{ "hide", "sub_2", 8.8 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_08.ftex", 9.1 }, 
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_05.ftex", 12.8 }, 
			{ "main_5", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_07.ftex", 13.1 }, 
			{ "main_6", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_06.ftex", 17.6 }, 
			{ "main_7", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_09.ftex", 17.9 }, 
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_01.ftex", 0.6,"cast_skull_face" }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_03.ftex", 4.3 }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_02.ftex", 4.6, }, 
			{ "hide", "main_1", 8.6 }, 
			{ "hide", "sub_2", 8.9 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_08.ftex", 9.2 }, 
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_05.ftex", 11.5 }, 
			{ "main_5", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_07.ftex", 11.8 }, 
			{ "main_6", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_06.ftex", 15.7 }, 
			{ "main_7", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10110_09.ftex", 16.0 }, 
		},
	},
}









this.commonRadioTable = {}

this.commonRadioTable[ TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_DEAD ] = TppRadio.IGNORE_COMMON_RADIO









this.PlayMissionStartRadio = function()

	Fox.Log("#### s10110_radio.PlayMissionStartRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" then
		TppRadio.Play( "s0110_rtrg0010" )
	end

end





this.PlayMissionContinueRadio = function()

	Fox.Log("#### s10110_radio.PlayMissionContinueRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" then
		TppRadio.Play( "s0110_rtrg0010" )
	end

end





this.PlayBeforeHillRadio = function()
	if svars.flag8 == false then
		Fox.Log("#### s10110_radio.PlayBeforeHillRadio ####")
		TppRadio.Play( "s0110_rtrg0015" )
		svars.flag8 = true
	else
		Fox.Log("#### s10110_radio.PlayBeforeHillRadio is Finished ####")
	end
end





this.PlayGetIntelRadio = function()

	Fox.Log("#### s10110_radio.PlayGetIntelRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" or TppSequence.GetCurrentSequenceName() == "Seq_Game_SearchTarget" then
		TppRadio.Play( "s0110_rtrg0020" )
	end

end





this.PlayStartFollowingRadio = function()

	Fox.Log("#### s10110_radio. ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" then
		TppRadio.Play( "radio_StartFollowing", { playDebug = true } )
	end

end





this.PlayCheckStationRadio = function()

	Fox.Log("#### s10110_radio.PlayCheckStationRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" and svars.flag9 == false then
		TppRadio.Play( "s0110_rtrg0030" )
		svars.flag9 = true
	else
		Fox.Log("#### s10110_radio.PlayCheckStationRadio is Finished ####")
	end

end





this.PlayMistRadio = function()

	Fox.Log("#### s10110_radio.PlayMistRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" and svars.flag10 == false then
		TppRadio.Play( "s0110_rtrg0040" )
		svars.flag10 = true
	else
		Fox.Log("#### s10110_radio.PlayMistRadio is Finished ####")
	end
end





this.PlayBeforeBridgeRadio = function()

	Fox.Log("#### s10110_radio.PlayBeforeBridgeRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" and svars.flag11 == false then
		TppRadio.Play( "s0110_rtrg0050" )
		svars.flag11 = true
	else
		Fox.Log("#### s10110_radio.PlayBeforeBridgeRadio is Finished ####")
	end
end





this.PlayOppositeRadio = function()

	Fox.Log("#### s10110_radio.PlayOppositeRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" then
		TppRadio.Play( "s0110_rtrg0060" )
	end

end





this.PlayBeforeOpRadio = function()

	Fox.Log("#### s10110_radio.PlayBeforeOpRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" then
		TppRadio.Play( "radio_BeforeOP", { playDebug = true } )
	end

end





this.PlayAfterOpRadio = function()

	Fox.Log("#### s10110_radio.PlayAfterOpRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" then
		TppRadio.Play( "radio_AfterOp", { playDebug = true } )
	end

end





this.PlayAfterRiverRadio = function()

	Fox.Log("#### s10110_radio.PlayAfterRiverRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" then
		TppRadio.Play( "s0110_rtrg0070" )
	end

end





this.PlayOpposite2Radio = function()

	Fox.Log("#### s10110_radio.PlayOpposite2Radio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" then
		TppRadio.Play( "s0110_rtrg0060" )
	end

end




this.PlayBeforeTunnelRadio = function()

	Fox.Log("#### s10110_radio.PlayBeforeTunnelRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" then
		TppRadio.Play( "s0110_rtrg0080" )
	end

end




this.PlayInTunnelRadio = function()

	Fox.Log("#### s10110_radio.PlayInTunnelRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" and svars.flag13 == false then
		TppRadio.Play( "s0110_rtrg0090" )
		svars.flag13 = true
	else
		Fox.Log("#### s10110_radio.PlayInTunnelRadio is Finished ####")
	end
end





this.PlayBeforeHumanFactoryRadio = function()

	Fox.Log("#### s10110_radio.PlayBeforeHumanFactoryRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_GoToFactory" and svars.flag14 == false then
		TppRadio.Play( "s0110_rtrg0100" )
		svars.flag14 = true
	else
		Fox.Log("#### s10110_radio.PlayBeforeHumanFactoryRadio is Finished ####")
	end
end




this.PlayAfterBedDemoRadio = function()

	Fox.Log("#### s10110_radio. ####")
	TppRadio.Play( "s0110_rtrg0110" )
	
end





this.PlayInRoomRadio = function()

	Fox.Log("#### s10110_radio.PlayInRoomRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_SearchTarget" then
		TppRadio.Play( "s0110_rtrg0430", { isEnqueue = true, delayTime = 1.0, priority = "strong" } )
	end
	
end





this.PlayAfterVolginDemoRadio = function()

	Fox.Log("#### s10110_radio.PlayAfterVolginDemoRadio ####")
	TppRadio.Play( "s0110_rtrg0130" )

end





this.PlayGoToLZRadio = function()
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" then
		Fox.Log("#### s10110_radio.PlayGoToLZRadio ####")
		TppRadio.Play( "s0110_rtrg0140" )
	end

end





this.PlayRunRadio = function()
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		Fox.Log("#### s10110_radio.PlayRunRadio ####")
		TppRadio.Play( "s0110_rtrg0260" )
	end

end





this.PlayCounterRadio = function()
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		Fox.Log("#### s10110_radio.PlayCounterRadio ####")
		TppRadio.Play( "s0110_rtrg0250" )
	end

end



















this.PlayBreakTunnelRadio = function()

	Fox.Log("#### s10110_radio.PlayBreakTunnelRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0160" )
	end

end





this.PlayLakeRadio = function()

	Fox.Log("#### s10110_radio.PlayLakeRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0220" )
	end

end





this.PlayCliffRadio = function()

	Fox.Log("#### s10110_radio.PlayCliffRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0230" )
	end

end



















this.PlayHeliLostControlRadio = function()

	Fox.Log("#### s10110_radio.PlayHeliLostControlRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0330" )
	end

end





this.PlayHeliLostControl3Radio = function()

	Fox.Log("#### s10110_radio.PlayHeliLostControl3Radio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0340" )
	end

end





this.PlayVolgin_Vanished_ForeverRadio = function()

	Fox.Log("#### s10110_radio.PlayVolgin_Vanished_ForeverRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0310" )
	end

end



















this.PlayVolgin_NormalRadio = function()

	Fox.Log("#### s10110_radio.PlayVolgin_NormalRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0320" )
	end

end






this.PlayHeli_Volgin_Normal = function()

	Fox.Log("#### s10110_radio.PlayHeli_Volgin_Normal ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0170", { isEnqueue = true, delayTime = 2.0 } )
	end

end


















this.PlayVolginChangePhase_SneakRadio = function()

	Fox.Log("#### s10110_radio.PlayVolginChangePhase_SneakRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0210" )
	end

end





this.PlayVolginChangePhase_AleartRadio = function()

	Fox.Log("#### s10110_radio.PlayVolginChangePhase_AleartRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0240" )
	end

end





this.PlayVolginFultonRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginFultonRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0350" )
	end

end





this.PlayVolginFultonFailedRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginFultonFailedRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0360", { isEnqueue = true, delayTime = 3.0, priority = "strong" } )
	end

end





this.PlayVolginDamaged_NormalRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_NormalRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0180" )
	end

end





this.PlayVolginDamaged_StrongRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_StrongRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0270" )
	end

end





this.PlayVolginDamaged_BlastRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_BlastRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0280" )
	end

end































this.PlayVolginDamaged_WaterRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_WaterRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0310" )
	end

end





this.PlayVolginDamaged_ABSORBRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_ABSORBRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0190" )
	end

end





this.PlayVolginDamaged_FAINTRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_FAINTRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0270" )
	end

end





this.PlayVolginDamaged_LIGHTNINGRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_LIGHTNINGRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0380" )
	end

end




this.PlayVolginDamaged_RainRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_RainRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0370" )
	end

end





this.PlayMANTIS_DODGEDRadio = function()
	Fox.Log("#### s10110_radio.PlayMANTIS_DODGEDRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0390" )
	end

end




this.PlayMANTIS_DAMAGEDRadio = function()
	Fox.Log("#### s10110_radio.PlayMANTIS_DAMAGEDRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0400" )
	end

end





this.PlayVolginDamaged_WATER_GUN_LowRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_WATER_GUN_LowRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0290" )
	end

end





this.PlayVolginDamaged_WATER_GUN_HighRadio = function()
	Fox.Log("#### s10110_radio.PlayVolginDamaged_WATER_GUN_HighRadio ####")
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape" or TppSequence.GetCurrentSequenceName() == "Seq_Game_Escape2" then
		TppRadio.Play( "s0110_rtrg0300" )
	end

end


this.PlayTelephoneRadio = function()
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0220" )
end





this.SetConversation = function( speakerGameObjectId, friendGameObjectId, speechLabel )
        Fox.Log("*** SetConversation ***")
        if Tpp.IsTypeString( speakerGameObjectId ) then
                speakerGameObjectId = GameObject.GetGameObjectId( speakerGameObjectId )
        end
        if Tpp.IsTypeString( friendGameObjectId ) then
                friendGameObjectId = GameObject.GetGameObjectId( friendGameObjectId )
        end
        local command = { id = "CallConversation", label = speechLabel, friend  = speakerGameObjectId, }
        GameObject.SendCommand( friendGameObjectId, command )
end





this.Speech_factorySouth = function( friendenemyId )
	if TppEnemy.GetPhase("mafr_factorySouth_ob") < TppEnemy.PHASE.CAUTION then
		Fox.Log("*** SetConversation_factorySouth ***")
		this.SetConversation( s10110_sequence.TARGET_ENEMY_NAME, friendenemyId, "speech090_EV010")
	else
		Fox.Log("*** NotConversation ***")
	end
end


this.Speech_factory_gate = function( friendenemyId )
	if TppEnemy.GetPhase("mafr_factoryWest_ob") < TppEnemy.PHASE.CAUTION then
		this.SetConversation( s10110_sequence.TARGET_ENEMY_NAME, friendenemyId, "speech090_EV030")
	else
		Fox.Log("*** NotConversation ***")
	end
end


this.Speech_factory_end = function( friendenemyId )
	if TppEnemy.GetPhase("mafr_factoryWest_ob") < TppEnemy.PHASE.CAUTION then
		this.SetConversation( s10110_sequence.TARGET_ENEMY_NAME, friendenemyId, "speech090_EV040")
	else
		Fox.Log("*** NotConversation ***")
	end
end




return this
