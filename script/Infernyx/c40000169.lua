--c40000169
--Soul of the Magicians
--made by R0bo7M4n
local s,id=GetID()
function s.initial_effect(c)
	aux.AddEquipProcedure(c,nil,s.eqfilter)
	--Add Spellcaster from GY to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(s.thtg)
	e4:SetOperation(s.thop)
	c:RegisterEffect(e4)
	--Treated as a Dark Magician or Spellcaster Monster for the fusion summon of a fusion monster that lists it
	--Dark Magician substitute
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_ADD_CODE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetValue(CARD_DARK_MAGICIAN)
	e5:SetOperation(function(scard,sumtype,tp) return (sumtype&MATERIAL_FUSION)>0 or (sumtype&SUMMON_TYPE_FUSION)>0 end)
	c:RegisterEffect(e5)
	--Spellcaster
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_ADD_RACE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetValue(RACE_SPELLCASTER)
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
function s.filter(c)
	return c:IsMonster() and c:IsAbleToHand() and c:IsRace(RACE_SPELLCASTER)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.fusfilter(c,e,tp)
	return c:ListsCodeAsMaterial(CARD_DARK_MAGICIAN) or c:IsCode(21113684,01516510,13735899,50237654,09603252,35877582,66532962)
end
function s.extramatfilter(c)
	return c:IsMonster() and c:IsFaceup()
end
function s.extramat(e,tp,mg)
	return Duel.GetMatchingGroup(s.extramatfilter,tp,0,LOCATION_MZONE,nil)
end
