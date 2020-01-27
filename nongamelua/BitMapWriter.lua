--By Trey Reynolds

--Create new canvas with newcanvas(width,height,blanketred,blanketgreen,blanketblue)
--Canvas pixels are indexed with canvas[y][x], where y is from 1 to height, and x is from 1 to width
--Subpixels are indexed with pixel.r, pixel.g, pixel.b
--1,1 pixel is at the bottom left
--Save to image with canvas:save()
local newcanvas do
	local char		=string.char
	local byte		=string.byte
	local sub		=string.sub
	local rep		=string.rep
	local concat	=table.concat
	local open		=io.open

	local function tobytes(n)
		local r0=n%256
		n=(n-r0)/256
		local r1=n%256
		n=(n-r1)/256
		local r2=n%256
		n=(n-r2)/256
		local r3=n%256
		return char(r0,r1,r2,r3)
	end

	local function save(self,path)
		path=path or self.path
		local h=self.h
		local w=self.w
		local n=1
		local excess=-3*w%4
		local bytes=h*(3*w+excess)
		local lineend=rep('\0',excess)
		local bmp={
			"BM"
			..tobytes(54+bytes)
			.."\0\0\0\0\54\0\0\0\40\0\0\0"
			..tobytes(w)..tobytes(h)
			.."\1\0\24\0\0\0\0\0"
			..tobytes(bytes)
			.."\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
		}
		for i=1,h do
			local row=self[i]
			for j=1,w do
				local pixel=row[j]
				local r=255*pixel.r+0.5
				local g=255*pixel.g+0.5
				local b=255*pixel.b+0.5
				r=r-r%1
				g=g-g%1
				b=b-b%1
				n=n+1
				bmp[n]=char(
					b~=b and 0 or b<0 and 0 or 255<b and 255 or b,
					g~=g and 0 or g<0 and 0 or 255<g and 255 or g,
					r~=r and 0 or r<0 and 0 or 255<r and 255 or r
				)
			end
			n=n+1
			bmp[n]=lineend
		end
		local data=concat(bmp)
		if path then
			local file=open(path,"wb")
			file:write(data)
			file:close()
		end
		return data
	end

	function newcanvas(w,h,r,g,b)
		r=r or 0
		g=g or 0
		b=b or 0
		local newcanvas={
			w=w;
			h=h;
			save=save;
		}
		for i=1,h do
			local row={}
			for j=1,w do
				row[j]={
					r=r;
					g=g;
					b=b;
				}
			end
			newcanvas[i]=row
		end
		return newcanvas
	end
end

return newcanvas