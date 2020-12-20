--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sire Denathrius", 2296, 2424)
if not mod then return end
mod:RegisterEnableMob(167406) -- Sire Denathrius
mod.engageId = 2407
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1
mod.stage = stage
local intermission = nil
local nextStageWarning = 73
local burdenPlayerTracker = {}
local burdenStackTable = {}
local burdenStacksOnMe = 0
local cleansingPainCount = 1
local bloodPriceCount = 1
local nightHunterCount = 1
local ravageCount = 1
local impaleCount = 1
local wrackingPainCount = 1
local handCount = 1
local massacreCount = 1
local shatteringPainCount = 1
local fatalFinesseCount = 1
local addCount = 1

local timers = { -- Heroic confirmed
	[1] = {
		-- Night Hunter
		[327796] = {12, 26, 30, 28, 30, 28},
		-- Cleansing Pain
		[326707] = {5.5, 21.3, 31.5, 22, 29.8, 22.6},
	},
	[2] = {
		-- Crimson Cabalist // First ones are up from the start
		[-22131] = {4, 85, 55},
		-- Impale
		[329951] = {23, 26.0, 27.0, 23.0, 32.0, 18.0, 39.0, 35.0},
		 -- Hand of Destruction (P2)
		[333932] = {41.2, 40.3, 39.0, 56.1, 18.5, 57.2},
	},
	[3] = {
		-- Fatal Finesse
		[332794] = {18, 48, 6, 21, 27, 19, 26, 21},
		-- Hand of Destruction (P3)
		[333932] = {27.7, 90.0, 31.6, 46.3},
	}
}
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.add_spawn = "Crimson Cabalists answer the call of Denathrius." -- [RAID_BOSS_EMOTE] Crimson Cabalists answer the call of Denathrius.#Sire Denathrius#4#true"

	L.infobox_stacks = "%d |4Stack:Stacks;: %d |4player:players;" -- 4 Stacks: 5 players // 1 Stack: 1 player
end

--------------------------------------------------------------------------------
-- Initialization
--

