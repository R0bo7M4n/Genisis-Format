--c40000173
--Red-Eyes Flame Dragon Knight
--made by R0bo7M4n
local s,id=GetID()
function s.initial_effect(c)
	--fusion material
	Fusion.AddProcMix(c,true,true,s.mfilter1,CARD_FLAME_SWORDSMAN)
	c:EnableReviveLimit()
	--actlimit upon attacking
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(s.aclimit)
	e1:SetCondition(s.actcon)
	c:RegisterEffect(e1)


end
s.material_setcode=0x3b
s.listed_names={CARD_FLAME_SWORDSMAN}
function s.mfilter1(c,fc,sumtype,tp)
	return c:IsSetCard(0x3b,fc,sumtype,tp) and c:IsRace(RACE_DRAGON,fc,sumtype,tp)
end
function s.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function s.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end


