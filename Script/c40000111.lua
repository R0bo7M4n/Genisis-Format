--c40000111
--Don Quixote
--made by R0bo7M4n
local s,id=GetID()
function s.initial_effect(c)
	--Summon Procedure
	Fusion.AddProcMix(c,true,true,40000108,40000110)
	Fusion.AddContactProc(c,s.contactfil,s.contactop,true)

	--Shuffle all from grave and banished
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.tdcon)
	e1:SetTarget(s.tdtg)
	e1:SetOperation(s.tdop)
	c:RegisterEffect(e1)


end
function s.contactfil(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE|LOCATION_GRAVE,0,nil)
end
function s.contactop(g)
	Duel.Remove(g,POS_FACEUP,REASON_COST|REASON_MATERIAL)
end


function s.tdcon(e)
	return e:GetHandler():GetSummonLocation()&LOCATION_EXTRA==LOCATION_EXTRA
end
function s.tdfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) or c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToDeck()
end
function s.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local dg=Duel.GetMatchingGroup(s.tdfilter,tp,LOCATION_REMOVED|LOCATION_GRAVE,LOCATION_REMOVED|LOCATION_GRAVE,nil)
	if chk==0 then return #dg>0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,dg,#dg,0,0)
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(s.tdfilter,tp,LOCATION_REMOVED|LOCATION_GRAVE,LOCATION_REMOVED|LOCATION_GRAVE,nil)
	if #dg==0 then return end
	local dt=Duel.SendtoDeck(dg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	local c=e:GetHandler()
	if dt~=0 and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(dt*100)
		c:RegisterEffect(e1)
	end
	Duel.BreakEffect()
	local sg=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)
	if #sg>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local tg=sg:Select(tp,1,1,nil)
		Duel.HintSelection(tg)
		Duel.Destroy(tg,REASON_EFFECT)
	end

end

