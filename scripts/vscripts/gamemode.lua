function GameMode:UpdateAbilities()
  SendToConsole("script_reload")
  SendToConsole("cl_script_reload")
  for k,hero in pairs(HeroList:GetAllHeroes()) do
    PlayerResource:ReplaceHeroWith(hero:GetPlayerID(), hero:GetClassname(), PlayerResource:GetGold(hero:GetPlayerID()), hero:GetCurrentXP())
    hero:Destroy()
  end
end
