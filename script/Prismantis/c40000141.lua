--c40000141
--Prismantis Thrasher
--made by R0bo7M4n
local s,id=GetID()
function s.initial_effect(c)
	Gemini.AddProcedure(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Gemini.EffectStatusCondition)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)

end
function s.filter(c,tp)
	return c:IsSetCard(0x249) and c:IsAbleToHand() and c:IsSpellTrap()
		and Duel.IsExistingMatchingCard(s.filter2,tp,LOCATION_DECK,0,1,nil)
end
function s.filter2(c)
	return c:IsCode(14357527,76039636,13302026,77754169,09627468,41456841,65430555,98520301,91512835,37957847,56146300,03084730,23738096,74976215,90161770,51578214,30587695,46502744,53754104,26185991,84462118,44175358,96938986,91559748,40000141,08910240,39041550,39078434,93107608,17535764,19301729,79663524,54772065,02656842,01799464,83048208,05068132,40000140,14472500,48588176,14457896,27911549,28388927,10807219,01474910,65899613,91283212,40000143,13234975,21056275,43140791,52838896,68441986,87240371,89226534,94716515,96965364,40000142,47185546,77840540,22991179,60619435,67441879,80402389,86527709,03492538,77007920,58012707,64213017,67831115,13235258,40633084,56051648,03734202,70861343,01712616) and c:IsAbleToHand() 
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil,tp)
	if #g>0 then
		local mg=Duel.GetMatchingGroup(s.filter2,tp,LOCATION_DECK,0,nil)
		if #mg>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=mg:Select(tp,1,1,nil)
			g:Merge(sg)
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