local nightHunterMarker = mod:AddMarkerOption(false, "player", 1, 327796, 1, 2, 3) -- Night Hunter
local impaleMarker = mod:AddMarkerOption(false, "player", 1, 329951, 1, 2, 3) -- Impale
local fatalFinesseMarker = mod:AddMarkerOption(false, "player", 1, 332794, 1, 2, 3) -- Fatal Finesse
function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Sinners Be Cleansed
		{328936, "TANK"}, -- Inevitable
		{326699, "INFOBOX"}, -- Burden of Sin
		326707, -- Cleansing Pain
		326851, -- Blood Price
		{327796, "SAY", "SAY_COUNTDOWN"}, -- Night Hunter
		nightHunterMarker,
		327122, -- Ravage
		327992, -- Desolation
		-- Intermission: March of the Penitent
		328276, -- March of the Penitent
		329906, -- Carnage
		{329951, "SAY", "SAY_COUNTDOWN"}, -- Impale
		-22131, -- Crimson Cabalist
		impaleMarker,
		335873, -- Rancor
		329181, -- Wracking Pain
		333932, -- Hand of Destruction
		330068, -- Massacre
		-- Stage Three: Indignation
		{332585, "TANK"}, -- Scorn
		332619, -- Shattering Pain
		{332794, "SAY", "SAY_COUNTDOWN"}, -- Fatal Finesse
		fatalFinesseMarker,
		336008, -- Smoldering Ire
		332849, -- Reflection: Ravage
		333980, -- Reflection: Massacre
	},{
		["stages"] = "general",
		[328936] = -22016, -- Stage One: Sinners Be Cleansed
		[328276] = -22098, -- Intermission: March of the Penitent
		[329906] = -22059, -- Stage Two: The Crimson Chorus
		[332585] = -22195,-- Stage Three: Indignation
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("RAID_BOSS_EMOTE")

	-- Stage One: Sinners Be Cleansed
	self:Log("SPELL_CAST_SUCCESS", "Inevitable", 328936)
	self:Log("SPELL_AURA_APPLIED", "BurdenofSinStacks", 326699)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BurdenofSinStacks", 326699)
	self:Log("SPELL_AURA_REMOVED_DOSE", "BurdenofSinStacks", 326699)
	self:Log("SPELL_AURA_REMOVED", "BurdenofSinRemoved", 326699)
	self:Log("SPELL_CAST_START", "CleansingPain", 326707)
	self:Log("SPELL_CAST_SUCCESS", "CleansingPainSuccess", 326707)
	self:Log("SPELL_CAST_START", "BloodPriceStart", 326851)
	self:Log("SPELL_AURA_APPLIED", "NightHunterApplied", 327796)
	self:Log("SPELL_AURA_REMOVED", "NightHunterRemoved", 327796)
	self:Log("SPELL_CAST_START", "Ravage", 327122)

	-- Intermission: March of the Penitent
	self:Log("SPELL_CAST_START", "MarchofthePenitentStart", 328117)

	-- Stage Two: The Crimson Chorus
	self:Log("SPELL_CAST_SUCCESS", "BegintheChorus", 329697)
	self:Log("SPELL_AURA_APPLIED", "CarnageApplied", 329906)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CarnageApplied", 329906)
	self:Log("SPELL_AURA_APPLIED", "ImpaleApplied", 329951)
	self:Log("SPELL_AURA_REMOVED", "ImpaleRemoved", 329951)
	self:Log("SPELL_CAST_START", "WrackingPain", 329181)
	self:Log("SPELL_AURA_APPLIED", "WrackingPainApplied", 329181)
	self:Log("SPELL_AURA_APPLIED_DOSE", "WrackingPainApplied", 329181)
	self:Log("SPELL_CAST_START", "HandofDestruction", 333932)
	self:Log("SPELL_CAST_SUCCESS", "Massacre", 330068)

	-- Stage Three: Indignation
	self:Log("SPELL_CAST_SUCCESS", "IndignationSuccess", 326005)
	self:Log("SPELL_AURA_APPLIED", "ScornApplied", 332585)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ScornApplied", 332585)
	self:Log("SPELL_CAST_SUCCESS", "ShatteringPain", 332619)
	self:Log("SPELL_AURA_APPLIED", "FatalFinesseApplied", 332794)
	self:Log("SPELL_AURA_REMOVED", "FatalFinesseRemoved", 332794)
	self:Log("SPELL_CAST_SUCCESS", "ReflectionRavage", 332849)
	self:Log("SPELL_CAST_SUCCESS", "ReflectionMassacre", 333980)

	self:Log("SPELL_AURA_APPLIED", "GroundDamage", 327992, 335873) -- Desolation, Rancor
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundDamage", 327992, 335873)
	self:Log("SPELL_PERIODIC_MISSED", "GroundDamage", 327992, 335873)
end

function mod:OnEngage()
	stage = 1
	self.stage = stage
	intermission = nil
	nextStageWarning = 73

	cleansingPainCount = 1
	bloodPriceCount = 1
	nightHunterCount = 1
	ravageCount = 1
	addCount = 1

	self:Bar(326707, timers[stage][326707][cleansingPainCount], CL.count:format(self:SpellName(326707), cleansingPainCount)) -- Cleansing Pain
	self:Bar(326851, 23, CL.count:format(self:SpellName(326851), bloodPriceCount)) -- Blood Price
	self:Bar(327796, timers[stage][327796][nightHunterCount], CL.count:format(self:SpellName(327796), nightHunterCount)) -- Night Hunter
	self:Bar(327122, 53, CL.count:format(self:SpellName(327122), ravageCount)) -- Ravage

	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	burdenStackTable = {
		[0] = 0,
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 0,
	}
	burdenPlayerTracker = {}
	burdenStacksOnMe = 0

	self:OpenInfo(326699, self:SpellName(326699)) -- Burden of Sin
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RAID_BOSS_EMOTE(_, msg)
	if msg:find(L.add_spawn, nil, true) then -- Crimson Cabalists spawned
		self:Message(-22131, "yellow", CL.incoming:format(CL.count:format(CL.adds, addCount)), 329711) -- Crimson Chorus Icon
		self:PlaySound(-22131, "alert")
		addCount = addCount + 1
		self:Bar(-22131, timers[stage][-22131][addCount], CL.count:format(CL.adds, addCount), 329711) -- Crimson Chorus Icon
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextStageWarning then -- Stage changes at 70% and 40%
		local nextStage = stage == 1 and CL.intermission or CL.stage:format(stage + 1)
		self:Message("stages", "green", CL.soon:format(nextStage), false)
		nextStageWarning = nextStageWarning - 30
		if nextStageWarning < 30 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

function mod:Inevitable(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

do
	local playerName = mod:UnitName("player")
	local scheduled = nil

	function mod:UpdateInfoBox()
		-- Empty first
		self:SetInfo(326699, 1, "")
		self:SetInfo(326699, 2, "")
		self:SetInfo(326699, 3, "")
		self:SetInfo(326699, 4, "")
		self:SetInfo(326699, 5, "")
		self:SetInfo(326699, 6, "")
		self:SetInfo(326699, 7, "")
		self:SetInfo(326699, 8, "")
		self:SetInfo(326699, 9, "")
		self:SetInfo(326699, 10, "")

		-- count the raid size so we can colour accordingly
		local playersAlive = 0
		for unit in self:IterateGroup() do
			local _, _, _, tarInstanceId = UnitPosition(unit)
			local name = self:UnitName(unit)
			if name and tarInstanceId == 2296 and not UnitIsDead(unit) then
				playersAlive = playersAlive + 1
			end
		end
		if playersAlive == 0 then return end -- wipe

		-- Lets show the info
		local lineCount = 1
		for i = 6, 1, -1 do
			if burdenStackTable[i] and burdenStackTable[i] > 0 then
				if lineCount == 11 then
					lineCount = 2 -- start on the even side
				end
				local percentOfRaid = burdenStackTable[i]/playersAlive
				local color =  percentOfRaid > 0.6 and "|cffff0000" or percentOfRaid < 0.3 and "|cff00ff00" or "|cffffff00"
				local lineText = color..L.infobox_stacks:format(i, burdenStackTable[i]).."|r"
				if i == burdenStacksOnMe then
					lineText = "|cff3366ff>>|r"..lineText.."|cff3366ff<<|r"
				end
				self:SetInfo(326699, lineCount, lineText)
				lineCount = lineCount + 2
			end
		end
	end

	function mod:BurdenofSinStackMessage()
		mod:StackMessage(326699, playerName, burdenStacksOnMe, "blue")
		mod:PlaySound(326699, "alarm")
		scheduled = nil
	end

	function mod:BurdenofSinStacks(args)
		local oldValue = burdenPlayerTracker[args.destName]
		if oldValue then
			burdenStackTable[oldValue] = burdenStackTable[oldValue] - 1
		end
		local _, amount = self:UnitDebuff(args.destName, args.spellId) -- no amount in the event, checking ourselves
		burdenPlayerTracker[args.destName] = amount
		burdenStackTable[amount] = burdenStackTable[amount] + 1
		if self:Me(args.destGUID) then
			burdenStacksOnMe = amount
			if not scheduled then
				scheduled = self:ScheduleTimer("BurdenofSinStackMessage", 0.1)
			end
		end
		mod:UpdateInfoBox()
	end

	function mod:BurdenofSinRemoved(args)
		if scheduled then
			self:CancelTimer(scheduled)
			scheduled = nil
		end
		local oldValue = burdenPlayerTracker[args.destName]
		burdenStackTable[oldValue] = burdenStackTable[oldValue] - 1
		burdenStackTable[0] = burdenStackTable[0] + 1
		burdenPlayerTracker[args.destName] = 0
		if self:Me(args.destGUID) then
			burdenStacksOnMe = 0
			self:Message(args.spellId, intermission and "green" or "red", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, intermission and "info" or "warning")
		end
		mod:UpdateInfoBox()
	end

	function mod:BloodPriceStart(args)
		self:StackMessage(args.spellId, playerName, burdenStackTable[burdenStacksOnMe], "blue")
		self:PlaySound(args.spellId, "alarm")
		bloodPriceCount = bloodPriceCount + 1
		self:Bar(args.spellId, 58, CL.count:format(args.spellName, bloodPriceCount))
	end
end

function mod:CleansingPain(args)
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, cleansingPainCount))
	self:PlaySound(args.spellId, "alert")
