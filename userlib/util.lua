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

function util.getlinewithspaces(str, width, start)
	local endpos
	local string = nil
	local curr
	local pos
	local nextstart
	local addnewline = false
	pos, _ = str:find("\n", start)
	if (pos ~= nil) then 
		if (pos - start) < width then 
			string = str:sub(start, curr)
		end
	end
	curr = start
	while (true) do
		pos, _ = str:find("\n", curr)
		if (pos ~= nil) then --a newline exists
			if (pos - start) < width then -- the newline was within
				endpos = pos + 1      -- width
				break
			end
		end
	
		pos, _ = str:find("%s", curr)
		if (pos ~= nil) then --have not reached the end of the string
			if (pos - start) < width then
				curr = pos + 1
			else
				endpos = curr
				addnewline = true
				break
			end
		else --have reached the end of the string
			endpos = str:len() + 1 --misses out the last character
			addnewline = false     --if I didn't +1 it.
			break
		end
	end
	endpos = endpos - 1 --str:find() points too far for str:sub
	string = str:sub(start, endpos)
	if addnewline == true then
		string = string .. "\n"
	end
	nextstart = endpos + 1
	return string, nextstart
end

function util.splitstringintolines(str, width)
	local temp = {}
	local string
	local nextpos = 1

	while(true) do
		string, nextpos = util.getlinewithspaces(str, width, nextpos)
		if string == "" or string == nil then
			break
		end
		table.insert(temp, string)
		string = nil
	end
	return temp
end

return util
