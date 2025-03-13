--c40000120
--Windwisp Layla
--made by R0bo7M4n
local s,id=GetID()
function s.initial_effect(c)
	--Add Spell to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.tg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--negate attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(s.condition)
	e3:SetCost(aux.bfgcost)
	e3:SetOperation(s.operation)
	c:RegisterEffect(e3)


end
function s.filter(c)
	return c:IsSetCard(0x248) and c:IsAbleToHand() and c:IsSpell()
end
function s.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end


function s.filter2(c)
	local lv=c:GetLevel()
	return c:IsFaceup() and lv==2
end
function s.condition(e,tp)
	local tp=e:GetHandler():GetControler()
	return Duel.IsExistingMatchingCard(s.filter2,tp,LOCATION_MZONE,0,1,nil) and Duel.GetAttacker():IsControler(1-tp)
end

function s.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end


