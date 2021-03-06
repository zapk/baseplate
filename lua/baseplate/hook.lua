-- based on the module by garry newman
-- simplified greatly

hook = {}

local stored = {}

function hook.Add( event, name, func )
  if not isfunction(func) then return end
  if not isstring(event) then return end

  if stored[event] == nil then
    stored[event] = {}
  end

  stored[event][name] = func
end

function hook.Remove( event, name )
  if stored[event] == nil then return end
  if not isstring(event) then return end

  stored[event][name] = nil
end

function hook.Run( event, ... )
  if stored[event] == nil then return end

  for k, v in pairs(stored[event]) do
    local success, result = pcall(v, ...)

    if not success then
      print('Error in "' .. event .. '" hook:')
      con.error(result)
    elseif result then
      -- Override
      return
    end
  end
end
