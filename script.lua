if ac.getSim().isOnlineRace then
    return nil
end
local sp,distance
local speed
local counter = 0
local flashFlag = false

local flash = ac.LightSource(1)
flash.position = vec3(0,0,0)
--flash.spot = 0
flash.range = 20

trapPosition = {}
trapPosition[1] = vec3(1917.63, -2.80149, -7171.04)
trapPosition[2] = vec3(2532.29, -2.69177, -8246.17)
trapPosition[3] = vec3(713.32, 11.7385, -5752.64)
trapPosition[4] = vec3(2551.67, -2.51895, -8246.81)
trapPosition[5] = vec3(2480.11, 0.433426, -8029.44)
trapPosition[6] = vec3(873.712, 16.2447, -9971.5)
trapPosition[7] = vec3(5453.55, 13.6671, -7131.24)
trapPosition[8] = vec3(-8185.56, 2.06903, 11641.9)
trapPosition[9] = vec3(-118.636, 11.2132, 5245.19)
trapPosition[10] = vec3(111.832, 5.68735, 2074.13)
trapPosition[11] = vec3(-4297.89, 36.0525, -8853.23)

cameraPosition = {}
cameraPosition[1] = vec3(1933.86, 0.0414, -7193.95)
cameraPosition[2] = vec3(2554.15, 1.34, -8276.18)
cameraPosition[3] = vec3(683.74, 15.13, -5753.92)
cameraPosition[4] = vec3(2526.56, 0.514, -8219.57)
cameraPosition[5] = vec3(2483.55, 1.21, -8007)
cameraPosition[6] = vec3(860.78, 20.25, -9957.74)
cameraPosition[7] = vec3(5462.47, 15.98, -7102.14)
cameraPosition[8] = vec3(-8165.45, 4.99, 11629.34)
cameraPosition[9] = vec3(-102.84, 14.17, 5218.71)
cameraPosition[10] = vec3(108.19, 8.74, 2054.81)
cameraPosition[11] = vec3(-4319.42, 38.67, -8857.59)

function update(dt)
    sp = ac.getCar().position
    flashFlag = false
    for i = 1 , #trapPosition do
        cp = trapPosition[i]
        distance = math.sqrt((sp.x - cp.x)^2 + (sp.y - cp.y)^2 + (sp.z - cp.z)^2)
        if distance < 7 then
            flash.position = cameraPosition[i]
            flashFlag = true
        end
    end

    if flashFlag then
        speed = ac.getCarSpeedKmh()
        if speed > 105 then
            counter = counter + dt
            if counter > 0.1 then
                flash.color = rgb(0,0,0)
            elseif counter > 0 then                
                flash.color = rgb(255,0,0)
            end
        end
    else
        flash.color = rgb(0,0,0)
        counter = 0
    end
end

-- speedtrap done

-- overtake start

-- Whole thing is still at very early stage of development, a lot might and possibly
-- will change. Currently whole thing is limited to sort of original drifting mode
-- level. Observe things that happen, draw some extra UI, score user,
-- decide when session ends.

-- This mode in particular is meant for Track Day with AI Flood on large tracks. Set
-- AIs to draw some slow cars, get yourself that Red Bull monstrousity and try to
-- score some points.

-- Key points for future:
-- • Integration with CM’s Quick Drive section, with settings and everything;
-- • These modes might need to be able to force certain CSP parameters — here, for example,
--   it should be AI flood parameters;
-- • To ensure competitiveness, they might also need to collect some data, verify integrity
--   and possibly record short replays?
-- • Remote future: control scene, AIs, spawn extra geometry and so on.

-- Event configuration:
local requiredSpeed = 80


-- This function is called before event activates. Once it returns true, it’ll run:
function script.prepare(dt)
    ac.debug("speed", ac.getCarState(1).speedKmh)
    return ac.getCarState(1).speedKmh > 60
end

-- Event state:
local timePassed = 0
local totalScore = 0
local comboMeter = 1
local comboColor = 0
local highestScore = 0
local dangerouslySlowTimer = 0
local carsState = {}
local wheelsWarningTimeout = 0

