local this={}
this.STORY_SEQUENCE={
  [1]="CLEARED_TUTORIAL",
  [3]="CLEARED_k40020",
  [4]="CLEARED_DEFENSE_AREA_1",
  [5]="CLEARED_k40077",
  [6]="CLEARED_k40080",
  [7]="CLEARED_k40130",
  [8]="CLEARED_k40140",
  [9]="CLEARED_k40150",
  [10]="CLEARED_AFGH_LAST",
  [11]="CLEARED_k40170",
  [12]="CLEARED_k40230",
  [14]="CLEARED_s10050",
  [15]="CLEARED_STORY_LAST",
  [20]="CLEARED_k40310"
}
function this.Unlock(E)
  Trophy.TrophyUnlock(E)
end
function this.UnlockByStorySequence()
  local R=TppStory.GetCurrentStorySequence()
  for _,A in pairs(this.STORY_SEQUENCE)do
    if R==TppDefine.STORY_SEQUENCE[A]then
      this.Unlock(_)
    end
  end
end
return this
