local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
function this.CreateInstance(e)
  local instance={}
  instance.radioList={}
  instance.debugRadioLineTable={
    Seq_Game_Ready={"AI「《襲撃ミッション》を開始します」"},
    Seq_Game_Stealth={
      "AI「目標は《敵拠点中心》で《ワームホール採掘機》を起動し、《目標物》を採掘する事です」",
      "AI「敵拠点付近には強力な《妨害電波》が発生しており、私と《ワームホール採掘機》はミッション開始から一定時間しか接続できません」",
      "AI「制限時間を越えると《ワームホール採掘機》が稼動できなくなりますので注意してください」",
      "AI「《妨害電波》の発生源を破壊できれば採掘時間を延ばす事も可能なのですが…」"},
    Seq_Game_DefenseWave={"AI「《ワームホール採掘機》が稼動開始しました」",
      "AI「同時に敵接近を確認、《ワームホール採掘機》を守ってください」"},
    Seq_Game_DefenseBreak={"AI「《ワームホール採掘機》が一時停止しました」",
      "AI「周囲の敵も《ワームホール採掘機》への興味を失ったようです」",
      "AI「この隙に次の《Wave》の準備をしてください」","AI「次の《Wave》では霧の発生している地点から敵が出現してきます」"},
    Seq_Game_Escape={
      "AI「《ワームホール採掘機》との接続が切断されました」","AI「これ以上の採掘は不可能です」","AI「帰還シーケンスを開始します」"},
    expandTimeLimit={
      "AI「《妨害電波》発生源の消滅を確認」","AI「《ワームホール採掘機》の接続可能時間が延長されました」"},
    mineTrap={
      "AI「敵が《ワームホール採掘機》に接近しています」","AI「注意してください」"},
    bossSmell={
      "AI「《ワームホール採掘機》が一時停止しました」",
      "AI「もう一息で採掘は完了します。この調子で終わらせましょう」",
      "AI「…待ってください。今までに無い強力な反応を確認…」",
      "AI「その拠点のボスと判明！そちらに近付いています！」",
      "AI「今のうちに撤退するのも手ですが…判断はお任せします、船長」"},
    bossDefeated={
      "AI「やりました！この拠点のボスを倒しました！」",
      "AI「採掘も完了。もうここには用はありません。」","AI「帰還シーケンスを開始します」"},
    treasureBoxBroken={
      "AI「《採掘ポイント貯蔵箱》が破壊されました」",
      "AI「これ以上の採掘は不可能です」",
      "AI「帰還シーケンスを開始します」"},
    miningMachineBroken={
      "AI「《ワームホール採掘機》が破壊されました」",
      "AI「これ以上の採掘は不可能です」",
      "AI「帰還シーケンスを開始します」"},
    timeUp={
      "AI「制限時間終了、《ワームホール採掘機》との接続が切断されました」",
      "AI「これ以上の採掘は不可能です」",
      "AI「帰還シーケンスを開始します」"},
    baseTrap={
      "AI「敵がこちらの動きに感づいたようです」",
      "AI「採掘を開始すれば拠点内の霧が発生している地点から敵が出現してきます」",
      "AI「採掘開始前に防備を固めておくのがおすすめです」"},
    votingResultEscape={
      "AI「撤退が可決されました」",
      "AI「帰還シーケンスに入ります」"}}
  function instance.OnSequenceStarted()
    local n=TppSequence.GetCurrentSequenceName()
    if instance.debugRadioLineTable[n]then
    end
  end
  function instance.OnGimmickBroken()end
  function instance.OnEnemyEnteredMineTrap()end
  function instance.OnBossSmell()end
  function instance.OnBossDefeated()end
  function instance.OnTreasureBoxBroken()end
  function instance.OnTimeUp()end
  function instance.OnMiningMachineBroken()end
  function instance.OnBaseTrap()end
  function instance.OnVotingResultEscape()end
  return instance
end
return this