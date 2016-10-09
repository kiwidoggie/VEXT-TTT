class "TeamPlayer"

function TeamPlayer:__init(p_Player)
	-- ServerPlayer reference
	self.m_ServerPlayer = p_Player
	
	-- TTT Settings
	self.m_IsDetective = false
	self.m_IsInnocent = false
	self.m_IsTraitor = false
	
	-- TTT Scoring
	self.m_Score = 0
	
	-- Has the detective investigated this person already
	self.m_IsInvestigated = false
end

function TeamPlayer:SetDetective()
	self.m_IsDetective = true
	self.m_IsInnocent = true
	self.m_IsTraitor = false
end

function TeamPlayer:SetTraitor()
	self.m_IsDetective = false
	self.m_IsInnocent = false
	self.m_IsTraitor = true
end

function TeamPlayer:SetInnocent()
	self.m_IsDetective = false
	self.m_IsInnocent = true
	self.m_IsTraitor = false
end

function TeamPlayer:IsDetective()
	return self.m_IsDetective
end

function TeamPlayer:IsInnocent()
	return self.m_IsInnocent
end

function TeamPlayer:IsTraitor()
	return self.m_IsTraitor
end

function TeamPlayer:Investigate(p_Detective)
	if p_Detective:IsDetective() == false then
		return
	end
	
	-- TODO: Tell the detective what this dead player is
	self.m_IsInvestigated = true
end

function TeamPlayer:IsInvestigated()
	return self.m_IsInvestigated
end

function TeamPlayer:IsAlive()
	-- Extension function for ServerPlayer
	if self.m_ServerPlayer == nil then
		return false
	end
	
	return self.m_ServerPlayer.alive
end

function TeamPlayer:GetTransform()
	if self:IsAlive() == false then
		return LinearTransform(Vec3(1, 0, 0), Vec3(0, 1, 0), Vec3(0, 0, 1), Vec3(0, -9999.0, 0))
	end
	
	if self.m_ServerPlayer.hasSoldier == false then
		return LinearTransform(Vec3(1, 0, 0), Vec3(0, 1, 0), Vec3(0, 0, 1), Vec3(0, -9999.0, 0))
	end
	
	s_Soldier = self.m_ServerPlayer.soldier
	
	if s_Soldier == nil then
		return LinearTransform(Vec3(1, 0, 0), Vec3(0, 1, 0), Vec3(0, 0, 1), Vec3(0, -9999.0, 0))
	end
	
	return s_Soldier.transform
end