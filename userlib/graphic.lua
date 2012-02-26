local graphic = {}

local template = {
	scale = 1,
	layer1 = nil, --Bottom layer bitmap
	colour1 = {255,255,255,255}, --tinting to the base image
	scale1 = 1,
	layer2 = nil, --middle layer bitmap, big details
	colour2 = {127,127,127,127}, --Player colour details
	scale2 = 1,
	layer3 = nil, --top layer bitmap, minor details
	colour3 = {0,0,0,127} --Miscellaneous identifiers e.g. selected
	scale3 = 1,
	__serialize = function(self)
		
	end,
}
template.__index = template


return graphic
