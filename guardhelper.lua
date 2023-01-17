guardhelper = guardhelper or {
  triggers = {},
  state = {}
}

-- find the weakest party member, who is being attacked
-- return id or 0
function guardhelper:find_weakest()
  local teamWeakestMemberId=0
  local teamWeakestMemberHp=10
  local teamWeakestMemberTeamEnemies=0
  local suggestedGuardTarget=0
  local savedDefenceTarget=0

  -- do nothing if the team is not in combat
  if table.size(ateam.team_enemies) == 0 then
    --print("Nikt nie walczy.")
    return 0
  end

  for v, k in pairs(ateam.team) do
    -- for all endangered team members...
    if type(v) == "number" and table.size(ateam.team_enemies[v]) > 0 then

      -- for the equaly wounded members, pick the most attacked one
      if ateam.objs[v]["hp"] == teamWeakestMemberHp then
        if table.size(ateam.team_enemies[v]) > teamWeakestMemberTeamEnemies then
          teamWeakestMemberId = v
          teamWeakestMemberHp = ateam.objs[v]["hp"]
          teamWeakestMemberTeamEnemies = table.size(ateam.team_enemies[v])
        end

      -- otherwise, find more wounded member
      elseif ateam.objs[v]["hp"] < teamWeakestMemberHp then
        teamWeakestMemberId = v
        teamWeakestMemberHp = ateam.objs[v]["hp"]
        teamWeakestMemberTeamEnemies = table.size(ateam.team_enemies[v])
      end

      -- save the defence target
      if ateam.objs[v]["defence_target"] then
        savedDefenceTarget = v
      end
    end

  end

  -- if found
  if teamWeakestMemberHp < 10 then
    suggestedGuardTarget = teamWeakestMemberId
  end

  -- overwrite the value with the defence_target marked
  -- ! OPTIONAL ! , can (should?) be commented out
  if not ateam.objs[ateam.my_id]["team_leader"] and savedDefenceTarget > 0 then
    suggestedGuardTarget = savedDefenceTarget
  end

  return suggestedGuardTarget
end

-- find the most wounded
-- return id or 0
function guardhelper:find_wounded()
  local teamWeakestMemberId=0
  local teamWeakestMemberHp=10
  local teamWeakestMemberTeamEnemies=0
  local suggestedGuardTarget=0
  local savedDefenceTarget=0

  -- do nothing if the team is not in combat
  if table.size(ateam.team_enemies) == 0 then
    --print("Nikt nie walczy.")
    return 0
  end

  for v, k in pairs(ateam.team) do
    -- for all endangered team members...
    if type(v) == "number" and table.size(ateam.team_enemies[v]) > 0 then

      -- for the equaly wounded members, pick the most attacked one
      if ateam.objs[v]["hp"] == teamWeakestMemberHp then
        if table.size(ateam.team_enemies[v]) > teamWeakestMemberTeamEnemies then
          teamWeakestMemberId = v
          teamWeakestMemberHp = ateam.objs[v]["hp"]
          teamWeakestMemberTeamEnemies = table.size(ateam.team_enemies[v])
        end

      -- otherwise, find more wounded member
      elseif ateam.objs[v]["hp"] < teamWeakestMemberHp then
        teamWeakestMemberId = v
        teamWeakestMemberHp = ateam.objs[v]["hp"]
        teamWeakestMemberTeamEnemies = table.size(ateam.team_enemies[v])
      end
    end 
  end

  -- if found
  if teamWeakestMemberHp < 10 then
    suggestedGuardTarget = teamWeakestMemberId
  end

  return suggestedGuardTarget
end

