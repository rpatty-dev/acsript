function script.update(dt)
  for _, car in ipairs(ac.getCars()) do
    local carID = ac.getCarID(car)
    local data = ac.accessCarPhysics(carID)
    data.gas = 1
    data.throttle = 1
  end
end
