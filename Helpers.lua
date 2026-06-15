local h = {}
h.__index = h

function h.new(id)
  local self = {}
  setmetatable(self, h)
  self.id = id
  return self
end

function h:Log(...)
  print("[" .. self.id .. " : LOG] " .. ...)
end

function h:Debug(...)
  print("[" .. self.id .. " : DEBUG] " .. ...)
end

function h:Error(...)
  error("[" .. self.id .. " : ERROR] " .. ...)
end

function h:Info(...)
  error("[" .. self.id .. " : INFO] " .. ...)
end

return h