-- find the most attacked
-- return id or 0
function guardhelper:find_attacked()
  local teamWeakestMemberId=0
  local teamWeakestMemberHp=10
  local teamWeakestMemberTeamEnemies=0
  local suggestedGuardTarget=0
  local savedDefenceTarget=0

  -- do nothing if the team is not in combat
  if table.size(ateam.team_enemies) == 0 then
    --print("Nikt nie walczy.")
    return 0
  end

  for v, k in pairs(ateam.team) do
    -- for all endangered team members...
    if type(v) == "number" and table.size(ateam.team_enemies[v]) > 0 then

      -- for the equaly attacked members, pick the most wounded one
      if table.size(ateam.team_enemies[v]) == teamWeakestMemberTeamEnemies then
        if ateam.objs[v]["hp"] < teamWeakestMemberHp then
          teamWeakestMemberId = v
          teamWeakestMemberHp = ateam.objs[v]["hp"]
          teamWeakestMemberTeamEnemies = table.size(ateam.team_enemies[v])
        end

      -- otherwise, find the most attacked
      elseif table.size(ateam.team_enemies[v]) > teamWeakestMemberTeamEnemies then
        teamWeakestMemberId = v
        teamWeakestMemberHp = ateam.objs[v]["hp"]
        teamWeakestMemberTeamEnemies = table.size(ateam.team_enemies[v])
      end
    end 
  end

  -- if found
  if teamWeakestMemberHp < 10 then
    suggestedGuardTarget = teamWeakestMemberId
  end

  return suggestedGuardTarget
end

-- find the strongest party member, who is being attacked
-- return id or 0
function guardhelper:find_strongest()
  local teamWeakestMemberId=0
  local teamWeakestMemberHp=0
  local teamWeakestMemberTeamEnemies=10
  local suggestedGuardTarget=0

  -- do nothing if the team is not in combat
  if table.size(ateam.team_enemies) == 0 then
    --print("Nikt nie walczy.")
    return 0
  end

  for v, k in pairs(ateam.team) do
    -- for all team members...
    if ateam.objs[v] then

      -- for the equaly wounded members, pick the least attacked
      if ateam.objs[v]["hp"] == teamWeakestMemberHp then
        if table.size(ateam.team_enemies[v]) < teamWeakestMemberTeamEnemies then
          teamWeakestMemberId = v
          teamWeakestMemberHp = ateam.objs[v]["hp"]
          teamWeakestMemberTeamEnemies = table.size(ateam.team_enemies[v])
        end

      -- otherwise, find less wounded member
      elseif ateam.objs[v]["hp"] > teamWeakestMemberHp then
        teamWeakestMemberId = v
        teamWeakestMemberHp = ateam.objs[v]["hp"]
        teamWeakestMemberTeamEnemies = table.size(ateam.team_enemies[v])
      end
    end

  end

  -- if found
  if teamWeakestMemberHp < 10 then
    suggestedGuardTarget = teamWeakestMemberId
  end

  return suggestedGuardTarget
end


function guardhelper:render_shields()
  local anyone_to_guard = self:find_weakest()
  local nick_to_guard = 0

  if anyone_to_guard > 0 then
      self.guardId = anyone_to_guard
      if anyone_to_guard == ateam.my_id then
        nick_to_guard = ateam.options.own_name
        scripts.ui.window_modify(scripts.ui.states_window_name, nick_to_guard, scripts.ui.window_modifiers.surround("⛔ ", ""))
      else
        nick_to_guard = ateam.objs[anyone_to_guard]["desc"]
        scripts.ui.window_modify(scripts.ui.states_window_name, nick_to_guard, scripts.ui.window_modifiers.surround("🛡 ", ""))
      end
  end
end

function guardhelper:render_wounded()
  local anyone_to_guard = self:find_wounded()
  local nick_to_guard = 0

  if anyone_to_guard > 0 then
      self.woundedId = anyone_to_guard
      if anyone_to_guard == ateam.my_id then
        nick_to_guard = ateam.options.own_name
      else
        nick_to_guard = ateam.objs[anyone_to_guard]["desc"]
      end
      scripts.ui.window_modify(scripts.ui.states_window_name, nick_to_guard, scripts.ui.window_modifiers.surround("🩸 ", ""))
  end
end