end

function mod:CleansingPainSuccess(args)
	cleansingPainCount = cleansingPainCount + 1
	self:Bar(args.spellId, timers[stage][args.spellId][cleansingPainCount], CL.count:format(args.spellName, cleansingPainCount))
end

do
	local playerList, playerIcons = mod:NewTargetList(), {}
	function mod:NightHunterApplied(args)
		local count = #playerList+1
		playerList[count] = args.destName
		playerIcons[count] = count
		if self:Me(args.destGUID)then
			self:Say(args.spellId, CL.count_rticon:format(args.spellName, count, count))
			self:SayCountdown(args.spellId, 6, count)
		end
		self:TargetsMessage(args.spellId, "orange", playerList, self:Mythic() and 3 or 2, CL.count:format(args.spellName, nightHunterCount), nil, nil, playerIcons)
		if count == 1 then
			self:PlaySound(args.spellId, "warning")
			self:CastBar(args.spellId, 6, CL.count:format(args.spellName, nightHunterCount))
			nightHunterCount = nightHunterCount + 1
			self:Bar(args.spellId, timers[stage][args.spellId][nightHunterCount], CL.count:format(args.spellName, nightHunterCount))
		end
		if self:GetOption(nightHunterMarker) then
			SetRaidTarget(args.destName, count)
		end
	end

	function mod:NightHunterRemoved(args)
		if self:GetOption(nightHunterMarker) then
			SetRaidTarget(args.destName, 0)
		end
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:Ravage(args)
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, ravageCount))
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 6, CL.count:format(args.spellName, ravageCount))
	ravageCount = ravageCount + 1
	self:Bar(args.spellId, 58, CL.count:format(args.spellName, ravageCount))
