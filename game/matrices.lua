function create_vector()
  local vector = {}
  vector.x = 0
  vector.y = 0
  return vector
end

function create_vector_pair()
  local vector_pair = {}
  vector_pair.u = create_vector()
  vector_pair.v = create_vector()
  return vector_pair
end
