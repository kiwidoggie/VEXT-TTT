class "Scoring"

function Scoring:__init()
	-- TTT Player Scoring
	self.m_InnocentOnInnocent = -10
	self.m_InnocentOnTraitor = 15
	self.m_TraitorOnInnocent = 15
	self.m_TraitorOnTraitor = -15
	
	-- TTT Team Scoring
	self.m_InnocentsWin = 5
	self.m_TraitorsWin = 10
end

function Scoring:GetInnocentOnInnocent()
	return self.m_InnocentOnInnocent
end

function Scoring:GetInnocentOnTraitor()
	return self.m_InnocentOnTraitor
end

function Scoring:GetTraitorOnInnocent()
	return self.m_TraitorOnInnocent
end

function Scoring:GetTraitorOnTraitor()
	return self.m_TraitorOnTraitor
end

function Scoring:GetInnocentWin()
	return self.m_InnocentsWin
end

function Scoring:GetTraitorWin()
	return self.m_TraitorsWin
end