end

-- Intermission: March of the Penitent
function mod:MarchofthePenitentStart(args)
	if stage == 1 then
		stage = stage + 1
		self.stage = stage
		intermission = true
		self:Message("stages", "green", CL.intermission, false)
		self:PlaySound("stages", "long")
		self:CastBar("stages", 16.5, CL.intermission, 328276) -- 1.5s precast, 15s channel // March of the Penitent icon

		self:StopBar(CL.count:format(self:SpellName(326707), cleansingPainCount)) -- Cleansing Pain
		self:StopBar(CL.count:format(self:SpellName(326851), bloodPriceCount)) -- Blood Price
		self:StopBar(CL.count:format(self:SpellName(327796), nightHunterCount)) -- Night Hunter
		self:StopBar(CL.count:format(self:SpellName(327122), ravageCount)) -- Ravage
	end
end

-- Stage Two: The Crimson Chorus
function mod:BegintheChorus(args)
	intermission = nil
	self:CloseInfo(326699)
	self:Message("stages", "green", CL.stage:format(stage), false)
	self:PlaySound("stages", "long")

	impaleCount = 1
	wrackingPainCount = 1
	handCount = 1
	massacreCount = 1
	addCount = 1

	self:Bar(-22131, timers[stage][-22131][addCount], CL.count:format(CL.adds, addCount), 329711) -- Adds // Crimson Chorus Icon
	self:Bar(329951, timers[stage][329951][impaleCount], CL.count:format(self:SpellName(329951), impaleCount)) -- Impale
	self:Bar(329181, 15.7, CL.count:format(self:SpellName(329181), wrackingPainCount)) -- Wracking Pain
	self:Bar(333932, timers[stage][333932][handCount], CL.count:format(self:SpellName(333932), handCount)) -- Hand of Destruction
	self:Bar(330068, 62, CL.count:format(self:SpellName(330068), massacreCount)) -- Massacre
end

function mod:CarnageApplied(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, args.destName, args.amount, "blue")
		self:PlaySound(args.spellId, "alarm")
	end
end

do
	local playerList, playerIcons = mod:NewTargetList(), {}
	function mod:ImpaleApplied(args)
		local count = #playerList+1
		playerList[count] = args.destName
		playerIcons[count] = count
		if self:Me(args.destGUID)then
			self:Say(args.spellId, CL.count_rticon:format(args.spellName, count, count))
			--self:SayCountdown(args.spellId, 6, count) -- Disabled to keep showing what number charge you are, the countdown makes it confusing
			self:PlaySound(args.spellId, "warning")
		end
		self:TargetsMessage(args.spellId, "orange", playerList, 3, CL.count:format(args.spellName, impaleCount), nil, 2, playerIcons) -- debuffs are late
		if count == 1 then
			impaleCount = impaleCount + 1
			self:Bar(args.spellId, timers[stage][args.spellId][impaleCount], CL.count:format(args.spellName, impaleCount))
		end
		if self:GetOption(impaleMarker) then
			SetRaidTarget(args.destName, count)
		end
	end

	function mod:ImpaleRemoved(args)
		if self:GetOption(impaleMarker) then
			SetRaidTarget(args.destName, 0)
		end
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:WrackingPain(args)
	self:Message(args.spellId, "yellow", CL.casting:format(CL.count:format(args.spellName, wrackingPainCount)))
	self:PlaySound(args.spellId, "alert")
	wrackingPainCount = wrackingPainCount + 1
	self:CDBar(args.spellId, 20, CL.count:format(args.spellName, wrackingPainCount))
end

function mod:WrackingPainApplied(args)
	if self:Tank(args.destName) and self:Tank() then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "warning", args.destName)
	end
end

function mod:HandofDestruction(args)
	self:Message(args.spellId, "orange", CL.casting:format(CL.count:format(args.spellName, handCount)))
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 6, CL.count:format(args.spellName, handCount))
	handCount = handCount + 1
	self:Bar(args.spellId, timers[stage][args.spellId][handCount], CL.count:format(args.spellName, handCount))
