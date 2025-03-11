--c40000108
--Guerrero Muerto 
--made by R0bo7M4n
local s,id=GetID()
function s.initial_effect(c)
	--Summon Procedure
	Fusion.AddProcMix(c,true,true,s.matfilter,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_WATER))
	Fusion.AddContactProc(c,s.contactfil,s.contactop,true)
	--Attribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_ATTRIBUTE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(0x4)
	c:RegisterEffect(e1)


end
function s.matfilter(c,fc,sumtype,tp)
	return c:IsAttribute(ATTRIBUTE_FIRE,fc,sumtype,tp) and c:IsSetCard(0x247,fc,sumtype,tp) and c:IsMonster()
end
function s.contactfil(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE|LOCATION_GRAVE,0,nil)
end
function s.contactop(g)
	Duel.Remove(g,POS_FACEUP,REASON_COST|REASON_MATERIAL)
end

