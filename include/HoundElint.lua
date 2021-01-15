-- Hound ELINT system for DCS 
env.info("Hound ELINT Loading...")
-- --------------------------------------
-- Radar Database
do
    HoundSamDB = {
        -- EWR --
        ['p-19 s-125 sr'] = {
            ['Name'] = "Flat Face",
            ['Assigned'] = "SA-2/3",
            ['Role'] = "SR",
        },
        ['1L13 EWR'] = {
            ['Name'] = "EWR",
            ['Assigned'] = "EWR",
            ['Role'] = "EWR",
        },
        ['55G6 EWR'] = {
            ['Name'] = "EWR",
            ['Assigned'] = "EWR",
            ['Role'] = "EWR",
        },
        -- SAM radars --
        ['SNR_75V']  = {
            ['Name'] = "Fan-song",
            ['Assigned'] = "SA-2",
            ['Role'] = "SNR",
        },
        ['snr s-125 tr'] = {
            ['Name'] = "Low Blow",
            ['Assigned'] = "SA-3",
            ['Role'] = "TR",
        },
        ['Kub 1S91 str'] = {
            ['Name'] = "Straight Flush",
            ['Assigned'] = "SA-6",
            ['Role'] = "STR",
        },
        ['Osa 9A33 ln'] = {
            ['Name'] = "Osa",
            ['Assigned'] = "SA-8",
            ['Role'] = "STR",
        },
        ['S-300PS 40B6MD sr'] = {
            ['Name'] = "Tomb Stone",
            ['Assigned'] = "SA-10",
            ['Role'] = "SR",
        },
        ['S-300PS 64H6E sr'] = {
            ['Name'] = "Big Bird",
            ['Assigned'] = "SA-10",
            ['Role'] = "SR",
        },
        ['S-300PS 40B6M tr'] = {
            ['Name'] = "Tomb Stone",
            ['Assigned'] = "SA-10",
            ['Role'] = "TR",
        },

        ['SA-11 Buk SR 9S18M1'] = {
            ['Name'] = "Snow Drift",
            ['Assigned'] = "SA-11",
            ['Role'] = "SR",
        },
        ['SA-11 Buk LN 9A310M1'] = {
            ['Name'] = "SA-11 LN/TR",
            ['Assigned'] = "SA-11",
            ['Role'] = "TR",
        },
        ['Tor 9A331'] = {
            ['Name'] = "Tor",
            ['Assigned'] = "SA-15",
            ['Role'] = "STR",
        },
        ['Strela-1 9P31'] = {
            ['Name'] = "SA-9",
            ['Assigned'] = "SA-9",
            ['Role'] = "TR",
        },
        ['Strela-10M3'] = {
            ['Name'] = "SA-13",
            ['Assigned'] = "SA-13",
            ['Role'] = "TR",
        },
        ['Patriot str'] = {
            ['Name'] = "Patriot",
            ['Assigned'] = "Patriot",
            ['Role'] = "STR",
        },
        ['Hawk sr']  = {
            ['Name'] = "Hawk SR",
            ['Assigned'] = "Hawk",
            ['Role'] = "SR",
        },
        ['Hawk tr'] = {
            ['Name'] = "Hawk TR",
            ['Assigned'] = "Hawk",
            ['Role'] = "TR",
        },
        ['Hawk cwar'] = {
            ['Name'] = "Hawk CWAR",
            ['Assigned'] = "Hawk",
            ['Role'] = "TR",
        },
        ['Roland ADS'] = {
            ['Name'] = "Roland TR",
            ['Assigned'] = "Roland",
            ['Role'] = "TR",
        },
        ['Roland Radar'] = {
            ['Name'] = "Roland SR",
            ['Assigned'] = "Roland",
            ['Role'] = "SR",
        },
        ['Gepard'] = {
            ['Name'] = "Gepard",
            ['Assigned'] = "Gepard",
            ['Role'] = "STR",
        },
        ['rapier_fsa_blindfire_radar'] = {
            ['Name'] = "Rapier",
            ['Assigned'] = "Rapier",
            ['Role'] = "TR",
        },
        ['rapier_fsa_launcher'] = {
            ['Name'] = "Rapier",
            ['Assigned'] = "Rapier",
            ['Role'] = "TR",
        },
        ['2S6 Tunguska'] = {
            ['Name'] = "Tunguska",
            ['Assigned'] = "Tunguska",
            ['Role'] = "STR",
        },
        ['ZSU-23-4 Shilka'] = {
            ['Name'] = "Shilka",
            ['Assigned'] = "Shilka",
            ['Role'] = "TR",
        },
        ['Dog Ear radar']  = {
            ['Name'] = "AAA SR",
            ['Assigned'] = "AAA",
            ['Role'] = "SR",
        },

    }
end

do
    PHONETIC = {
        ["A"] = "Alpha",
        ["B"] = "Bravo",
        ["C"] = "Charlie",
        ["D"] = "Delta",
        ["E"] = "Echo",
        ["F"] = "Foxtrot",
        ["G"] = "Golf",
        ["H"] = "Hotel",
        ["I"] = "India",
        ["J"] = "Juliette",
        ["K"] = "Kilo",
        ["L"] = "Lima",
        ["M"] = "Mike",
        ["N"] = "November",
        ["O"] = "Oscar",
        ["P"] = "Papa",
        ["Q"] = "Quebec",
        ["R"] = "Romeo",
        ["S"] = "Sierra",
        ["T"] = "Tango",
        ["U"] = "Uniform", 
        ["V"] = "Victor",
        ["W"] = "Whiskey",
        ["X"] = "X ray",
        ["Y"] = "Yankee",
        ["Z"] = "Zulu",
        ["1"] = "One",
        ["2"] = "two",
        ["3"] = "three",
        ["4"] = "four",
        ["5"] = "five",
        ["6"] = "six",
        ["7"] = "seven",
        ["8"] = "eight",
        ["9"] = "Niner",
        ["0"] = "zero"
    }
end

do
    PlatformData = {
        [Object.Category.STATIC] = {
            ["Comms tower M"] = {
                precision = 0.25
            }
        },
        [Object.Category.UNIT] = {
            -- Ground Units
            ["MLRS FDDM"] = {
                precision = 0.5
            },
            ["SPK-11"] = {
                precision = 0.5
            },
       -- Helicopters
            ["CH-47D"] = {
                precision = 2.5
            },
            ["CH-53E"] = {
                precision = 2.5
            },
            ["MIL-26"] = {
                precision = 2.5
            },
            ["SH-60B"] = {
                precision = 4.0
            },
            ["UH-60A"] = {
                precision = 4.0
            },
            ["Mi-8MT"] = {
                precision = 4.0
            },
            ["UH-1H"] = {
                precision = 6.0
            },
            ["KA-27"] = {
                precision = 6.0
            },
            -- Airplanes
            ["C-130"] = {
                precision = 1.0
            },
            ["C-17A"] = {
                precision = 1.0
            },
            ["S-3B"] = {
                precision = 1.5
            },
            ["E-3A"] = {
                precision = 2.0
            },
            ["E-2D"] = {
                precision = 2.0
            },
            ["Tu-95MS"] = {
                precision = 1.0
            },
            ["Tu-142"] = {
                precision = 1.0
            },
            ["IL-76MD"] = {
                precision = 1.0
            },
            ["An-30M"] = {
                precision = 1.0
            },
            ["A-50"] = {
                precision = 2.0
            },
            ["An-26B"] = {
                precision = 2.0
            },
            ["Su-25T"] = {
                precision = 2.5
            },
            ["AJS37"] = {
                precision = 2.5
            },
        },
    }

