local n={}
function n.Vector3toTable(n)
return{n:GetX(),n:GetY(),n:GetZ()}
end
function n.AddVector(e,n)
return{e[1]+n[1],e[2]+n[2],e[3]+n[3]}
end
local e=180/foxmath.PI
local t=1/e
function n.RadianToDegree(n)
return n*e
end
function n.DegreeToRadian(n)
return n*t
end
function n.FindDistance(r,t)
local n=0
for e=1,3 do
n=n+(t[e]-r[e])^2
end
return n
end
return n
