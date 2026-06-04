local TheValueModule = {}
local TVM = TheValueModule

local UnitNames = {
	"", "K", "M", "B", "T",
	"QA", "QI", "SX", "SP", "OCT", "NO", "DE",
	"UD", "DD", "TD", "QAD", "QID", "SXD", "SPD", "OCD", "NOD",
	"VG", "UVG", "DVG", "TVG", "QAVG", "QIVG",
}

local UnitValues = {}

for i, unit in ipairs(UnitNames) do
	UnitValues[unit] = 10 ^ ((i - 1) * 3)
end

function TVM:GetNumberInStringUnits(number)
	number = tonumber(number)

	if not number then
		return nil
	end

	if number < 1000 then
		return tostring(math.floor(number))
	end

	local unitIndex = math.floor(math.log10(number) / 3)

	if unitIndex > (#UnitNames - 1) then
		unitIndex = #UnitNames - 1
	end

	local suffix = UnitNames[unitIndex + 1]
	local value = 10 ^ (unitIndex * 3)

	local short = number / value

	local formatted

	if short >= 100 then
		formatted = string.format("%.0f", short)
	elseif short >= 10 then
		formatted = string.format("%.1f", short)
	else
		formatted = string.format("%.2f", short)
	end

	formatted = formatted:gsub("%.?0+$", "")

	return formatted .. suffix
end

function TVM:GetStringInNumberUnits(str)
	if typeof(str) ~= "string" then
		return nil
	end

	str = str:gsub("%s+", "")

	local number, suffix = str:match("^([%d%.]+)(%a*)$")

	number = tonumber(number)

	if not number then
		return nil
	end

	suffix = suffix or ""

	local multiplier = UnitValues[suffix]

	if not multiplier then
		return nil
	end

	return number * multiplier
end

function TVM:Parse(value)
	if typeof(value) == "number" then
		local str = TVM:GetNumberInStringUnits(value)
		return str
	elseif typeof(value) == "string" then
		local num = TVM:GetStringInNumberUnits(value)
		return num
	else
		return nil
	end
end

return TVM
