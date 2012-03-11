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
--[[
Gets a line of maximum length <width>, returns the line and the next index.
RULES:	Check if we're at the end of the string. DONE
	Check if the end is less than <width> away from <start> DONE
	Check if there is a new line within range. DONE
	Check if there are any spaces in range.
		If none, get <width> characters as the line.
		If some, loop through to get the last space before the limit.
	
--]]
	local limit = width + start - 1
	local pos
	local string
	local nextchar
	if (start >= #str) then --String is at or beyond the end
		--print("At the end of the string.")
		return nil, nil
	end
	if (limit > #str) then --Width is too long for the string.
		--print("Width oversteps the end of the string.")
		limit = #str
	end
	pos, _ = str:find("\n", start)
	if (pos ~= nil) then --there is a new line
		--print("new line detected in string.")
		if (pos <= limit) then --the \n is in range
			--print("new line is within line width")
			string = str:sub(start, pos)
			nextchar = pos + 1
			return string, nextchar
		end
	end
	pos, _ = str:find("%s", start)
	if (pos ~= nil) then --There are spaces
		--print("spaces detected in string.")
		if (pos <= limit) then --The space is in range
			--print("spaces are within line width")
			local curr = pos
			while (true) do
				pos, _ = str:find("%s", curr)
				if (pos ~= nil) then --found another space
					--print("space detected")
					if (pos > limit) then
						--print("space beyond limit")
						string = str:sub(start, curr - 1)
						nextchar = curr
						break
					else
						--print("space within limit")
						curr = pos + 1
					end
				else --there are no more spaces
					--print("no more spaces detected")
					if (limit == #str) then
						string = str:sub(start, limit)
						nextchar = limit + 1
						break
					else
						string = str:sub(start, curr - 1)
						nextchar = curr
						break
					end
				end
			end
		else
			--print("spaces are outside line width")
			string = str:sub(start, limit)
			nextchar = limit + 1
		end
	else --There are no spaces
		string = str:sub(start, limit)
		nextchar = limit + 1
	end
	return string, nextchar
end

function util.splitstringintolines(str, width)
	local temp = {}
	local string
	local nextpos = 1
	local it = 1
	-- GOES INTO INFINITE LOOPS AT BAD TIMES. NEEDS FIXING
	while(true) do
		string, nextpos = util.getlinewithspaces(str, width, nextpos)
		if string == nil then
			break
		end
		--print("In iteration " ..it..", string was: "..string)
		it = it + 1
		table.insert(temp, string)
		string = nil
	end
	--]]
	return temp
end

return util