end-- --------------------------------------
function length(T)
    local count = 0
    if T ~= nil then
        for _ in pairs(T) do count = count + 1 end
    end
    return count
  end

function gaussian (mean, variance)
    return  math.sqrt(-2 * variance * math.log(math.random())) *
            math.cos(2 * math.pi * math.random()) + mean
end

function setContains(set, key)
  return set[key] ~= nil
end-- --------------------------------------
do 
    HoundUtils = {}
    HoundUtils.__index = HoundUtils

    HoundUtils.TTS = {}
    HoundUtils.Text = {}
    HoundUtils.ReportId = nil


--[[ 
    ----- TTS Functions ----
--]]    
    function HoundUtils.TTS.Transmit(msg,coalitionID,args)
        if STTS == nil then return end
        if msg == nil then return end
        if coalitionID == nil then return end

        if args.freq == nil then return end
        if args.modulation == nil then args.modulation = "AM" end
        if args.volume == nil then args.volume = "1.0" end
        if args.name == nil then args.name = "Hound" end

        -- STTS.TextToSpeech("Hello DCS WORLD","251","AM","1.0","SRS",2)
        STTS.TextToSpeech(msg,args.freq,args.modulation,args.volume,args.name,coalitionID)
        return true
    end

    function HoundUtils.TTS.getTtsTime(timestamp)
        if timestamp == nil then timestamp = timer.getAbsTime() end
        local DHMS = mist.time.getDHMS(timestamp)
        local hours = DHMS.h
        local minutes = DHMS.m
        local seconds = DHMS.s
        -- env.info(hours..":"..minutes..":"..seconds)
        if hours == 0 then
            hours = PHONETIC["0"]
        else 
            hours = string.format("%02d",hours)
        end

        if minutes == 0 then
            minutes = "hundred"
        else
            minutes = string.format("%02d",minutes)
        end

        return hours .. " " .. minutes .. " Local"
    end

    function HoundUtils.TTS.getVerbalConfidenceLevel(confidenceRadius)
        if confidenceRadius <= 500 then return "Very High" end 
        if confidenceRadius <= 1000 then return "High" end 
        if confidenceRadius <= 2000 then return "Medium" end 
        return "low"
    end

    function HoundUtils.TTS.getVerbalContactAge(timestamp,isSimple)
        local ageSeconds = HoundUtils:timeDelta(timestamp,timer.getAbsTime())

        if isSimple then 
            if ageSeconds < 16 then return "Active" end
            if ageSeconds < 90 then return "very recent" end
            if ageSeconds < 180 then return "recent" end
            if ageSeconds < 300 then return "relevant" end
            return "stale"
        end
        if ageSeconds < 60 then return tostring(math.floor(ageSeconds)) .. " seconds" end
        return tostring(math.floor(ageSeconds/60)) .. " minutes"
    end

    function HoundUtils.TTS.DecToDMS(cood)
        local DMS = HoundUtils.DecToDMS(cood)
        return DMS.d .. " Degrees " .. DMS.m .. " Minutes " .. DMS.s .. " Seconds"
    end

    function HoundUtils.TTS.getVerbalLL(lat,lon)
        local hemi = HoundUtils.getHemispheres(lat,lon,true)
        return HoundUtils.TTS.DecToDMS(lat) .. " " .. hemi.NS .. ", " .. HoundUtils.TTS.DecToDMS(lon) .. " " .. hemi.EW  
    end


    function HoundUtils.TTS.toPhonetic(str) 
        local retval = ""
        str = string.upper(str)
        for i=1, string.len(str) do
            retval = retval .. PHONETIC[string.sub(str, i, i)] .. " "
        end
        return retval:match( "^%s*(.-)%s*$" ) -- return and strip trailing whitespaces
    end

    function HoundUtils.TTS.getReadTime(length)
                -- Assumptions for time calc: 150 Words per min, avarage of 5 letters for english word
        -- so 5 chars = 750 characters per min = 12.5 chars per second
        -- so lengh of msg / 12.5 = number of seconds needed to read it. rounded down to 10 chars per sec
        if type(length) == "string" then
            return math.ceil((string.len(length)/10))
        end
        return math.ceil(length/10)
    end

--[[ 
    ----- Text Functions ----
--]]

    function HoundUtils.Text.getLL(lat,lon)
        local hemi = HoundUtils.getHemispheres(lat,lon)
        local lat = HoundUtils.DecToDMS(lat)
        local lon = HoundUtils.DecToDMS(lon)
        return hemi.NS .. lat.d .. "°" .. lat.m .. "'".. lat.s.."\"" ..  " " ..  hemi.EW  .. lon.d .. "°" .. lon.m .. "'".. lon.s .."\"" 
    end

    function HoundUtils.Text.getTime(timestamp)
        if timestamp == nil then timestamp = timer.getAbsTime() end
        local DHMS = mist.time.getDHMS(timestamp)
        return string.format("%02d",DHMS.h)  .. string.format("%02d",DHMS.m)
    end