function script.update(dt)
    if timePassed == 0 then
        addMessage("Let’s go!", 0)
    end

    local player = ac.getCarState(1)
    if player.engineLifeLeft < 1 then
        if totalScore > highestScore then
            highestScore = math.floor(totalScore)
            ac.sendChatMessage("scored " .. totalScore .. " points.")
        end
        totalScore = 0
        comboMeter = 1
        return
    end

    timePassed = timePassed + dt

    local comboFadingRate = 0.5 * math.lerp(1, 0.1, math.lerpInvSat(player.speedKmh, 80, 200)) + player.wheelsOutside
    comboMeter = math.max(1, comboMeter - dt * comboFadingRate)

    local sim = ac.getSimState()
    while sim.carsCount > #carsState do
        carsState[#carsState + 1] = {}
    end

    if wheelsWarningTimeout > 0 then
        wheelsWarningTimeout = wheelsWarningTimeout - dt
    elseif player.wheelsOutside > 0 then
        if wheelsWarningTimeout == 0 then
        end
        addMessage("Car is outside", -1)
        wheelsWarningTimeout = 60
    end

    if player.speedKmh < requiredSpeed then
        if dangerouslySlowTimer > 3 then
            if totalScore > highestScore then
                highestScore = math.floor(totalScore)
                ac.sendChatMessage("scored " .. totalScore .. " points.")
            end
            totalScore = 0
            comboMeter = 1
        else
            if dangerouslySlowTimer == 0 then
                addMessage("Too slow!", -1)
            end
        end
        dangerouslySlowTimer = dangerouslySlowTimer + dt
        comboMeter = 1
        return
    else
        dangerouslySlowTimer = 0
    end

    for i = 1, ac.getSimState().carsCount do
        local car = ac.getCarState(i)
        local state = carsState[i]

        if car.pos:closerToThan(player.pos, 10) then
            local drivingAlong = math.dot(car.look, player.look) > 0.2
            if not drivingAlong then
                state.drivingAlong = false

                if not state.nearMiss and car.pos:closerToThan(player.pos, 3) then
                    state.nearMiss = true

                    if car.pos:closerToThan(player.pos, 2.5) then
                        comboMeter = comboMeter + 3
                        addMessage("Very close near miss!", 1)
                    else
                        comboMeter = comboMeter + 1
                        addMessage("Near miss: bonus combo", 0)
                    end
                end
            end

            if car.collidedWith == 0 then
                addMessage("Collision", -1)
                state.collided = true

                if totalScore > highestScore then
                    highestScore = math.floor(totalScore)
                    ac.sendChatMessage("scored " .. totalScore .. " points.")
                end
                totalScore = 0
                comboMeter = 1
            end

            if not state.overtaken and not state.collided and state.drivingAlong then
                local posDir = (car.pos - player.pos):normalize()
                local posDot = math.dot(posDir, car.look)
                state.maxPosDot = math.max(state.maxPosDot, posDot)
                if posDot < -0.5 and state.maxPosDot > 0.5 then
                    totalScore = totalScore + math.ceil(10 * comboMeter)
                    comboMeter = comboMeter + 1
                    comboColor = comboColor + 90
                    addMessage("Overtake", comboMeter > 20 and 1 or 0)
                    state.overtaken = true
                end
            end
        else
            state.maxPosDot = -1
            state.overtaken = false
            state.collided = false
            state.drivingAlong = true
            state.nearMiss = false
        end
    end
end

-- For various reasons, this is the most questionable part, some UI. I don’t really like
-- this way though. So, yeah, still thinking about the best way to do it.
local messages = {}
local glitter = {}
local glitterCount = 0

function addMessage(text, mood)
    for i = math.min(#messages + 1, 4), 2, -1 do
        messages[i] = messages[i - 1]
        messages[i].targetPos = i
    end
    messages[1] = {text = text, age = 0, targetPos = 1, currentPos = 1, mood = mood}
    if mood == 1 then
        for i = 1, 60 do
            local dir = vec2(math.random() - 0.5, math.random() - 0.5)
            glitterCount = glitterCount + 1
            glitter[glitterCount] = {
                color = rgbm.new(hsv(math.random() * 360, 1, 1):rgb(), 1),
                pos = vec2(80, 140) + dir * vec2(40, 20),
                velocity = dir:normalize():scale(0.2 + math.random()),
                life = 0.5 + 0.5 * math.random()
            }
        end
    end
end

local function updateMessages(dt)
    comboColor = comboColor + dt * 10 * comboMeter
    if comboColor > 360 then
        comboColor = comboColor - 360
    end
    for i = 1, #messages do
        local m = messages[i]
        m.age = m.age + dt
        m.currentPos = math.applyLag(m.currentPos, m.targetPos, 0.8, dt)
    end
    for i = glitterCount, 1, -1 do
        local g = glitter[i]
        g.pos:add(g.velocity)
        g.velocity.y = g.velocity.y + 0.02
        g.life = g.life - dt
        g.color.mult = math.saturate(g.life * 4)
        if g.life < 0 then
            if i < glitterCount then
                glitter[i] = glitter[glitterCount]
            end
            glitterCount = glitterCount - 1
        end
    end
    if comboMeter > 10 and math.random() > 0.98 then
        for i = 1, math.floor(comboMeter) do
            local dir = vec2(math.random() - 0.5, math.random() - 0.5)
            glitterCount = glitterCount + 1
            glitter[glitterCount] = {
                color = rgbm.new(hsv(math.random() * 360, 1, 1):rgb(), 1),
                pos = vec2(195, 75) + dir * vec2(40, 20),
                velocity = dir:normalize():scale(0.2 + math.random()),
                life = 0.5 + 0.5 * math.random()
            }
        end
    end
end

local speedWarning = 0
    function script.drawUI()
        local uiState = ac.getUiState()
        updateMessages(uiState.dt)

        local speedRelative = math.saturate(math.floor(ac.getCarState(1).speedKmh) / requiredSpeed)
        speedWarning = math.applyLag(speedWarning, speedRelative < 1 and 1 or 0, 0.5, uiState.dt)

        local colorDark = rgbm(0.4, 0.4, 0.4, 1)
        local colorGrey = rgbm(0.7, 0.7, 0.7, 1)
        local colorAccent = rgbm.new(hsv(speedRelative * 120, 1, 1):rgb(), 1)
        local colorCombo =
            rgbm.new(hsv(comboColor, math.saturate(comboMeter / 10), 1):rgb(), math.saturate(comboMeter / 4))

        local function speedMeter(ref)
            ui.drawRectFilled(ref + vec2(0, -4), ref + vec2(180, 5), colorDark, 1)
            ui.drawLine(ref + vec2(0, -4), ref + vec2(0, 4), colorGrey, 1)
            ui.drawLine(ref + vec2(requiredSpeed, -4), ref + vec2(requiredSpeed, 4), colorGrey, 1)

            local speed = math.min(ac.getCarState(1).speedKmh, 180)
            if speed > 1 then
                ui.drawLine(ref + vec2(0, 0), ref + vec2(speed, 0), colorAccent, 4)
            end
        end

        ui.beginTransparentWindow("overtakeScore", vec2(100, 100), vec2(400 * 0.5, 400 * 0.5))
        ui.beginOutline()

        ui.pushStyleVar(ui.StyleVar.Alpha, 1 - speedWarning)
        ui.pushFont(ui.Font.Main)
        ui.text("Highest Score: " .. highestScore .. " pts")
        ui.popFont()
        ui.popStyleVar()

        ui.pushFont(ui.Font.Title)
        ui.text(totalScore .. " pts")
        ui.sameLine(0, 20)
        ui.beginRotation()
        ui.textColored(math.ceil(comboMeter * 10) / 10 .. "x", colorCombo)
        if comboMeter > 20 then
            ui.endRotation(math.sin(comboMeter / 180 * 3141.5) * 3 * math.lerpInvSat(comboMeter, 20, 30) + 90)
        end
        ui.popFont()
        ui.endOutline(rgbm(0, 0, 0, 0.3))

        ui.offsetCursorY(20)
        ui.pushFont(ui.Font.Main)
        local startPos = ui.getCursor()
        for i = 1, #messages do
            local m = messages[i]
            local f = math.saturate(4 - m.currentPos) * math.saturate(8 - m.age)
            ui.setCursor(startPos + vec2(20 * 0.5 + math.saturate(1 - m.age * 10) ^ 2 * 50, (m.currentPos - 1) * 15))
            ui.textColored(
                m.text,
                m.mood == 1 and rgbm(0, 1, 0, f) or m.mood == -1 and rgbm(1, 0, 0, f) or rgbm(1, 1, 1, f)
            )
        end
        for i = 1, glitterCount do
            local g = glitter[i]
            if g ~= nil then
                ui.drawLine(g.pos, g.pos + g.velocity * 4, g.color, 2)
            end
        end
        ui.popFont()
        ui.setCursor(startPos + vec2(0, 4 * 30))

        ui.pushStyleVar(ui.StyleVar.Alpha, speedWarning)
        ui.setCursorY(0)
        ui.pushFont(ui.Font.Main)
        ui.textColored("Keep speed above " .. requiredSpeed .. " km/h:", colorAccent)
        speedMeter(ui.getCursor() + vec2(-9 * 0.5, 4 * 0.2))

        ui.popFont()
        ui.popStyleVar()

        ui.endTransparentWindow()
    end
