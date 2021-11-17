Tracker:AddItems("item/equip.json")
Tracker:AddItems("item/story.json")

if string.find(Tracker.ActiveVariantUID, "tall") then
  if not string.find(Tracker.ActiveVariantUID, "X") then
    Tracker:AddLayouts("layouts/broad_tall.json")
  else
    Tracker:AddLayouts("layouts/broad_wide.json")
  end
  Tracker:AddLayouts("layouts/tall.json")
else
  if string.find(Tracker.ActiveVariantUID, "X") then
    Tracker:AddLayouts("layouts/broad_tall.json")
  else
    Tracker:AddLayouts("layouts/broad_wide.json")
  end
  Tracker:AddLayouts("layouts/wide.json")
end

Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

function tracker_on_accessibility_updated()
  morph_check()
  bomb_check()
  charge_check()
  missile_check()
end



function item_check(aloneS,compS)
  local alone = Tracker:ProviderCountForCode(aloneS)
  local comp = Tracker:FindObjectForCode(compS)
  if alone == 1 then
    comp.Active = true
  else
    comp.Active = false
  end
end

function item_prog_update(tog,prog,mult)
  local output = Tracker:FindObjectForCode(mult)
  local progIO = Tracker:FindObjectForCode(prog)
  local mod = Tracker:ProviderCountForCode(tog)

  output.CurrentStage = progIO.CurrentStage * 2 + mod
end



function morph_check()
  item_check("alonemorph","msb")
end

function bomb_check()
  item_check("alonebomb","sb")
  item_check("alonebomb","mbsb")
end

function charge_check()
  item_check("alonecharge","cpn")
  item_check("alonecharge","cpb")
end

function missile_check()
  item_prog_update("alonemissile","progressivemissile","lpm")
end