--[[ 
    ----- Generic Functions ----
--]]
    function HoundUtils.getControllerResponse()
        local response = {
            "",
            "Good Luck!",
            "Happy Hunting!",
            "Please send my regards.",
            ""
        }
        return response[math.floor(timer.getAbsTime() % length(response))]
    end

    function HoundUtils.getCoalitionString(coalitionID)
        local coalitionStr = "RED"
        if coalitionID == coalition.side.BLUE then
            coalitionStr = "BLUE"
        elseif coalitionID == coalition.side.NEUTRAL then
            coalitionStr = "NEUTRAL"
        end
        -- env.info("getCoalitionString: " .. tostring(coalitionID) .. " output: " .. coalitionStr)
        return coalitionStr
    end

    function HoundUtils.getHemispheres(lat,lon,fullText)
        local hemi = {
            NS = "North",
            EW = "East"
        }
        if lat < 0 then hemi.NS = "South" end
        if lon < 0 then hemi.EW = "West" end
        if fullText == nil or fullText == false then
            hemi.NS = string.sub(hemi.NS, 1, 1)
            hemi.EW = string.sub(hemi.EW, 1, 1)
        end
        return hemi
    end

    function HoundUtils.DecToDMS(cood)
        local deg = math.floor(cood)
        local minutes = math.floor((cood - deg) * 60)
        local sec = math.floor(((cood-deg) * 3600) % 60)
        local dec = (cood-deg) * 60

        return {
            d = deg,
            m = minutes,
            s = sec,
            mDec = dec
        }
    end

    function HoundUtils.TTS.getReportId()
        if HoundUtils.ReportId == nil or HoundUtils.ReportId == string.byte('Z') then
            HoundUtils.ReportId = string.byte('A')
        else
            HoundUtils.ReportId = HoundUtils.ReportId + 1
        end
        return PHONETIC[string.char(HoundUtils.ReportId)]
    end

    function HoundUtils:timeDelta(t0, t1)
        if t1 == nil then t1 = timer.getAbsTime() end
        -- env.info("timestamps are t0: " .. tostring(t0) .. " t1: " .. tostring(t1))
        return t1 - t0
    end

    function HoundUtils.angleDeltaRad(rad1,rad2)
        return math.abs(math.abs(rad1-math.pi)-math.abs(rad2-math.pi))
    end
end-- --------------------------------------
do
    HoundElintDatapoint = {}
    HoundElintDatapoint.__index = HoundElintDatapoint

    function HoundElintDatapoint:New(id0, p0, az0, t0,isPlatformStatic)
        local elintDatapoint = {}
        setmetatable(elintDatapoint, HoundElintDatapoint)
        elintDatapoint.pos = p0
        elintDatapoint.az = az0
        elintDatapoint.t = tonumber(t0)
        elintDatapoint.platformId = id0
        elintDatapoint.platformStatic = isPlatformStatic
        return elintDatapoint
    end
end

