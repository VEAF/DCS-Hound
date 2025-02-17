    --- HOUND.Sector
    -- @module HOUND.Sector
do
    local l_mist = mist
    local l_math = math
    --- HOUND.Sector
    -- @type HOUND.Sector
    -- @within HOUND.Sector
    HOUND.Sector = {}
    HOUND.Sector.__index = HOUND.Sector

    --- Create sectors
    -- @param HoundId Hound Instance ID
    -- @param name Sector name
    -- @param[opt] settings Sector settings table
    -- @param[opt] priority Priority for the sector
    function HOUND.Sector.create(HoundId, name, settings, priority)
        if type(HoundId) ~= "number" or type(name) ~= "string" then
            HOUND.Logger.warn("[Hound] - HOUND.Sector.create() missing params")
            return
        end

        local instance = {}
        setmetatable(instance, HOUND.Sector)
        instance.name = name
        instance._hSettings = HOUND.Config.get(HoundId)
        instance._contacts = HOUND.ContactManager.get(HoundId)
        instance.callsign = "HOUND"
        instance.settings = {
            controller = nil,
            atis = nil,
            notifier = nil,
            transmitter = nil,
            zone = nil,
            hound_menu = nil
        }
        instance.comms = {
            controller = nil,
            atis = nil,
            notifier = nil,
            menu = {
                root = nil , enrolled = {}, check_in = {}, data = {},noData = nil
            }
        }
        instance.priority = priority or 10

        if settings ~= nil and type(settings) == "table" and Length(settings) > 0 then
            instance:updateSettings(settings)
        end
        if instance.name ~= "default" then
            instance:setCallsign(instance._hSettings:getUseNATOCallsigns())
        end
        -- instance:defaultEventHandler()
        return instance
    end

    --- Update sectore settings
    -- @param settings table of settings for internal services
    -- @usage
    --    local sectorSettings = {
    --         atis = {
    --             freq = 123.45
    --         },
    --         controller = {
    --             freq = 234.56
    --         },
    --         notifier = {
    --             freq = 243.00
    --         }
    --     }
    --     sector:updateSettings(sectorSettings)
    --
    function HOUND.Sector:updateSettings(settings)
        for k, v in pairs(settings) do
            local k0 = tostring(k):lower()
            if type(v) == "table" and
                setContainsValue({"controller", "atis", "notifier"}, k0) then
                if not self.settings[k0] then
                    self.settings[k0] = {}
                end
                for k1, v1 in pairs(v) do
                    self.settings[k0][tostring(k1):lower()] = v1
                end
                self.settings[k0]["name"] = self.callsign
            else
                self.settings[k0] = v
            end
        end
        self:updateServices()
    end

    --- Sector "Destructor"
    -- cleans up everyting needed for sector to safly be removed
    -- @return nil is returned
    function HOUND.Sector:destroy()
        self:removeRadioMenu()
        -- self:defaultEventHandler(true)
        for _,contact in pairs(self._contacts:listAll()) do
            contact:removeSector(self.name)
        end
        return
    end

    --- Update internal services with settings stored in the sector.
    function HOUND.Sector:updateServices()
        if type(self.settings.controller) == "table" then
            if not self.comms.controller then
                self.settings.controller.name = self.callsign
                self.comms.controller = HOUND.Comms.Controller:create(self.name,self._hSettings,self.settings.controller)
            else
                self.settings.controller.name = self.callsign
                self.comms.controller:updateSettings(self.settings.controller)
                self.comms.controller:setCallsign(self.callsign)

            end
        end
        if type(self.settings.atis) == "table" then
            if not self.comms.atis then
                self.settings.atis.name = self.callsign
                self.comms.atis = HOUND.Comms.InformationSystem:create(self.name,self._hSettings,self.settings.atis)
            else
                self.settings.atis.name = self.callsign
                self.comms.atis:updateSettings(self.settings.atis)
                self.comms.atis:setCallsign(self.callsign)
            end
        end
        if type(self.settings.notifier) == "table" then
            if not self.comms.notifier then
                self.settings.notifier.name = self.callsign
                self.comms.notifier = HOUND.Comms.Notifier:create(self.name,self._hSettings,self.settings.notifier)
            else
                self.settings.notifier.name = self.callsign
                self.comms.notifier:updateSettings(self.settings.notifier)
                self.comms.notifier:setCallsign(self.callsign)
            end
        end
        if self.settings.zone and type(self.settings.zone) ~= "table" then
            self:setZone(self.settings.zone)
        end
        if self.settings.transmitter then
            self:updateTransmitter()
        end
    end

    --- getters and setters
    -- @section Getters_Setters

    --- get name
    -- @return string name of sector
    function HOUND.Sector:getName()
        return self.name
    end

    --- get priority
    -- @return Int priority of sector
    function HOUND.Sector:getPriority()
        return self.priority
    end

    --- set callsign for sector
    -- @string callsign Requested Callsign
    -- @bool[opt] NATO Use NATO pool for callsignes
    function HOUND.Sector:setCallsign(callsign, NATO)
        local namePool = "GENERIC"
        if callsign ~= nil and type(callsign) == "boolean" then
            NATO = callsign
            callsign = nil
        end
        if NATO == true then namePool = "NATO" end

        callsign = string.upper(callsign or HOUND.Utils.getHoundCallsign(namePool))

        while setContainsValue(self._hSettings.callsigns, callsign) do
            callsign = HOUND.Utils.getHoundCallsign(namePool)
        end

        if self.callsign ~= nil or self.callsign ~= "HOUND" then
            for k, v in ipairs(self._hSettings.callsigns) do
                if v == self.callsign then
                    table.remove(self._hSettings.callsigns, k)
                end
            end
        end
        table.insert(self._hSettings.callsigns, callsign)
        self.callsign = callsign
        self:updateServices()
    end

    --- get callsign for sector
    -- @return string Callsign for current sector
    function HOUND.Sector:getCallsign()
        return self.callsign
    end

    --- get zone polygon
    -- @return table of points or nil
    function HOUND.Sector:getZone()
        return self.settings.zone
    end

    --- has zone
    -- @return Bool. True if sector has zone
    function HOUND.Sector:hasZone()
        return self:getZone() ~= nil
    end

    --- Set zone in sector
    -- @param zonecandidate (String) DCS group name, or a drawn map freeform Polygon. sector borders will be group waypoints or polygon points
    function HOUND.Sector:setZone(zonecandidate)
        if self.name == "default" then
            HOUND.Logger.warn("[Hound] - cannot set zone to default sector")
            return
        end
        if type(zonecandidate) == "string" then
            local zone = HOUND.Utils.Zone.getDrawnZone(zonecandidate)
            if not zone and (Group.getByName(zonecandidate)) then
                zone = mist.getGroupPoints(zonecandidate)
            end
            self.settings.zone = zone
            return
        end
        if not zonecandidate then
            local zone = HOUND.Utils.Zone.getDrawnZone(self.name .. " Sector")
            if zone then
                self.settings.zone = zone
            end
        end
    end

    --- Remove Zone settings from sector
    function HOUND.Sector:removeZone() self.settings.zone = nil end

    --- sets transmitter to sector
    -- @param userTransmitter (String) Name of the Unit that would be transmitting
    function HOUND.Sector:setTransmitter(userTransmitter)
        if not userTransmitter then return end
        self.settings.transmitter = userTransmitter
        self:updateTransmitter()
    end

    --- updates all available comms with transmitter on file
    function HOUND.Sector:updateTransmitter()
        for k, v in pairs(self.comms) do
            if k ~= "menu" and v.setTransmitter then v:setTransmitter(self.settings.transmitter) end
        end
    end

    --- removes transmitter from sector
    function HOUND.Sector:removeTransmitter()
        self.settings.transmitter = nil
        for k, v in pairs(self.comms) do
            if k ~= "menu" then v:removeTransmitter() end
        end
    end

    --- Controller Functions
    -- @section Controller

    --- enable controller
    -- @param[opt] userSettings contoller settings
    function HOUND.Sector:enableController(userSettings)
        if not userSettings then userSettings = {} end
        local settings = { controller = userSettings }
        self:updateSettings(settings)
        self:updateTransmitter()
        self.comms.controller:enable()
        self:populateRadioMenu()
    end

    --- disable controller
    function HOUND.Sector:disableController()
        if self.comms.controller then
            self:removeRadioMenu()
            self.comms.controller:disable()
        end
    end

    --- remove controller completly from sector
    function HOUND.Sector:removeController()
        self.settings.controller = nil
        if self.comms.controller then
            self:disableController()
            self.comms.controller = nil
        end
    end

    --- get controller frequencies
    function HOUND.Sector:getControllerFreq()
        if self.comms.controller then
            return self.comms.controller:getFreqs()
        end
        return {}
    end

    --- checks for controller in sector
    -- @return true if Sector has controller
    function HOUND.Sector:hasController() return self.comms.controller ~= nil end

    --- checks if controller is enabled for the sector
    -- @return true if Sector controller is enabled
    function HOUND.Sector:isControllerEnabled()
        return self.comms.controller ~= nil and self.comms.controller:isEnabled()
    end

    --- Transmit custom TTS message on controller
    -- @param msg string to broadcast
    function HOUND.Sector:transmitOnController(msg)
        if not self.comms.controller or not self.comms.controller:isEnabled() then return end
        if type(msg) ~= "string" then return end
        local msgObj = {priority = 1,coalition = self._hSettings:getCoalition()}
        msgObj.tts = msg
        if self.comms.controller:isEnabled() then
            self.comms.controller:addMessageObj(msgObj)
        end
    end

    --- enable controller text for sector
    function HOUND.Sector:enableText()
        if self.comms.controller then self.comms.controller:enableText() end
        -- if self.comms.notifier then self.comms.notifier:enableText() end
    end

    --- disable controller text for sector
    function HOUND.Sector:disableText()
        if self.comms.controller then self.comms.controller:disableText() end
        -- if self.comms.notifier then self.comms.notifier:disableText() end
    end

    --- enable controller Alerts for sector
    function HOUND.Sector:enableAlerts()
        if self.comms.controller then self.comms.controller:enableAlerts() end
    end

    --- disable controller  for sector
    function HOUND.Sector:disableAlerts()
        if self.comms.controller then self.comms.controller:disableAlerts() end
    end

    --- enable Controller tts for sector
    function HOUND.Sector:enableTTS()
        if self.comms.controller then self.comms.controller:enableTTS() end
    end

    --- disable Controller tts for sector
    function HOUND.Sector:disableTTS()
        if self.comms.controller then self.comms.controller:disableTTS() end
    end

    --- ATIS Functions
    -- @section ATIS

    --- enable ATIS in sector
    -- @param userSettings ATIS settings array
    function HOUND.Sector:enableAtis(userSettings)
        if not userSettings then userSettings = {} end
        local settings = { atis = userSettings }
        self:updateSettings(settings)
        self:updateTransmitter()
        self.comms.atis:SetMsgCallback(HOUND.Sector.generateAtis, self)
        self.comms.atis:enable()
    end

    --- disable ATIS in sector
    function HOUND.Sector:disableAtis()
        if self.comms.atis then self.comms.atis:disable() end
    end

    --- remove ATIS from sector
    function HOUND.Sector:removeAtis()
        self.settings.atis = nil
        if self.comms.atis then
            self:disableAtis()
            self.comms.atis = nil
        end
    end

    --- get ATIS frequencies
    function HOUND.Sector:getAtisFreq()
        if self.comms.atis then
            return self.comms.atis:getFreqs()
        end
        return {}
    end

    --- Set ATIS EWR report state
    -- @bool state True will report EWR
    function HOUND.Sector:reportEWR(state)
        if self.comms.atis then self.comms.atis:reportEWR(state) end
    end

    --- checks for atis in sector
    -- @return true if Sector has atis
    function HOUND.Sector:hasAtis() return self.comms.atis ~= nil end

    --- checks if ats is enabled for the sector
    -- @return true if Sector ats is enabled
    function HOUND.Sector:isAtisEnabled()
        return self.comms.atis ~= nil and self.comms.atis:isEnabled()
    end

    --- Notifier Functions
    -- @section Notifier

    --- enable Notifier in sector
    -- @param[opt] userSettings table of settings for Notifier
    function HOUND.Sector:enableNotifier(userSettings)
        if not userSettings then userSettings = {} end
        local settings = { notifier = userSettings }
        self:updateSettings(settings)
        self:updateTransmitter()
        self.comms.notifier:enable()
    end

    --- disable notifier in sector
    function HOUND.Sector:disableNotifier()
        if self.comms.notifier then self.comms.notifier:disable() end
    end

    --- remove notifier in sector
    -- @return true if Sector has notifier
    function HOUND.Sector:removeNotifier()
        self.settings.notifier = nil
        if self.comms.notifier then
            self:disableNotifier()
            self.comms.notifier = nil
        end
    end

    --- get Notifier frequencies
    function HOUND.Sector:getNotifierFreq()
        if self.comms.notifier then
            return self.comms.notifier:getFreqs()
        end
        return {}
    end

    --- checks sector for notifier
    function HOUND.Sector:hasNotifier()
        return self.comms.notifier ~= nil
    end

    --- checks if ats is enabled for the sector
    -- @return true if Sector ats is enabled
    function HOUND.Sector:isNotifierEnabled()
        return self.comms.notifier ~= nil and self.comms.notifier:isEnabled()
    end

    --- Contact Functions
    -- @section contacs

    --- return a sorted list of all contacts for the sector
    function HOUND.Sector:getContacts()
        local effectiveSectorName = self.name
        if not self:getZone() then
            effectiveSectorName = "default"
        end
        return self._contacts:listAllbyRange(effectiveSectorName)
    end

    --- count the number of contacts for the sector
    function HOUND.Sector:countContacts()
        local effectiveSectorName = self.name
        if not self:getZone() then
            effectiveSectorName = "default"
        end
        return self._contacts:countContacts(effectiveSectorName)
    end

    --- update contact for zone memberships
    -- @param contact HOUND.Contact instance
    function HOUND.Sector:updateSectorMembership(contact)
        local inSector, threatsSector = HOUND.Utils.Polygon.threatOnSector(self.settings.zone,contact:getPos(),contact:getMaxWeaponsRange())
        contact:updateSector(self.name, inSector, threatsSector)
    end

    -------------- Radio Menu stuff -----------------------------

    --- Radio Menu
    -- @section menu

    --- remove all radio menus for
    -- @param self HOUND.Sector
    -- @local
    function HOUND.Sector.removeRadioMenu(self)
        for _,menu in pairs(self.comms.menu.data) do
            if menu ~= nil then
                missionCommands.removeItem(menu)
            end
        end
        for _,menu in pairs(self.comms.menu.check_in) do
            if menu ~= nil then
                missionCommands.removeItem(menu)
            end
        end
        if self.comms.menu.root ~= nil then
            missionCommands.removeItem(self.comms.menu.root)
        end
        self.comms.menu.root = nil
        self.comms.enrolled = {}
        self.comms.menu.data = {}
        self.comms.menu.check_in = {}
    end

    --- find group in enrolled
    -- @param grpId GroupId (int)
    -- @param[opt] playersList list of mist.DB units to find all the group members in
    -- @return list of enrolled players in grp
    -- @local
    function HOUND.Sector:findGrpInPlayerList(grpId,playersList)
        if not playersList or type(playersList) ~= "table" then
            playersList = self.comms.menu.enrolled
        end
        local playersInGrp = {}
        for _,player in pairs(playersList) do
            if player.groupId == grpId then
                table.insert(playersInGrp,player)
            end
        end
        return playersInGrp
    end

    --- get subscribed groups
    -- @return list of groupsId
    -- @local
    function HOUND.Sector:getSubscribedGroups()
        local subscribedGid = {}
        for _,player in pairs(self.comms.menu.enrolled) do
            local grpId = player.groupId
            if not setContainsValue(subscribedGid,grpId) then
                table.insert(subscribedGid,grpId)
            end
        end
        return subscribedGid
    end

    --- clean non existing users from subscribers
    -- @local
    function HOUND.Sector:validateEnrolled()
        if Length(self.comms.menu.enrolled) == 0 then return end
        for _, player in pairs(self.comms.menu.enrolled) do
            local playerUnit = Unit.getByName(player.unitName)
            if not playerUnit or not playerUnit:getPlayerName() then
                self.comms.menu.enrolled[player] = nil
            end
        end
    end

    --- check in player to controller
    -- @local
    -- @param args table {self=&ltHOUND.Sector&gt,player=&ltplayer&gt}
    -- @param[opt] skipAck Bool if true do not reply with ack to player
    function HOUND.Sector.checkIn(args,skipAck)
        local gSelf = args["self"]
        local player = args["player"]
        if not setContains(gSelf.comms.menu.enrolled, player) then
            gSelf.comms.menu.enrolled[player] = player
            -- table.insert(gSelf.comms.menu.enrolled,player)
        end
        for _,otherPlayer in pairs(gSelf:findGrpInPlayerList(player.groupId,l_mist.DBs.humansByName)) do
            gSelf.comms.menu.enrolled[otherPlayer] = otherPlayer
        end
        gSelf:populateRadioMenu()
        if not skipAck then
            gSelf:TransmitCheckInAck(player)
        end
    end

    --- check out player's group from controller
    -- @local
    -- @param args table {self=&ltHOUND.Sector&gt,player=&ltplayer&gt}
    -- @param[opt] skipAck Bool if true do not reply with ack to player
    -- @param[opt] onlyPlayer Bool. if true, only the player and not his flight (eg. slot change for player)
    function HOUND.Sector.checkOut(args,skipAck,onlyPlayer)
        local gSelf = args["self"]
        local player = args["player"]
        gSelf.comms.menu.enrolled[player] = nil

        if not onlyPlayer then
            for _,otherPlayer in pairs(gSelf:findGrpInPlayerList(player.groupId)) do
                gSelf.comms.menu.enrolled[otherPlayer] = nil
            end
        end
        gSelf:populateRadioMenu()
        if not skipAck then
            gSelf:TransmitCheckOutAck(player)
        end
    end

    --- create check menu items for players
    -- @local
    function HOUND.Sector:createCheckIn()
        -- unsubscribe disconnected users
        for _,player in pairs(self.comms.menu.enrolled) do
            local playerUnit = Unit.getByName(player.unitName)
            if playerUnit then
                local humanOccupied = playerUnit:getPlayerName()
                if not humanOccupied then
                    self.comms.menu.enrolled[player] = nil
                end
            end
        end
        -- now do work
        grpMenuDone = {}
        for _,player in pairs(l_mist.DBs.humansByName) do
            local grpId = player.groupId
            local playerUnit = Unit.getByName(player.unitName)
            if playerUnit and not grpMenuDone[grpId] and playerUnit:getCoalition() == self._hSettings:getCoalition() then
                grpMenuDone[grpId] = true

                if not self.comms.menu[player] then
                    self.comms.menu[player] = {
                        check_in = nil,
                        data = nil,
                        noData = nil
                    }
                end

                local grpMenu = self.comms.menu[player]
                if grpMenu.check_in ~= nil then
                    grpMenu.check_in = missionCommands.removeItemForGroup(grpId,grpMenu.check_in)
                end
                if setContains(self.comms.menu.enrolled, player) then
                    grpMenu.check_in =
                        missionCommands.addCommandForGroup(grpId,
                                            self.comms.controller:getCallsign() .. " (" ..
                                            self.comms.controller:getFreq() ..") - Check out",
                                            self.comms.menu.root,HOUND.Sector.checkOut,
                                            {
                                                self = self,
                                                player = player
                                            })
                else
                    grpMenu.check_in =
                        missionCommands.addCommandForGroup(grpId,
                                                        self.comms.controller:getCallsign() ..
                                                            " (" ..
                                                            self.comms.controller:getFreq() ..
                                                            ") - Check In",
                                                            self.comms.menu.root,
                                                        HOUND.Sector.checkIn, {
                            self = self,
                            player = player
                        })
                end
            end
        end

    end

    --- Populate sector radio menu
    function HOUND.Sector:populateRadioMenu()
        if self.comms.menu.root ~= nil then
            self.comms.menu.root =
                missionCommands.removeItemForCoalition(self._hSettings:getCoalition(),self.comms.menu.root)
                self.comms.menu.root = nil
        end

        if not self.comms.controller or not self.comms.controller:isEnabled() then return end
        local contacts = self:getContacts()

        if not self.comms.menu.root then
            self.comms.menu.root =
            missionCommands.addSubMenuForCoalition(self._hSettings:getCoalition(),
                                               self.name,
                                               self._hSettings:getRadioMenu())
        end

        self:createCheckIn()

        if Length(contacts) == 0 then
            if not self.comms.menu.noData then
                self.comms.menu.noData = missionCommands.addCommandForCoalition(self._hSettings:getCoalition(),
                            "No radars are currently tracked",
                            self.comms.menu.root, timer.getAbsTime)
            end
        end

        if Length(contacts) > 0 then
            if self.comms.menu.noData ~= nil then
                missionCommands.removeItemForCoalition(self._hSettings:getCoalition(),
                self.comms.menu.noData)
                self.comms.menu.noData = nil
            end
        end

        local grpMenuDone = {}
        self:validateEnrolled()
        if Length(self.comms.menu.enrolled) > 0 then
            for _, player in pairs(self.comms.menu.enrolled) do
                local grpId = player.groupId
                local grpMenu = self.comms.menu[player]

                if not grpMenuDone[grpId] and grpMenu ~= nil then
                    grpMenuDone[grpId] = true

                    if not grpMenu.data then
                        grpMenu.data = {}
                        grpMenu.data.gid = grpId
                        -- grpMenu.data.callsign = HOUND.Utils.getFormationCallsign(Unit.getByName(player.unitName))
                        grpMenu.data.player = player
                        grpMenu.data.useDMM = HOUND.Utils.isDMM(player.type)
                        grpMenu.data.menus = {}
                    end
                    for _,typeAssigned in pairs(grpMenu.data.menus) do
                        typeAssigned.counter = 0
                        if typeAssigned.root ~= nil then
                            typeAssigned.root = missionCommands.removeItemForGroup(grpId,typeAssigned.root)
                        end
                    end
                    local dataMenu = grpMenu.data
                    for _, contact in ipairs(contacts) do
                        local typeAssigned = contact:getTypeAssigned()
                        if contact.pos.p ~= nil then
                            if not dataMenu.menus[typeAssigned] then
                                dataMenu.menus[typeAssigned] = {}

                                dataMenu.menus[typeAssigned].data = {}
                                dataMenu.menus[typeAssigned].menus = {}
                                dataMenu.menus[typeAssigned].counter = 0
                            end
                            if not dataMenu.menus[typeAssigned].root then
                                dataMenu.menus[typeAssigned].root =
                                missionCommands.addSubMenuForGroup(grpId,typeAssigned,
                                                                    self.comms.menu.root)
                            end

                            self:removeRadarRadioItem(dataMenu,contact)
                            self:addRadarRadioItem(dataMenu,contact)
                        end
                    end
                end
            end
        end
    end

    --- Create radar menu item
    -- @local
    -- @param dataMenu table contaning a menu structure for the group
    -- @param contact HOUND.Contact
    function HOUND.Sector:addRadarRadioItem(dataMenu,contact)
        local assigned = contact:getTypeAssigned()
        local uid = contact.uid
        local menuText = contact:generateRadioItemText()

        dataMenu.menus[assigned].counter = dataMenu.menus[assigned].counter + 1

        if dataMenu.menus[assigned].counter == 1 then
            for k,v in pairs(dataMenu.menus[assigned].menus) do
                dataMenu.menus[assigned].menus[k] = missionCommands.removeItemForGroup(dataMenu.gid,v)
            end
        end

        local submenu = 0
        if dataMenu.menus[assigned].counter > 9 then
            submenu = l_math.floor((dataMenu.menus[assigned].counter+1)/10)
        end
        if submenu == 0 then
            dataMenu.menus[assigned].data[uid] = missionCommands.addCommandForGroup(dataMenu.gid, menuText, dataMenu.menus[assigned].root, self.TransmitSamReport,{self=self,contact=contact,requester=dataMenu.player})
        end
        if submenu > 0 then
            if dataMenu.menus[assigned].menus[submenu] == nil then
                if submenu == 1 then
                    dataMenu.menus[assigned].menus[submenu] = missionCommands.addSubMenuForGroup(dataMenu.gid, "More (Page " .. submenu+1 .. ")", dataMenu.menus[assigned].root)
                else
                    dataMenu.menus[assigned].menus[submenu] = missionCommands.addSubMenuForGroup(dataMenu.gid, "More (Page " .. submenu+1 .. ")", dataMenu.menus[assigned].menus[submenu-1])
                end
            end
            dataMenu.menus[assigned].data[uid] = missionCommands.addCommandForGroup(dataMenu.gid, menuText, dataMenu.menus[assigned].menus[submenu], self.TransmitSamReport,{self=self,contact=contact,requester=dataMenu.player})
        end
    end

    --- remove radar menu items
    -- @local
    -- @param dataMenu table contaning a menu structure for the group
    -- @param contact HOUND.Contact
    function HOUND.Sector:removeRadarRadioItem(dataMenu,contact)
        local assigned = contact:getTypeAssigned()
        local uid = contact.uid
        if not self.comms.controller or not self.comms.controller:isEnabled() or dataMenu.menus[assigned] == nil then
            return
        end

        if setContains(dataMenu.menus[assigned].data,uid) then
            dataMenu.menus[assigned].data[uid] = missionCommands.removeItemForGroup(dataMenu.gid, dataMenu.menus[assigned].data[uid])
        end
    end

    ------------------------- Events -----------------------------------
    --- Event handeling
    -- @section events

    --- create randome annouce
    -- @param[opt] index of requested announce
    -- @return string Announcement
    function HOUND.Sector:getTransmissionAnnounce(index)
        local messages = {
            "Attention All Aircraft! This is " .. self.callsign .. ". ",
            "All Aircraft, " .. self.callsign .. ". ",
            "This is " .. self.callsign .. ". "
        }
        local retIndex = l_math.random(1,#messages)
        if type(index) == "number" then
            retIndex = l_math.max(1,l_math.min(#messages,index))
        end
        return messages[retIndex]
    end

    --- Send dead emitter notification
    -- @param contact HounContact instace
    function HOUND.Sector:notifyDeadEmitter(contact)
        local controller = self.comms.controller
        local notifier = self.comms.notifier
        if not controller and not notifier then return end
        if (not controller or not controller:getSettings("alerts") or not controller:isEnabled()) and (not notifier or not notifier:isEnabled())
             then return end

        local contactPrimarySector = contact:getPrimarySector()
        if self.name ~= "default" and self.name ~= contactPrimarySector then return end

        if self.name == contactPrimarySector then
            contactPrimarySector = nil
        end

        local announce = self:getTransmissionAnnounce()
        local enrolledGid = self:getSubscribedGroups()

        local msg = {coalition =  self._hSettings:getCoalition(), priority = 3, gid=enrolledGid}
        if (controller and controller:getSettings("enableText")) or (notifier and notifier:getSettings("enableText"))  then
            msg.txt = contact:generateDeathReport(false,contactPrimarySector)
        end
        if (controller and controller:getSettings("enableTTS")) or (notifier and notifier:getSettings("enableTTS")) then
            msg.tts = announce .. contact:generateDeathReport(true,contactPrimarySector)
        end
        if controller and controller:isEnabled() and controller:getSettings("alerts") then
            controller:addMessageObj(msg)
        end
        if notifier and notifier:isEnabled() then
            notifier:addMessageObj(msg)
        end
    end

    --- Send new emitter notification
    -- @param contact HounContact instace
    function HOUND.Sector:notifyNewEmitter(contact)
        local controller = self.comms.controller
        local notifier = self.comms.notifier

        if not controller and not notifier then return end
        if (not controller or not controller:isEnabled() or not controller:getSettings("alerts")) and (not notifier or not notifier:isEnabled())
             then return end

        local contactPrimarySector = contact:getPrimarySector()
        if self.name ~= "default" and self.name ~= contactPrimarySector then return end

        if self.name == contactPrimarySector then
            contactPrimarySector = nil
        end

        local announce = self:getTransmissionAnnounce()
        local enrolledGid = self:getSubscribedGroups()

        local msg = {coalition = self._hSettings:getCoalition(), priority = 2 , gid=enrolledGid}
        if (controller and controller:getSettings("enableText")) or (notifier and notifier:getSettings("enableText"))  then
            msg.txt = self.callsign .. " Reports " .. contact:generatePopUpReport(false,contactPrimarySector)
        end
        if (controller and controller:getSettings("enableTTS")) or (notifier and notifier:getSettings("enableTTS")) then
            msg.tts = announce .. contact:generatePopUpReport(true,contactPrimarySector)
        end

        if controller and controller:isEnabled() and controller:getSettings("alerts") then
            controller:addMessageObj(msg)
        end

        if notifier and notifier:isEnabled() then
            notifier:addMessageObj(msg)
        end
    end

    --- Generate Atis message for sector
    -- @local
    -- @param loopData HoundInfomationSystem loop table
    -- @param AtisPreferences HoundInfomationSystem settings table
    function HOUND.Sector:generateAtis(loopData,AtisPreferences)
        local body = ""
        local numberEWR = 0
        local contactCount = self:countContacts()
        if contactCount > 0 then
            local sortedContacts = self:getContacts()

            for _, emitter in pairs(sortedContacts) do
                if emitter.pos.p ~= nil then
                    if not emitter.isEWR or
                        (AtisPreferences.reportewr and emitter.isEWR) then
                        body = body ..
                                    emitter:generateTtsBrief(
                                        self._hSettings:getNATO()) .. " "
                    end
                    if (not AtisPreferences.reportewr and emitter.isEWR) then
                        numberEWR = numberEWR + 1
                    end
                end
            end
            if numberEWR > 0 then
                body = body .. numberEWR .. " EWRs are tracked. "
            end
        end

        if body == "" then
            if self._hSettings:getNATO() then
                body = ". EMPTY. "
            else
                body = "No threats had been detected "
            end
        end

        if loopData.body == body then return end
        loopData.body = body

        local reportId
        reportId, loopData.reportIdx =
            HOUND.Utils.getReportId(loopData.reportIdx)

        local header = self.callsign
        local footer = reportId .. "."

        if self._hSettings:getNATO() then
            header = header .. " Lowdown "
            footer = "Lowdown " .. footer
        else
            header = header .. " SAM information "
            footer = "you have " .. footer
        end
        header = header .. reportId .. " " ..
                                    HOUND.Utils.TTS.getTtsTime() .. ". "

        local msgObj = {
            coalition = self._hSettings:getCoalition(),
            priority = "loop",
            updateTime = timer.getAbsTime(),
            tts = header .. loopData.body .. footer
        }
        loopData.msg = msgObj
    end

    --- transmit SAM report
    -- @local
    -- @param args table {self=&ltHOUND.Sector&gt,contact=&ltHOUND.Contact&gt,requester=&ltplayer&gt}
    function HOUND.Sector.TransmitSamReport(args)
        local gSelf = args["self"]
        local contact = args["contact"]
        local requester = args["requester"]
        local coalitionId = gSelf._hSettings:getCoalition()
        local msgObj = {coalition = coalitionId, priority = 1}
        local useDMM = false
        if contact.isEWR then msgObj.priority = 2 end

        if requester ~= nil then
            msgObj.gid = requester.groupId
            useDMM =  HOUND.Utils.isDMM(requester.type)
        end

        if gSelf.comms.controller:isEnabled() then
            msgObj.tts = contact:generateTtsReport(useDMM)
            if requester ~= nil then
                msgObj.tts = HOUND.Utils.getFormationCallsign(requester) .. ", " .. gSelf.callsign .. ", " ..
                                 msgObj.tts
            end
            if gSelf.comms.controller:getSettings("enableText") == true then
                msgObj.txt = contact:generateTextReport(useDMM)
            end
            gSelf.comms.controller:addMessageObj(msgObj)
        end
    end

    --- transmit checkin message
    -- @local
    -- @param player Player entity
    function HOUND.Sector:TransmitCheckInAck(player)
        if not player then return end
        local msgObj = {priority = 1,coalition = self._hSettings:getCoalition(), gid = player.groupId}
        local msg = HOUND.Utils.getFormationCallsign(player) .. ", " .. self.callsign .. ", Roger. "
        if self:countContacts() > 0 then
            msg = msg .. "Tasking is available."
        else
            msg = msg .. "No known threats."
        end
        msgObj.tts = msg
        msgObj.txt = msg
        if self.comms.controller:isEnabled() then
            self.comms.controller:addMessageObj(msgObj)
        end
    end

    --- transmit checkout message
    -- @local
    -- @param player Player entity
    function HOUND.Sector:TransmitCheckOutAck(player)
        if not player then return end
        local msgObj = {priority = 1,coalition = self._hSettings:getCoalition(), gid = player.groupId}
        local msg = HOUND.Utils.getFormationCallsign(player) .. ", " .. self.callsign .. ", copy checking out. "
        msgObj.tts = msg .. "Frequency change approved."
        msgObj.txt = msg
        if self.comms.controller:isEnabled() then
            self.comms.controller:addMessageObj(msgObj)
        end
    end
end
