guardhelper = guardhelper or {
  triggers = {},
  fadingcolor = "red",
  state = {}
}

-- TODO
-- mozliwosc kolorowania wlaczonego okna walki gdy podniesione sa nastepujace eventy
-- ateamAttackingDifferentTarget
-- scripts.ui.combat_window.name - gayser okno walki
-- TODO
-- mozliwosc kolorowania wlaczonego okna wrogow gdy atakujemy zly cel
-- stunStart
-- stunEnd

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
  if ateam.my_id and ateam.objs[ateam.my_id]["team"] then
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

    -- I am the defense target
    if ateam.my_id == self.guardId then
      if gmcp.char.info.guild_occ == "Legionista" then
        anyone_to_hide_behind = self:find_strongest()
        if anyone_to_hide_behind > 0 then
          send("cofnij sie za ob_" .. anyone_to_hide_behind)
          return
        end
      end
      return
    end

    if guardhelper.cooldown_lock then
      -- attempt to guard only off CD
      if scripts.ui.states_window_nav_states.guard_state then
        return
      end
    end
    
    -- find the preferred attacker
    local who_to_guard_from = self:find_best_attacker(self.guardId)

    -- default defense
    if who_to_guard_from < 1 or not guardhelper.targeted_guards or not (gmcp.char.info.guild_occ == "Partyzant" or gmcp.char.info.guild_occ == "Nozownik") then
      ateam:za_func(ateam.team[self.guardId])
      return
    end

    -- defend from...
    send("zaslon przed ob_" .. who_to_guard_from)
    -- hack
    if ateam.release_guards then
      send("przestan zaslaniac")
    end
end

function guardhelper:find_best_attacker(defence_target)

  for k, v in pairs(gmcp.objects.nums) do
    --print("my id: " .. ateam.my_id .. "    def target:" .. guardhelper.guardId .. "   mytarget: " .. ateam.objs[ateam.my_id].attack_num .. "  probing:" .. v)
    -- find enemy:
    if v ~= ateam.my_id                               -- not my id
      and ateam.enemy_op_ids[v]                       -- exists in the enemy table
      and v ~= ateam.objs[ateam.my_id].attack_num     -- is not my attack target
      and ateam.objs[v].attack_num == defence_target  -- is attacking my defense target
      then
        return v
    end
  end

  -- if you are still here, just defend anyone
  return 0
end

function guardhelper:show_guard_window(current_status)
  if guardhelper.show_guard_status then
    local roundedValue = 150 - round(current_status * 30)
    if current_status >= 5 then 
      setBackgroundColor("states_window", 0,0,0,0)
    else
      if guardhelper.fadingcolor == "green" then
        setBackgroundColor("states_window", 0,roundedValue,0,255)
      else
        setBackgroundColor("states_window", roundedValue,0,0,255)
      end
    end
  end
end

function guardhelper:fade_guard_window(c_red,c_green,c_blue,c_hue)
  if guardhelper.show_guard_status then
    local roundedValue = 150 - round(current_status * 30)
    if current_status >= 5 then
      setBackgroundColor("states_window", 0,0,0,0)
    else
      if guardhelper.fadingcolor == "green" then
        setBackgroundColor("states_window", 0,roundedValue,0,255)
      else
        setBackgroundColor("states_window", roundedValue,0,0,255)
      end
    end
  end
end

function guardhelper:blink_state_window(c_red,c_green,c_blue,c_hue, duration)
  if guardhelper.show_guard_status then
    setBackgroundColor("states_window", c_red,c_green,c_blue,c_hue)
    tempTimer(duration,[[setBackgroundColor("states_window", 0,0,0,0)]])
  end
end

function guardhelper:clear_state()
  self.state = {}
end

function guardhelper:init()
  ghHelpAliasID = tempAlias("^/gh$", [[
    cecho("<gray>+------------------------------------------------------------+<reset>\n")
    cecho("<gray>|  <yellow>               .: Zaslony Wesolego Elfa :.                <gray>|<reset>\n")
    cecho("<gray>|                                                            <gray>|<reset>\n")
    cecho("<gray>|  - aliasy na sugerowany cel zaslony, rannego, atakowanego  <gray>|<reset>\n")
    cecho("<gray>|  - obsluga partyzanta i fanatyka (zaslony przed nie-celem) <gray>|<reset>\n")
    cecho("<gray>|  - cofanie sie legionisty                                  <gray>|<reset>\n")
    cecho("<gray>|  - kolorowanie cooldownow jako tlo okna walki              <gray>|<reset>\n")
    cecho("<gray>|  - respektowane flagi atakow i sciaganie zaslon mudleta    <gray>|<reset>\n")
    cecho("<gray>|                                                            <gray>|<reset>\n")
    cecho("<gray>|  <yellow>Wszystkie opcje true/false                                <gray>|<reset>\n")
    cecho("<gray>|  <light_slate_blue>                                                          <gray>|<reset>\n")
    cecho("<gray>|  <red>guardhelper.show_suggested_target - POKAZUJ SUGESTIE      <gray>|<reset>\n")
    cecho("<gray>|  <light_slate_blue>guardhelper.respect_attack_flag   - uzywaj flag AWR       <gray>|<reset>\n")
    cecho("<gray>|  <light_slate_blue>guardhelper.cooldown_lock         - czy zaslaniac w CD    <gray>|<reset>\n")    
    cecho("<gray>|  <light_slate_blue>guardhelper.show_most_wounded     - pokazuj rannego       <gray>|<reset>\n")
    cecho("<gray>|  <light_slate_blue>guardhelper.show_most_attacked    - pokazuj celowanego    <gray>|<reset>\n")
    cecho("<gray>|  <light_slate_blue>guardhelper.show_guard_status     - kolorowy COOLDOWN     <gray>|<reset>\n")
    cecho("<gray>|  <light_slate_blue>guardhelper.targeted_guards       - wlacz zawody SC i MC  <gray>|<reset>\n")
    cecho("<gray>|                                                            <gray>|<reset>\n")
    cecho("<gray>|  <yellow>Aliasy                                                    <gray>|<reset>\n")
    cecho("<gray>|  <light_slate_blue>                                                          <gray>|<reset>\n")
    cecho("<gray>|  <red>guardhelper:za_func()             - zaslon SUGEROWANEGO   <gray>|<reset>\n")
    cecho("<gray>+------------------------------------------------------------+<reset>\n")
  ]])

  self.statesHandler = scripts.event_register:register_singleton_event_handler(self.statesHandler, "printStatusDone", function() self:highlight_state() end)
  self.statesHandler2 = scripts.event_register:register_singleton_event_handler(self.statesHandler2, "guard_state", function(_, state)  self:show_guard_window(state) end)
end

guardhelper:init()

-- REPLACEMENT FUNCTIONS
function trigger_func_skrypty_ui_footer_elements_cover_action_success()
  guardhelper.fadingcolor="green"
  ateam.cover_command_click = nil
  scripts.ui.guard_state_epoch = getEpoch()
  resumeNamedTimer("arkadia", "cover_timer")
end

function trigger_func_skrypty_ui_footer_elements_cover_action_fail()
  guardhelper.fadingcolor="red"
  scripts.ui.guard_state_epoch = getEpoch()
  resumeNamedTimer("arkadia", "cover_timer")
end

function trigger_func_skrypty_ui_footer_elements_order_action()
  guardhelper.fadingcolor="green"
  scripts.ui.order_state_epoch = getEpoch()
  resumeNamedTimer("arkadia", "order_timer")
end

