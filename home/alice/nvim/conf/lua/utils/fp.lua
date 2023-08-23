local fp = {}

-- just reduce function, the first arg of function can be an iterator, 
-- but it only supports two args return, map and filter are the same.
fp.reduce = function(arrs, fn, init)
  local acc = init
  if type(arrs) == "function" then
    for a, b in arrs do
      acc = fn(acc, a, b)
    end
  else
    for i, e in ipairs(arrs) do
      acc = fn(acc, e, i)
    end
  end
  return acc
end

-- do fn function for each item of an array.
fp.map = function(arrs, fn)
  return fp.reduce(arrs, function(acc, e, i)
      table.insert(acc, fn(e, i) or e)
      return acc
    end, {})
end

-- use fn function(which returns boolean) to control which items to save.
fp.filter = function(arrs, fn)
  return fp.reduce(arrs, function(acc, e, i)
      if fn(e, i) then table.insert(acc, e) end
      return acc
    end, {})
end

return fp