function guardhelper:render_attacked()
  local anyone_to_guard = self:find_attacked()
  local nick_to_guard = 0

  if anyone_to_guard > 0 then
      self.attackedId = anyone_to_guard
      if anyone_to_guard == ateam.my_id then
        nick_to_guard = ateam.options.own_name
      else
        nick_to_guard = ateam.objs[anyone_to_guard]["desc"]
      end
      scripts.ui.window_modify(scripts.ui.states_window_name, nick_to_guard, scripts.ui.window_modifiers.surround("⚔  ", ""))
  end
end


-- EXPERIMENTAL
function guardhelper:utils_enemy_count_table(count)
  local cnt_tbl =
  {
    [0] = "[  ]",
    [1] = "<white>[ <yellow>1<white>]",
    [2] = "<white>[ <yellow>2<white>]",
    [3] = "<white>[ <red>3<white>]",
    [4] = "<white>[ <red>4<white>]",
    [5] = "<white>[ <red>5<white>]",
    [6] = "<white>[ <red>6<white>]",
    [7] = "<white>[ <red>7<white>]",
    [8] = "<white>[ <red>8<white>]",
    [9] = "<white>[ <red>9<white>]",
    [10] = "<white>[ <red>10<white>]",
  }

  return cnt_tbl[count]
end
-- EXPERIMENTAL
function guardhelper:render_enemy_counts()
    for k, v in pairs(ateam.team) do
      local team_enemies_string = ""
      if ateam.objs[k] then
        team_enemies_string = self:utils_enemy_count_table(table.size(ateam.team_enemies[k]))

        if k == ateam.my_id then
            scripts.ui.window_modify(scripts.ui.states_window_name, ateam.options.own_name, scripts.ui.window_modifiers.surround(team_enemies_string.." ", ""))
        else
            scripts.ui.window_modify(scripts.ui.states_window_name, ateam.objs[k]["desc"], scripts.ui.window_modifiers.surround(team_enemies_string.." ", ""))
        end

      end
    end
end


function guardhelper:highlight_state()


  if table.size(ateam.team) > 1 then   
    if guardhelper.show_suggested_target then
      self:render_shields()
    end
    if guardhelper.show_most_wounded then
      self:render_wounded()
    end
    if guardhelper.show_most_attacked then
      self:render_attacked()
    end
  end
end

function guardhelper:za_func_type(targetType)
  local selectedTarget = 0
  if targetType == "suggested" then
    selectedTarget = self.guardId    
  elseif targetType == "wounded" then
    selectedTarget = self.woundedId
  elseif targetType == "targeted" then
    selectedTarget = self.attackedId
  end

  if ateam.objs[ateam.my_id]["team_leader"] and guardhelper.respect_attack_flags then
    if ateam.attack_mode > 2 then
      if ateam.my_id == selectedTarget then
        send("rozkaz druzynie zaslonic cie");
      else
        send("rozkaz zaslonic ob_"..selectedTarget);
      end
    end
    if ateam.attack_mode > 1 then
      if ateam.my_id == selectedTarget then
        send("wskaz siebie jako cel obrony")
      else
        send("wskaz ob_"..selectedTarget.." jako cel obrony");
      end
    end
  end

  ateam:za_func(ateam.team[selectedTarget])

end

function guardhelper:za_func()

    if ateam.objs[ateam.my_id]["team_leader"] and guardhelper.respect_attack_flags then
      if ateam.attack_mode > 2 then
        if ateam.my_id == self.guardId then
          send("rozkaz druzynie zaslonic cie");
        else
          send("rozkaz zaslonic ob_"..self.guardId);
        end
      end
      if ateam.attack_mode > 1 then
        if ateam.my_id == self.guardId then
          send("wskaz siebie jako cel obrony")
        else
          send("wskaz ob_"..self.guardId.." jako cel obrony");
        end
      end
    end
  --  if scripts.ui.states_window_nav_states["guard_state"] == "ok" then
      ateam:za_func(ateam.team[self.guardId])
--    end

end

function guardhelper:clear_state()
  self.state = {}
end

function guardhelper:init()
  self.statesHandler = scripts.event_register:register_singleton_event_handler(self.statesHandler, "printStatusDone", function() self:highlight_state() end)
end

guardhelper:init()
