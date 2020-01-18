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
function this.FindDistance(r,t)
  local n=0
  for e=1,3 do
    n=n+(t[e]-r[e])^2
  end
  return n
end
function this.Clamp(n,min,max)--tex
  return n > max and max or n < min and min or n
end
function this.ScaleValueClamp1(value,mult)--tex
  local newValue=value*mult
  if newValue < 1 then
    newValue = 1
  end  
  return newValue
end
return this