do
    HoundContact = {}
    HoundContact.__index = HoundContact

    function HoundContact:New(DCS_Unit,platformCoalition)
        local elintcontact = {}
        setmetatable(elintcontact, HoundContact)
        elintcontact.unit = DCS_Unit
        elintcontact.uid = DCS_Unit:getID()
        elintcontact.DCStypeName = DCS_Unit:getTypeName()
        elintcontact.typeName = DCS_Unit:getTypeName()
        elintcontact.isEWR = false
        elintcontact.typeAssigned = "Unknown" 
        if setContains(HoundSamDB,DCS_Unit:getTypeName())  then
            elintcontact.typeName =  HoundSamDB[DCS_Unit:getTypeName()].Name
            elintcontact.isEWR = (HoundSamDB[DCS_Unit:getTypeName()].Role == "EWR")
            elintcontact.typeAssigned = HoundSamDB[DCS_Unit:getTypeName()].Assigned
        end
         
        elintcontact.pos = {
            p = nil,
            grid = nil,
            LL = {
                lat = nil, 
                lon = nil,
            },
            be = {
                brg = nil,
                rng = nil
            }
        }
        elintcontact.uncertenty_radius = nil
        elintcontact.last_seen = timer.getAbsTime()
        elintcontact.first_seen = timer.getAbsTime()
        elintcontact.dataPoints = {}
        elintcontact.markpointID = -1
        elintcontact.platformCoalition = platformCoalition
        return elintcontact
    end



    function HoundContact:CleanTimedout()
        if HoundUtils:timeDelta(timer.getAbsTime(), self.last_seen) > 900 then
            -- if contact wasn't seen for 15 minuts purge all currnent data
            self.dataPoints = {}
        end
    end

    function HoundContact:isAlive()
        if self.unit:isExist() == false or self.unit:getLife() < 1 then return false end
        return true
    end

    function HoundContact:AddPoint(datapoint)

        self.last_seen = datapoint.t
        if length(self.dataPoints[datapoint.platformId]) == 0 then
            self.dataPoints[datapoint.platformId] = {}
        end

        if datapoint.platformStatic then
            -- if Reciver is static, just keep the last Datapoint, as position never changes.
            -- if There is a datapoint, do rolling avarage on AZ to clean errors out.
            if length(self.dataPoints[datapoint.platformId]) > 0 then
                datapoint.az = (datapoint.az + self.dataPoints[datapoint.platformId][1].az)/2.0
            end
            self.dataPoints[datapoint.platformId] = {datapoint}
            return
        end
        -- local dataArray = self.dataPoints[datapoint.platformId]
        -- Todo data logic
        if length(self.dataPoints[datapoint.platformId]) < 2 then
            table.insert(self.dataPoints[datapoint.platformId], datapoint)
        else
            local LastElementIndex = table.getn(self.dataPoints[datapoint.platformId])
            local DeltaT = HoundUtils:timeDelta(self.dataPoints[datapoint.platformId][LastElementIndex - 1].t, datapoint.t)
            -- env.info("timeDelta is " .. DeltaT)
            if  DeltaT >= 60 then
                table.insert(self.dataPoints[datapoint.platformId], datapoint)
            else
                self.dataPoints[datapoint.platformId][LastElementIndex] = datapoint
            end
            if table.getn(self.dataPoints[datapoint.platformId]) > 11 then
                table.remove(self.dataPoints[datapoint.platformId], 1)
            end
        end
        -- self.dataPoints[datapoint.platformId] = dataArray
        -- env.info("finished with " .. length(self.dataPoints[datapoint.platformId]) .. " elements from ".. datapoint.platformId)
    end

    function HoundContact:triangulatePoints(earlyPoint, latePoint)
        local p1 = earlyPoint.pos
        local p2 = latePoint.pos

        local m1 = math.tan(earlyPoint.az)
        local m2 = math.tan(latePoint.az)

        local b1 = -m1 * p1.x + p1.z
        local b2 = -m2 * p2.x + p2.z

        local Easting = (b2 - b1) / (m1 - m2)
        local Northing = m1 * Easting + b1

        local pos = {}
        pos.x = Easting
        pos.z = Northing
        pos.y = land.getHeight({pos.x,pos.z})

        return pos
    end

    function HoundContact:calculateAzimuthBias(dataPoints)
        -- env.info("HoundContact:calculateAzimuthBias() - start")

        local biasVector = nil
        for i=1, length(dataPoints) do
            local V = {}
            V.x = math.cos(dataPoints[i].az)
            V.z = math.sin(dataPoints[i].az)
            V.y = 0
            -- table.insert(vectors,V)
            if biasVector == nil then biasVector = V else biasVector = mist.vec.add(biasVector,V) end
        end
        -- env.info("avg theta :" .. bias .. "(".. mist.utils.toDegree(bias) .. ")")
        local pi_2 = 2*math.pi
        -- env.info("HoundContact:calculateAzimuthBias() - end")

        return  (math.atan2(biasVector.z/length(dataPoints), biasVector.x/length(dataPoints))+pi_2) % pi_2
    end

    function HoundContact:calculateEllipse(estimatedPositions,Theta)
        table.sort(estimatedPositions,function(a,b) return tonumber(mist.utils.get2DDist(self.pos.p,a)) < tonumber(mist.utils.get2DDist(self.pos.p,b)) end)

        local percentile = math.floor(length(estimatedPositions)*0.95)
        local RelativeToPos = {}
        for i = 1, percentile do
            table.insert(RelativeToPos,mist.vec.sub(estimatedPositions[i],self.pos.p))
        end
        -- env.info("Theta: ".. Theta .. "|" .. mist.utils.toDegree(Theta))
        local sinTheta = math.sin(Theta)
        local cosTheta = math.cos(Theta)

        for k,v in ipairs(RelativeToPos) do
            -- env.info("offset dist: " .. mist.utils.get2DDist({x=0,y=0,z=0},v))
            local newPos = {}
            newPos.y = v.y
            newPos.x = v.x*cosTheta - v.z*sinTheta
            newPos.z = v.x*sinTheta + v.z*cosTheta
            RelativeToPos[k] = newPos
            -- env.info("calculatePos - rotate "..k .. "id "..v.x .. "=>" .. newPos.x .. "/"..v.z.."=>"..newPos.z)
        end

        local min = {}
        min.x = 99999
        min.y = 99999

        local max = {}
        max.x = -99999
        max.y = -99999

        for k,v in ipairs(RelativeToPos) do
            -- env.info("offsets: minx" .. min.x .. " miny "..min.y .. " maxx " .. max.x.. " maxy "..max.y)
            min.x = math.min(min.x,v.x)
            max.x = math.max(max.x,v.x)
            min.y = math.min(min.y,v.z)
            max.y = math.max(max.y,v.z)
        end

        local x = mist.utils.round(math.abs(min.x)+math.abs(max.x))
        local y = mist.utils.round(math.abs(min.y)+math.abs(max.y))
        self.uncertenty_radius = {}
        self.uncertenty_radius.major = math.max(x,y)
        self.uncertenty_radius.minor = math.min(x,y)
        self.uncertenty_radius.az = mist.utils.round(mist.utils.toDegree(Theta))
        self.uncertenty_radius.r  = (x+y)/4
        
        -- env.info("ellipse size is :".. self.uncertenty_radius.major .. "/" .. self.uncertenty_radius.minor .. " Az: ".. self.uncertenty_radius.az)
        -- env.info("HoundContact:calculateEllipse() - end")

    end

    function HoundContact:calculatePos(estimatedPositions)
        -- env.info("HoundContact:calculatePos() - start")
        if estimatedPositions == nil then return end
        self.pos.p =  mist.getAvgPoint(estimatedPositions)
        local bullsPos = coalition.getMainRefPoint(self.platformCoalition)
        self.pos.LL.lat, self.pos.LL.lon =  coord.LOtoLL(self.pos.p)
        -- env.info("LL: " ..self.pos.LL.lat .. " " .. self.pos.LL.lat)
        self.pos.grid  = coord.LLtoMGRS(self.pos.LL.lat, self.pos.LL.lon)
        -- env.info(self.pos.grid.UTMZone .. " " .. self.pos.grid.MGRSDigraph )
        self.pos.be.brg = mist.utils.round(mist.utils.toDegree(mist.utils.getDir(mist.vec.sub(self.pos.p,bullsPos))))
        self.pos.be.rng =  mist.utils.round(mist.utils.metersToNM(mist.utils.get2DDist(self.pos.p,bullsPos)))
        -- env.info("HoundContact:calculatePos() - end")

    end

    function HoundContact:removeMarker()
        if self.markpointID ~= nil then
            trigger.action.removeMark(self.markpointID)
        end
    end
    function HoundContact:updateMarker(coalitionID)
        if self.pos.p == nil or self.uncertenty_radius == nil then return end
        self:removeMarker()
        local marker = world.getMarkPanels()
        if length(marker) > 0 then 
            marker = (marker[#marker].idx + 1)
        else 
            marker = 1
        end
        self.markpointID = marker
        trigger.action.markToCoalition(self.markpointID, self.typeName .. " " .. (self.uid%100) .. " (" .. self.uncertenty_radius.major .. "/" .. self.uncertenty_radius.minor .. "@" .. self.uncertenty_radius.az .. "|" .. HoundUtils:timeDelta(self.last_seen) .. "s)",self.pos.p,self.platformCoalition,true)
    end

    function HoundContact:positionDebug()
        if self.pos.p == nil then return end
        env.info("location of " ..self.typeName .. " is " .. self.pos.p.x .. " " ..  self.pos.p.z)
    end


    function HoundContact:getTextData(utmZone,wideGrid)
        if self.pos.p == nil then return end
        local GridPos = ""
        if utmZone then
            GridPos = GridPos .. self.pos.grid.UTMZone .. " " 
        end
        GridPos = GridPos .. self.pos.grid.MGRSDigraph
        local BE = string.format("%03d",self.pos.be.brg) .. " for " .. self.pos.be.rng
        if wideGrid then
            return GridPos,BE
        end
        local E = self.pos.grid.Easting
        local N = self.pos.grid.Northing
        while E >= 10 do
            E = math.floor(E/10)
        end
        while N >= 10 do
            N = math.floor(N/10)
        end
        GridPos = GridPos .. E .. N
        
        return GridPos,BE
    end

    function HoundContact:getTtsData(utmZone,wideGrid)
        if self.pos.p == nil then return end
        local phoneticGridPos = ""
        if utmZone then
            phoneticGridPos =  phoneticGridPos .. HoundUtils.TTS.toPhonetic(self.pos.grid.UTMZone) .. " "
        end

        phoneticGridPos =  phoneticGridPos ..  HoundUtils.TTS.toPhonetic(self.pos.grid.MGRSDigraph)
        local phoneticBulls = HoundUtils.TTS.toPhonetic(string.format("%03d",self.pos.be.brg)) 
                                .. " for " .. self.pos.be.rng
        if wideGrid then
            return phoneticGridPos,phoneticBulls
        end
        local E = self.pos.grid.Easting
        local N = self.pos.grid.Northing
        while E >= 10 do
            E = math.floor(E/10)
        end
        while N >= 10 do
            N = math.floor(N/10)
        end
            phoneticGridPos = phoneticGridPos .. " " .. HoundUtils.TTS.toPhonetic(E) .. " " .. HoundUtils.TTS.toPhonetic(N)

        return phoneticGridPos,phoneticBulls
    end

    function HoundContact:generateTtsBrief()
        if self.pos.p == nil or self.uncertenty_radius == nil then return end
        local phoneticGridPos,phoneticBulls = self:getTtsData()
        local str = self.typeName .. " " .. (self.uid % 100) .. ", " .. HoundUtils.TTS.getVerbalContactAge(self.last_seen,true)
        str = str .. " at " .. phoneticGridPos -- .. ", bullz " .. phoneticBulls 
        str = str .. ", accuracy " .. HoundUtils.TTS.getVerbalConfidenceLevel( self.uncertenty_radius.r ) .. "."
        return str
    end

    function HoundContact:generateTtsReport()
        if self.pos.p == nil then return end
        local phoneticGridPos,phoneticBulls = self:getTtsData(true)
        local msg =  self.typeName .. " " .. (self.uid % 100) ..", bullz " .. phoneticBulls .. ", grid ".. phoneticGridPos
        msg = msg .. ", position " .. HoundUtils.TTS.getVerbalLL(self.pos.LL.lat,self.pos.LL.lon)
        msg = msg .. ", Ellipse " ..  self.uncertenty_radius.major .. " by " ..  self.uncertenty_radius.minor .. " aligned bearing " .. HoundUtils.TTS.toPhonetic(string.format("%03d",self.uncertenty_radius.az))
        msg = msg .. ", first seen " .. HoundUtils.TTS.getTtsTime(self.first_seen) .. ", last seen " .. HoundUtils.TTS.getVerbalContactAge(self.last_seen) .. " ago. " .. HoundUtils:getControllerResponse()
        return msg
    end

    function HoundContact:generateTextReport()
        if self.pos.p == nil then return end
        local GridPos,BePos = self:getTextData(true)
        local msg =  self.typeName .. " " .. (self.uid % 100) .."\n"
        msg = msg .. "BE: " .. BePos .. " (grid ".. GridPos ..")\n"
        msg = msg .. "LL: " .. HoundUtils.Text.getLL(self.pos.LL.lat,self.pos.LL.lon).."\n"
        msg = msg .. "Ellipse: " ..  self.uncertenty_radius.major .. " by " ..  self.uncertenty_radius.minor .. " aligned bearing " .. string.format("%03d",self.uncertenty_radius.az) .. "\n"
        msg = msg .. "First detected " .. HoundUtils.Text.getTime(self.first_seen) .. " Last Contact: " ..  HoundUtils.TTS.getVerbalContactAge(self.last_seen) .. " ago. " .. HoundUtils:getControllerResponse()
        return msg
    end

    function HoundContact:generateRadioItemText()
        if self.pos.p == nil then return end
        local GridPos,BePos = self:getTextData(true)
        BePos = BePos:gsub(" for ","/")
        return self.typeName .. " (" .. (self.uid % 100) ..") - BE: " .. BePos .. " (".. GridPos ..")"
    end 


    function HoundContact:generatePopUpReport(isTTS)
        local msg = "BREAK, BREAK! New threat detected! "
        msg = msg .. self.typeName .. " " .. (self.uid % 100)
        local GridPos,BePos 
        if isTTS then
            GridPos,BePos = self:getTtsData(true)
            msg = msg .. ", bullz " .. BePos .. ", grid ".. GridPos
        else
            GridPos,BePos = self:getTextData(true)
            msg = msg .. " BE: " .. BePos .. " (grid ".. GridPos ..")"
        end
        msg = msg .. " is now Alive!"
        return msg
    end

    function HoundContact:generateDeathReport(isTTS)
        local msg = self.typeName .. " " .. (self.uid % 100)
        local GridPos,BePos 
        if isTTS then
            GridPos,BePos = self:getTtsData(true)
            msg = msg .. ", bullz " .. BePos .. ", grid ".. GridPos
        else
            GridPos,BePos = self:getTextData(true)
            msg = msg .. " BE: " .. BePos .. " (grid ".. GridPos ..")"
        end
        msg = msg .. " has been destroyed!"
        return msg
    end

    function HoundContact:transmitReport(tts)
        local msg =self:generateTtsReport()
        if msg == nil then return end
        HoundUtils.TTS.Transmit(msg,self.platformCoalition,tts)
    end
    function HoundContact:NewThreatAlert()
        if STTS ~= nil then

        end

    end

    function HoundContact:processData()
        -- env.info("HoundContact:processData() - start")
        local newContact = (self.pos.p == nil)
        local mobileDataPoints = {}
        local staticDataPoints = {}
        for k,v in pairs(self.dataPoints) do 
            if length(v) > 0 then
                for k,v in pairs(v) do 
                    if v.isReciverStatic then
                        table.insert(staticDataPoints,v) 
                    else
                        table.insert(mobileDataPoints,v) 
                    end
                end
            end
        end
        local numMobilepoints = length(mobileDataPoints)
        local numStaticPoints = length(staticDataPoints)

        if numMobilepoints+numStaticPoints < 2 then return end
        -- TODO: main process logic
        -- exteral trigger. manage points triangulation, position calculations and output
        local estimatePosition = {}
        -- env.info("contact has " .. numMobilepoints .. " datapoints")
        -- self.dataPoints[centerIndex]:resetRange()
        
        -- Static against all statics
        if numStaticPoints > 1 then
            for i=1,numStaticPoints-1 do
                for j=i+1,numStaticPoints do
                    table.insert(estimatePosition,self:triangulatePoints(staticDataPoints[i],staticDataPoints[j]))
                end
            end
        end

        -- Statics against all mobiles
        if numStaticPoints > 0  and numMobilepoints > 0 then
            for i,staticDataPoint in ipairs(staticDataPoints) do
                for j,mobileDataPoint in ipairs(mobileDataPoints) do
                    if math.deg(HoundUtils.angleDeltaRad(staticDataPoint.az,mobileDataPoint.az)) > 0.75 then
                        table.insert(estimatePosition,self:triangulatePoints(staticDataPoint,mobileDataPoint))
                    end
                end
            end
         end

        -- mobiles agains mobiles
        if numMobilepoints > 1 then
            for i=1,numMobilepoints-1 do
                for j=i+1,numMobilepoints do
                    if math.deg(HoundUtils.angleDeltaRad(mobileDataPoints[i].az,mobileDataPoints[j].az)) > 0.75 then
                        table.insert(estimatePosition,self:triangulatePoints(mobileDataPoints[i],mobileDataPoints[j]))
                    end
                end
            end
        end
        
        if length(estimatePosition) > 1 then
            self:calculatePos(estimatePosition)
            local combinedDataPoints = {} 
            if numMobilepoints > 0 then
                for k,v in ipairs(mobileDataPoints) do table.insert(combinedDataPoints,v) end
            end
            if numStaticPoints > 0 then
                for k,v in ipairs(staticDataPoints) do table.insert(combinedDataPoints,v) end
            end
            self:calculateEllipse(estimatePosition,self:calculateAzimuthBias(combinedDataPoints))
        end

        if newContact and self.pos.p ~= nil and self.isEWR == false then
            return true
        end
    end
end-- -------------------------------------------------------------
do
    HoundElint = {}
    HoundElint.__index = HoundElint

    function HoundElint:create(platformName)
        local elint = {}
        setmetatable(elint, HoundElint)
        elint.platform = {}
        elint.emitters = {}
        elint.elintTaskID = nil
        elint.radioMenu = {}
        elint.radioAdminMenu = nil
        elint.coalitionId = nil
        elint.addPositionError = false
        elint.positionErrorRadius = 30
        elint.settings = {
            mainInterval = 15,
            processInterval = 60,
            barkInterval = 120
        }
        elint.controller = {
            enable = false,
            textEnable = false,
            freq = 250.000,
            modulation = "AM",
            volume = "1.0",
            name = "Hound_Controller",
            alerts = true
        }
        elint.atis = {
            enable = false,
            taskId = nil,
            interval = 55,
            freq = 250.500,
            modulation = "AM",
            name = "Hound_ATIS",
            body = "",
            header = "",
            footer = "",
            msg = "",
            msgTimeSec = 0,
            reportEWR = false
        }
        if platformName ~= nil then
            elint:addPlatform(platformName)
        end
        return elint
    end

    function HoundElint:addPlatform(platformName)

        local canidate = Unit.getByName(platformName)
        if canidate == nil then
            canidate = StaticObject.getByName(platformName)
        end

        if self.coalitionId == nil and canidate ~= nil then
            self.coalitionId = canidate:getCoalition()
        end

        if canidate ~= nil and canidate:getCoalition() == self.coalitionId then
            local mainCategoty = canidate:getCategory()
            local type = canidate:getTypeName()
    
            if setContains(PlatformData,mainCategoty) then
                if setContains(PlatformData[mainCategoty],type) then
                    for k,v in pairs(self.platform) do
                        if v == canidate then
                            return
                        end
                    end
                    table.insert(self.platform, canidate)
                end
            end
        end
    end

    function HoundElint:removePlatform(platformName)
        local canidate = Unit.getByName(platformName)
        if canidate == nil then
            canidate = StaticObject.getByName(platformName)
        end

        if canidate ~= nil then
            for k,v in ipairs(self.platform) do
                if v == canidate then
                    table.remove(self.platform, k)
                    return
                end
            end
        end
    end

    function HoundElint:platformRefresh()
        if length(self.platform) < 1 then return end
        local toRemove = {}
        for i = length(self.platform), 1,-1 do
            if self.platform[i]:isExist() == false or self.platform[i]:getLife() <
                1 then  table.remove(self.platform, i) end
        end
    end

    function HoundElint:removeDeadPlatforms()
        if length(self.platform) < 1 then return end
        for i=table.getn(self.platform),1,-1  do
            if self.platform[i]:isExist() == false or self.platform[i]:getLife() < 1 or (self.platform[i]:getCategory() ~= Object.Category.STATIC and self.platform[i]:isActive() == false) then
                table.remove(self.platform,i)
            end
        end
    end


    function HoundElint:configureController(args)
        -- STTS.TextToSpeech("Hello DCS WORLD","251","AM","1.0","SRS",2)
        for k,v in pairs(args) do self.controller[k] = v end

        if (self.controller.freq ~= nil and STTS ~= nil) then
            self.controller.enable = true
        end
    end

    function HoundElint:configureAtis(args)
        for k,v in pairs(args) do self.atis[k] = v end
    end

    function HoundElint:toggleController(state,textMode)
        if ( STTS ~= nil ) then
            self.controller.enable = state
            return
        end
        self.controller.enable = false
     end

     function HoundElint:toggleControllerText(state)
        self.controller.textEnable = state
     end

     function HoundElint:enableController(textMode)
        self:toggleController(true)
        if textMode then
            self:toggleControllerText(true)
        end
        self:addRadioMenu()
    end

    function HoundElint:disableController(textMode)
        self:toggleController(false)
        if textMode then
            self:toggleControllerText(true)
        end
        self:removeRadioMenu()

    end


    function HoundElint:toggleATIS(state) 
        if ( STTS ~= nil ) then
            self.atis.enable = state
            return
        end
        self.atis.enable = false
    end

    function HoundElint:enableATIS()
        self:toggleATIS(true)
        -- self.atis.taskId = mist.scheduleFunction(self.TransmitATIS,{self}, 5, self.atis.interval)
        self.atis.taskId = timer.scheduleFunction(self.TransmitATIS,self, timer.getTime() + 15)
    end

    function HoundElint:disableATIS()
        self:toggleATIS(false)
        if self.atis.taskId ~= nil then
            timer.removeFunction(self.atis.taskId)
        end
    end

    function HoundElint:generateATIS()        
        local body = ""
        local numberEWR = 0

        if length(self.emitters) > 0 then
            for uid, emitter in pairs(self.emitters) do
                if emitter.pos.p ~= nil then
                    if emitter.isEWR == false or (self.atis.reportEWR and emitter.isEWR) then
                    body = body .. emitter:generateTtsBrief() .. " "
                    end
                    if (self.atis.reportEWR == false and emitter.isEWR) then
                        numberEWR = numberEWR+1
                    end
                end
            end
        end
        if body == "" then body = "No threats had been detected " end
        if numberEWR > 0 then body = body .. ",  " .. numberEWR .. " EWRs are tracked. " end
        if body == self.atis.body then return end
        self.atis.body = body

        local reportId = HoundUtils.TTS.getReportId()
        self.atis.header = "SAM information " .. reportId .. " " ..
                               HoundUtils.TTS.getTtsTime() .. ". "
        self.atis.footer = "you have information " .. reportId .. "."
        self.atis.msg = self.atis.header .. self.atis.body .. self.atis.footer
        self.atis.msgTimeSec = HoundUtils.TTS.getReadTime(string.len(self.atis.msg))
        -- env.info("estimates: " .. self.atis.msgTimeSec .. " seconds for lenght of ".. string.len(self.atis.msg))

    end

    function HoundElint.TransmitATIS(self)
        if self.atis.enable then
            self:generateATIS()
            HoundUtils.TTS.Transmit(self.atis.msg,self.coalitionId,self.atis)

        end
        self.atis.taskId = timer.scheduleFunction(self.TransmitATIS,self, timer.getTime() + self.atis.msgTimeSec + 5)
    end

    function HoundElint.TransmitSamReport(args)
        -- local self = args["self"]
        -- local emitter = args["emitter"]
        local coalitionId = args["self"].coalitionId
        if args["self"].controller.enable then
        HoundUtils.TTS.Transmit(args["emitter"]:generateTtsReport(),coalitionId,args["self"].controller)
        end
        if args["self"].controller.textEnable == true then
            trigger.action.outTextForCoalition(coalitionId,args["emitter"]:generateTextReport(),30)
        end
    end

    function HoundElint:notifyDeadEmitter(emitter)
        if self.controller.alerts == false then return end
        if self.controller.textEnable then
            trigger.action.outTextForCoalition(self.coalitionId,emitter:generateDeathReport(false),30)
        end
        if self.controller.enable then
            HoundUtils.TTS.Transmit(emitter:generateDeathReport(true),self.coalitionId,self.controller)
        end
    end

    function HoundElint.transmitPopUpReport(args)
        if length(args) < 2 then return end
        local msg = args[1]
        local self = args[2]
        HoundUtils.TTS.Transmit(msg,self.coalitionId,self.controller)
    end

    function HoundElint:notifyNewEmitter(emitter,msgTime)
        if self.controller.alerts == false then return end
        if self.controller.textEnable then
            trigger.action.outTextForCoalition(self.coalitionId,emitter:generatePopUpReport(false),30)
        end
        if self.controller.enable then
            local msg = emitter:generatePopUpReport(true)
            timer.scheduleFunction(HoundElint.transmitPopUpReport,{msg,self}, msgTime)
            msgTime = msgTime + HoundUtils.TTS.getReadTime(string.len(msg)) + 0.5
        end
        return msgTime
    end

    function HoundElint:getSensorError(platform)
        local mainCategoty = platform:getCategory()
        local type = platform:getTypeName()

        if setContains(PlatformData,mainCategoty) then
            if setContains(PlatformData[mainCategoty],type) then
                return PlatformData[mainCategoty][type].precision
            end
        end
        return 15.0
    end

    function HoundElint:getAzimuth(src, dst, sensorError)
        local dirRad = mist.utils.getDir(mist.vec.sub(dst, src))
        local randomError = gaussian(0, sensorError * 50) / 100
        -- env.info("sensor is: ".. sensorError .. "passing in " .. sensorError*500 / 1000 .. " Error: " .. randomError )
        local AzDeg = mist.utils.round((math.deg(dirRad) + randomError + 360) % 360, 3)
        -- env.info("az: " .. math.deg(dirRad) .. " err: "..  randomError .. " final: " ..AzDeg)
        return math.rad(AzDeg)
    end

    function HoundElint:getActiveRadars()
        local Radars = {}

        -- start logic
        for coalitionId,coalitionName in pairs(coalition.side) do
            if coalitionName ~= self.coalitionId then
                -- env.info("starting coalition ".. coalitionName)
                for cid,CategoryId in pairs({Group.Category.GROUND,Group.Category.SHIP}) do
                    -- env.info("starting categoty ".. CategoryId)
                    for gid, group in pairs(coalition.getGroups(coalitionName, CategoryId)) do
                        -- env.info("starting group ".. group:getName())
                        for uid, unit in pairs(group:getUnits()) do
                            -- env.info("looking at ".. unit:getName())
                            if (unit:isExist() and unit:isActive() and unit:getRadar()) then
                                table.insert(Radars, unit:getName()) -- insert the name
                            end
                        end
                    end
                end

            end
        end
        return Radars
    end



    function HoundElint:Sniff()
        local Recivers = {}
        self:removeDeadPlatforms()

        if length(self.platform) == 0 then
            env.info("no active platform")
            return
        end

        local Radars = self:getActiveRadars()

        if length(Radars) == 0 then
            env.info("No Transmitting Radars")
            return
        end
        env.info("Recivers: " .. table.getn(self.platform) .. " | Radars: " .. table.getn(Radars))

        for i,RadarName in ipairs(Radars) do
            local radar = Unit.getByName(RadarName)
            local RadarUid = radar:getID()
            local RadarType = radar:getTypeName()
            local RadarName = radar:getName()
            local radarPos = radar:getPosition().p
            radarPos.y = radarPos.y + 20 -- assume 10 meters radar antenna
            -- env.info("looking at " .. RadarName )
            -- env.info(length(self.platform) .. " type " .. type(self.platform))
            for j,platform in ipairs(self.platform) do
                local platformPos = platform:getPosition().p
                local platformId = platform:getID()
                local platformIsStatic = false

                if platform:getCategory() == Object.Category.STATIC then
                    platformIsStatic = true
                    platformPos.y = platformPos.y + 60
                else
                    local PlatformUnitCategory = platform:getDesc()["category"]
                    if (self.addPositionError and ( PlatformUnitCategory == Unit.Category.HELICOPTER or PlatformUnitCategory == Unit.Category.AIRPLANE)) then
                        platformPos = mist.getRandPointInCircle( platform:getPosition().p, self.positionErrorRadius)
                    end
                    if PlatformUnitCategory == Unit.Category.GROUND_UNIT then
                        platformPos.y = platformPos.y + 15 
                    end
                end

                if land.isVisible(platformPos, radarPos) then
                    if (self.emitters[RadarUid] == nil) then
                        self.emitters[RadarUid] =
                            HoundContact:New(radar, self.coalitionId)
                    end
                    local az = self:getAzimuth(platformPos, radarPos, self:getSensorError(platform))
                    -- env.info(platform:getName() .. "-->".. RadarName .. " Az: " .. az )
                    local datapoint = HoundElintDatapoint:New(platformId,platformPos, az, timer.getAbsTime(),platformIsStatic)
                    self.emitters[RadarUid]:AddPoint(datapoint)
                end
            end
        end
        -- env.info("end Sniff()")
    end

    function HoundElint:Process()
        local msgTimer = timer.getTime() + 0.2
        for uid, emitter in pairs(self.emitters) do
            if emitter ~= nil then
                local isNew = emitter:processData()
                if isNew then
                    msgTimer = self:notifyNewEmitter(emitter,msgTimer)
                end
                emitter:CleanTimedout()
                if emitter:isAlive() == false and HoundUtils:timeDelta(emitter.last_seen, timer.getAbsTime()) > 60 then
                    self:notifyDeadEmitter(emitter)
                    emitter:removeMarker()
                    self.emitters[uid] = nil
                    self:removeRadioItem(self.radioMenu.data[emitter.typeAssigned].data[uid])
                else
                    if HoundUtils:timeDelta(emitter.last_seen,
                                            timer.getAbsTime()) > 1800 then
                        self.emitters[uid] = nil
                        self:removeRadioItem(self.radioMenu.data[emitter.typeAssigned].data[uid])
                    end
                end
            end
        end
    end

    function HoundElint:Bark()
        for uid, emitter in pairs(self.emitters) do
            -- env.info("updating marker for " .. emitter.unit:getName())
            emitter:updateMarker(self.coalitionId)
        end
    end

    function HoundElint.runCycle(self)
        if self.coalitionId == nil then return end
        if self.platform then self:platformRefresh() end
        -- env.info("platforms: " .. length(self.platform) )
        if length(self.platform) > 0 then
            -- env.info("sniff")
            self:Sniff()
        end
        if length(self.emitters) > 0 then
            if timer.getAbsTime() % math.floor(gaussian(self.settings.processInterval,3)) < self.settings.mainInterval+5 then 
                self:Process() 
                self:populateRadioMenu()
            end
            if timer.getAbsTime() % math.floor(gaussian(self.settings.barkInterval,7)) < self.settings.mainInterval+5 then
                self:Bark()
            end
        end
    end

    function HoundElint.updatePlatformState(params)
        local option = params.option
        local self = params.self
        if option == 'platformOn' then
            self:platformOn()
        elseif option == 'platformOff' then
            self:platformOff()
        end
    end

    function HoundElint:platformOn()
        env.info("Hound is now on")

        self:platformOff()

        self.elintTaskID = mist.scheduleFunction(self.runCycle, {self}, 1, self.settings.mainInterval)
       
        trigger.action.outTextForCoalition(self.coalitionId,
                                           "Hound ELINT system is now Operating", 10)
    end

    function HoundElint:platformOff()
        env.info("Hound is now off")
        if self.elintTaskID ~= nil then
            mist.removeFunction(self.elintTaskID)
        end
        
        trigger.action.outTextForCoalition(self.coalitionId,
                                           "Hound ELINT system is now Offline",
                                           10)
    end

    -- TODO: Remove Menu when emitter dies:
    function HoundElint:addAdminRadioMenu()
        env.info("addAdminRadioMenu")
        self.radioAdminMenu = missionCommands.addSubMenuForCoalition(
                                  self.coalitionId, 'ELINT managment')
        missionCommands.addCommandForCoalition(self.coalitionId, 'Activate',
                                               self.radioAdminMenu,
                                               HoundElint.updatePlatformState, {
            self = self,
            option = 'platformOn'
        })
        missionCommands.addCommandForCoalition(self.coalitionId, 'DeActivate',
                                               self.radioAdminMenu,
                                               HoundElint.updatePlatformState, {
            self = self,
            option = 'platformOff'
        })
    end

    function HoundElint:removeAdminRadioMenu()
        missionCommands.removeItem(self.radioAdminMenu)
    end

    function HoundElint:addRadioMenu()
        self.radioMenu.root = missionCommands.addSubMenuForCoalition(
                                  self.coalitionId, 'ELINT Intel')
        self.radioMenu.data = {}
        self.radioMenu.noData = missionCommands.addCommandForCoalition(self.coalitionId,
                                                   "No radars are currently tracked",
                                                   self.radioMenu.root, timer.getAbsTime)

    end

    function HoundElint:populateRadioMenu()
        if self.radioMenu.root == nil or length(self.emitters) == 0 then
            return
        end
        local sortedContacts = {}

        for uid,emitter in pairs(self.emitters) do
            table.insert(sortedContacts,emitter)
        end

        table.sort(sortedContacts, function(a, b) 
            if a.typeAssigned ~= b.typeAssigned then
                return a.typeAssigned < b.typeAssigned
            end
            if a.typeName ~= b.typeName then
                return a.typeName < b.typeName
            end
            if a.first_seen ~= b.first_seen then
                return a.first_seen > b.first_seen
            end
            return a.uid < b.uid 
        end)

        if length(sortedContacts) == 0 then return end
        for k,t in pairs(self.radioMenu.data) do
            if k ~= "placeholder" then
                t.counter = 0
            end
        end
        for id, emitter in ipairs(sortedContacts) do
            local DCStypeName = emitter.DCStypeName
            local assigned = emitter.typeAssigned
            local uid = emitter.uid
            if emitter.pos.p ~= nil then
                if length(self.radioMenu.data[assigned]) == 0 then
                    -- env.info("create " .. assigned)
                    self.radioMenu.data[assigned] = {}
                    self.radioMenu.data[assigned].root =
                        missionCommands.addSubMenuForCoalition(self.coalitionId,
                                                               assigned, self.radioMenu.root)
                    self.radioMenu.data[assigned].data = {}
                    self.radioMenu.data[assigned].menus = {}
                    self.radioMenu.data[assigned].counter = 0
                end

                self:removeRadarRadioItem(emitter)
                self:addRadarRadioItem(emitter)
            end
        end
    end


    function HoundElint:addRadarRadioItem(emitter)
        local DCStypeName = emitter.DCStypeName
        local assigned = emitter.typeAssigned
        local uid = emitter.uid
        local text = emitter:generateRadioItemText()

        self.radioMenu.data[assigned].counter = self.radioMenu.data[assigned].counter + 1

        if self.radioMenu.data[assigned].counter == 1 then
            for k,v in pairs(self.radioMenu.data[assigned].menus) do
                self.radioMenu.data[assigned].menus[k] = missionCommands.removeItemForCoalition(self.coalitionId,v)
            end
        end

        if self.radioMenu.noData ~= nil then
            self.radioMenu.noData = missionCommands.removeItemForCoalition(self.coalitionId, self.radioMenu.noData)
        end

        
        local submenu = 0
        if self.radioMenu.data[assigned].counter > 9 then
            submenu = math.floor((self.radioMenu.data[assigned].counter+1)/10)
        end
        if submenu == 0 then
            self.radioMenu.data[assigned].data[uid] = missionCommands.addCommandForCoalition(self.coalitionId, emitter:generateRadioItemText(), self.radioMenu.data[assigned].root, self.TransmitSamReport,{self=self,emitter=emitter})
        end
        if submenu > 0 then
            if self.radioMenu.data[assigned].menus[submenu] == nil then
                if submenu == 1 then
                    self.radioMenu.data[assigned].menus[submenu] = missionCommands.addSubMenuForCoalition(self.coalitionId, "More (Page " .. submenu+1 .. ")", self.radioMenu.data[assigned].root)
                else
                    self.radioMenu.data[assigned].menus[submenu] = missionCommands.addSubMenuForCoalition(self.coalitionId, "More (Page " .. submenu+1 .. ")", self.radioMenu.data[assigned].menus[submenu-1])
                end
            end
            self.radioMenu.data[assigned].data[uid] = missionCommands.addCommandForCoalition(self.coalitionId, emitter:generateRadioItemText(), self.radioMenu.data[assigned].menus[submenu], self.TransmitSamReport,{self=self,emitter=emitter})
        end

    end

    function HoundElint:removeRadarRadioItem(emitter)
        local DCStypeName = emitter.DCStypeName
        local assigned = emitter.typeAssigned
        local uid = emitter.uid
        -- env.info(length(emitter) .. " uid: " .. uid .. " DCStypeName: " .. DCStypeName)

        if setContains(self.radioMenu.data[assigned].data,uid) then
            self.radioMenu.data[assigned].data[uid] = missionCommands.removeItemForCoalition(self.coalitionId, self.radioMenu.data[assigned].data[uid])
        end
    end


    function HoundElint:removeRadioMenu()
        missionCommands.removeItemForCoalition(self.coalitionId,
                                               self.radioMenu.root)
        self.radioMenu = {}
    end
end
env.info("Hound ELINT Loaded Successfully")
-- Build date 16-01-2021