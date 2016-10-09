class "TeamManager"

function TeamManager:__init()
	-- Defaults
	self.m_IsInGame = false
	
	-- Events
	self.m_InGameChangedEvent = Events:Subscribe("Logic:IsInGameChanged", self, self.OnIsInGameChanged)
	self.m_EngineUpdateEvent = Events:Subscribe("Engine:Update", self, self.OnUpdate)
	
	-- Player Events
	self.m_PlayerAuthenticatedEvent = Events:Subscribe("Player:Authenticated", self, self.OnPlayerAuthenticated)
	self.m_PlayerDestroyedEvent = Events:Subscribe("Player:Destroyed", self, self.OnPlayerDestroyed)
	
	-- Players
	self.m_Players = { }
	
	-- Detective Settings
	self.m_DetectiveScanTime = 5.0
	self.m_CurrentDetectiveScanTime = 0.0
end

function TeamManager:OnIsInGameChanged(p_IsInGame)
	self.m_IsInGame = p_IsInGame
end

function TeamManager:OnUpdate(p_Delta, p_SimulationDelta)
	if self.m_IsInGame == false then
		return
	end
	
	if self.m_CurrentDetectiveScanTime >= self.m_DetectiveScanTime then
		-- Send out our detective pulse
		self:DetectiveScan()
		
		-- Reset the time back to 0
		self.m_CurrentDetectiveScanTime = 0.0
	end
	
end

function TeamManager:DetectiveScan()
	if self.m_IsInGame == false then
		return
	end
	
	s_Detective = nil
	
	-- Find our detective
	for i, s_TeamPlayer in ipairs(self.m_Players) do
		if s_TeamPlayer:IsDetective() then
			s_Detective = s_TeamPlayer
			break
		end
	end
	
	-- Make sure we got a detective
	if s_Detective == nil then
		return
	end
	
	-- Get the detective's transform
	s_DetectiveTransform = s_Detective:GetTransform()
	
	-- Loop through each player and determine if we should investigate that person
	for i, s_TeamPlayer in ipairs(self.m_Players) do
		-- We don't want to check ourself before we rekt ourself
		if s_TeamPlayer:IsDetective() then
			goto continue
		end
		
		-- We only want to check dead bodies
		if s_TeamPlayer:IsAlive() then
			goto continue
		end
		
		-- If we have already checked this body, fuck-em'
		if s_TeamPlayer:IsInvestigated() then
			goto continue
		end
		
		-- TODO: We need to be able to get the corpse.
		-- TODO: We need to disable spawning.
		::continue::
	end
end

function TeamManager:OnPlayerAuthenticated(p_Player)
	-- TODO: Create a TeamPlayer object, and add it to a list
end

function TeamManager:OnPlayerDestroyed(p_Player)
	-- TODO: Remove player from list, and destroy the object if needed.
	-- TODO: Run tests to figure out if the player leaving interferes with the game
end