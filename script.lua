function script.update(dt)
  for _, car in ipairs(ac.getCars()) do
    local carID = nohesi_bmw_m2_f87_comp_kyrex
    local data = ac.accessCarPhysics()
    data.gas = 1
    data.throttle = 1
  end
end
