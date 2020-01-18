-- DOBUILD: 1
local this={}
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
function this.FindDistance(pos1,pos2)
  local distSqr=0
  for vecIndex=1,3 do
    distSqr=distSqr+(pos2[vecIndex]-pos1[vecIndex])^2
  end
  return distSqr
end
--tex SYS: mathstuff
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
--tex end SYS: mathstuff
return this
