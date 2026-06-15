-- Helpers for debugging
_G.Debug = function(...) print("[DEBUG] " .. ...) end

_G.Fatal = function(...) -- NON-RETURNING. WILL HANG SCRIPT
  print("[FATAL] " .. ...)
  while task.wait() do end -- Hang the script
end
