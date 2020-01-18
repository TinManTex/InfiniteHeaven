local this={}
--local ff=SplashScreen.Create("ff","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5006_l_alp.ftex",1280,640)  
--SplashScreen.Show(ff,0,0.5,0)--tex panther 
function this.Vector3toTable(n)
  return{n:GetX(),n:GetY(),n:GetZ()}
end
function this.AddVector(e,n)
  return{e[1]+n[1],e[2]+n[2],e[3]+n[3]}
end
local e=180/foxmath.PI
local t=1/e
function this.RadianToDegree(n)
  return n*e
end
function this.DegreeToRadian(n)
  return n*t
end
function this.FindDistance(r,t)
  local n=0
  for e=1,3 do
    n=n+(t[e]-r[e])^2
  end
  return n
end
function this.Clamp(n,min,max)--tex
  return math.min(math.max(n, min), max);
end
function this.ScaleValueClamp1(value,mult)--tex
  local newValue=value*mult
  if newValue < 1 then
    newValue = 1
  end  
  return newValue
end
return this
