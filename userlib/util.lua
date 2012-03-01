local util = {}

function util.ripairs(t)
	local function ripairs_it(t,i)
		i=i-1
		local v=t[i]
		if v==nil then return v end
		return i,v
	end
	return ripairs_it, t, #t+1
end

function util.addbitmap(path)
	if not game.bitmaps[path] then
		game.bitmaps[path] = love.graphics.newImage(path)
	end
	return game.bitmaps[path]
end

return util
