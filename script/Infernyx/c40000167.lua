--c40000167
--Soul of the Dragon
--made by R0bo7M4n
local s,id=GetID()
function s.initial_effect(c)
	aux.AddEquipProcedure(c,nil,s.eqfilter)
	--Draw 1 card
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,0))
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_DUEL)
	e4:SetTarget(s.drtg)
	e4:SetOperation(s.drop)
	c:RegisterEffect(e4)
	--Treated as a Red Eyes or Dragon Monster for the fusion summon of a fusion monster that lists it
	--Red-eyes substitute
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_ADD_SETCODE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetValue(0x3b)
	e5:SetOperation(function(scard,sumtype,tp) return (sumtype&MATERIAL_FUSION)>0 or (sumtype&SUMMON_TYPE_FUSION)>0 end)
	c:RegisterEffect(e5)
	--dragon
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_ADD_RACE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetValue(RACE_DRAGON)
	e6:SetOperation(function(scard,sumtype,tp) return (sumtype&MATERIAL_FUSION)>0 or (sumtype&SUMMON_TYPE_FUSION)>0 end)
	c:RegisterEffect(e6)

	--Fusion Summon
	
	local params={fusfilter=s.fusfilter,matfilter=Fusion.OnFieldMat,extrafil=s.extramat}
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(id,1))
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_SZONE)
	e7:SetTarget(Fusion.SummonEffTG(params))
	e7:SetOperation(Fusion.SummonEffOP(params))
	c:RegisterEffect(e7)








end
function s.eqfilter(c)
	return c:IsSetCard(0x24A) or c:IsSetCard(0x495)
end
function s.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

function s.fusfilter(c,e,tp)
	return c:ListsArchetypeAsMaterial(0x3b) or c:IsCode(41232647,11443677,41721210,13735899,75380687,86240887,72578374,43892408,36319131,72959823,19652159,14017402,37818794,70538272)
end
function s.extramatfilter(c)
	return c:IsMonster() and c:IsFaceup()
end
function s.extramat(e,tp,mg)
	return Duel.GetMatchingGroup(s.extramatfilter,tp,0,LOCATION_MZONE,nil)
end



