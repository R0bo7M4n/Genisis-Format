--c40000125
--Windwisp Union
--made by R0bo7M4n
local s,id=GetID()
function s.initial_effect(c)
	--Fusion summon 1 "Windwisp" fusion monster
	--Using monsters from hand or field as fusion material
	local e1=Fusion.CreateSummonEff(c,aux.FilterBoolFunction(Card.IsSetCard,0x248),nil,nil,nil,nil,s.stage2)
	e1:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)

end
function s.stage2(e,tc,tp,sg,chk)
	if chk==1 then
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
	end
end