end

function mod:Massacre(args)
	self:Message(args.spellId, "red", CL.count:format(args.spellName, massacreCount))
	self:PlaySound(args.spellId, "alarm")
	massacreCount = massacreCount + 1
	self:Bar(args.spellId, 50, CL.count:format(args.spellName, massacreCount))
end

-- Stage Three: Indignation
function mod:IndignationSuccess(args)
	stage = stage + 1
	self.stage = stage
	self:Message("stages", "green", CL.stage:format(stage), false)
	self:PlaySound("stages", "long")

	self:StopBar(CL.count:format(self:SpellName(329951), impaleCount)) -- Impale
	self:StopBar(CL.count:format(self:SpellName(329181), wrackingPainCount)) -- Wracking Pain
	self:StopBar(CL.count:format(self:SpellName(333932), handCount)) -- Hand of Destruction
	self:StopBar(CL.count:format(self:SpellName(330137), massacreCount)) -- Massacre
	self:StopBar(CL.count:format(CL.adds, addCount)) -- Adds

	handCount = 1
	shatteringPainCount = 1
	fatalFinesseCount = 1
	massacreCount = 1
	ravageCount = 1

	self:Bar(333932, timers[stage][333932][handCount], CL.count:format(self:SpellName(333932), handCount)) -- Hand of Destruction
	self:Bar(332619, 14, CL.count:format(self:SpellName(332619), shatteringPainCount)) -- Shattering Pain
	self:Bar(332794, timers[stage][332794][fatalFinesseCount], CL.count:format(self:SpellName(332794), fatalFinesseCount)) -- Fatal Finesse
	self:Bar(332849, 50, CL.count:format(self:SpellName(332937), ravageCount))
end

function mod:ScornApplied(args)
	local amount = args.amount or 1
	if amount % 3 == 0 or amount > 5 then -- 3, 6+
		self:StackMessage(args.spellId, args.destName, amount, "purple")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:ShatteringPain(args)
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, shatteringPainCount))
	self:PlaySound(args.spellId, "alert")
	shatteringPainCount = shatteringPainCount + 1
	self:Bar(args.spellId, 24, CL.count:format(args.spellName, shatteringPainCount))
end

do
	local playerList, playerIcons, sphereSpawned = mod:NewTargetList(), {}, nil
	function mod:FatalFinesseApplied(args)
		sphereSpawned = nil
		local count = #playerList+1
		playerList[count] = args.destName
		playerIcons[count] = count
		if self:Me(args.destGUID)then
			self:Say(args.spellId, CL.count_rticon:format(args.spellName, count, count))
			self:SayCountdown(args.spellId, 5, count)
			self:PlaySound(args.spellId, "warning")
		end
		self:TargetsMessage(args.spellId, "orange", playerList, 3, CL.count:format(args.spellName, fatalFinesseCount), nil, nil, playerIcons)
		if count == 1 then
			fatalFinesseCount = fatalFinesseCount + 1
			self:Bar(args.spellId, timers[stage][args.spellId][fatalFinesseCount], CL.count:format(args.spellName, fatalFinesseCount))
		end
		if self:GetOption(fatalFinesseMarker) then
			SetRaidTarget(args.destName, count)
		end
	end

	function mod:FatalFinesseRemoved(args)
		if self:GetOption(fatalFinesseMarker) then
			SetRaidTarget(args.destName, 0)
		end
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
		if not sphereSpawned then
			sphereSpawned = true
			self:CastBar(336008, 10) -- Smoldering Ire
		end
	end
end

function mod:ReflectionRavage(args)
	self:Message(args.spellId, "orange", CL.count:format(self:SpellName(332937), ravageCount))
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 9) -- 6s cast + 3s before he starts it
	ravageCount = ravageCount + 1
	self:Bar(333980, 40, CL.count:format(self:SpellName(330068), massacreCount)) -- Massacre // Alternates with Ravage
end

function mod:ReflectionMassacre(args)
	self:Message(args.spellId, "red", CL.count:format(self:SpellName(330068), massacreCount))
	self:PlaySound(args.spellId, "alarm")
	massacreCount = massacreCount + 1
	self:Bar(332849, 40, CL.count:format(self:SpellName(332937), ravageCount)) -- Ravage // Alternates with Massacre
end

do
	local prev = 0
	function mod:GroundDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PlaySound(args.spellId, "alarm")
				self:PersonalMessage(args.spellId, "underyou")
			end
		end
	end
end