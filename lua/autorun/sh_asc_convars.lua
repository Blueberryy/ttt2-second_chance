A_SECOND_CHANCE = A_SECOND_CHANCE or {}
A_SECOND_CHANCE.CVARS = A_SECOND_CHANCE.CVARS or {}

local max_revive_time = CreateConVar("ttt_asc_max_revive_time", "10", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_revive_time = CreateConVar("ttt_asc_min_revive_time", "2", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local need_corpse = CreateConVar("ttt_asc_need_corpse", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local max_start_pct = CreateConVar("ttt_asc_start_pct_max", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_start_pct = CreateConVar("ttt_asc_start_pct_min", "15", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local max_gain_pct = CreateConVar("ttt_asc_gain_pct_max", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_gain_pct = CreateConVar("ttt_asc_gain_pct_min", "15", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local max_lose_pct = CreateConVar("ttt_asc_lose_pct_max", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_lose_pct = CreateConVar("ttt_asc_lose_pct_min", "15", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local show_mstack_messages = CreateConVar("ttt_asc_mstack_messages", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local show_chat_messages = CreateConVar("ttt_asc_chat_messages", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local allow_key_respawn = CreateConVar("ttt_asc_allow_key_respawn", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local use_kill_history = CreateConVar("ttt_asc_use_kill_history", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})

A_SECOND_CHANCE.CVARS.max_revive_time = max_revive_time:GetFloat()
A_SECOND_CHANCE.CVARS.min_revive_time = min_revive_time:GetFloat()
A_SECOND_CHANCE.CVARS.need_corpse = need_corpse:GetBool()
A_SECOND_CHANCE.CVARS.max_start_pct = max_start_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_start_pct = min_start_pct:GetInt()
A_SECOND_CHANCE.CVARS.max_gain_pct = max_gain_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_gain_pct = min_gain_pct:GetInt()
A_SECOND_CHANCE.CVARS.max_lose_pct = max_lose_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_lose_pct = min_lose_pct:GetInt()
A_SECOND_CHANCE.CVARS.show_mstack_messages = show_mstack_messages:GetBool()
A_SECOND_CHANCE.CVARS.show_chat_messages = show_chat_messages:GetBool()
A_SECOND_CHANCE.CVARS.allow_key_respawn = allow_key_respawn:GetBool()
A_SECOND_CHANCE.CVARS.use_kill_history = use_kill_history:GetBool()

if SERVER then
  cvars.AddChangeCallback("ttt_asc_max_revive_time", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_revive_time = util.StringToType(new, "float")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_min_revive_time", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_revive_time = util.StringToType(new, "float")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_need_corpse", function(name, old, new)
    A_SECOND_CHANCE.CVARS.need_corpse = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_start_pct_max", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_start_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_start_pct_min", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_start_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_gain_pct_max", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_gain_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_gain_pct_min", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_gain_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_lose_pct_max", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_lose_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_lose_pct_min", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_lose_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_mstack_messages", function(name, old, new)
    A_SECOND_CHANCE.CVARS.show_mstack_messages = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_chat_messages", function(name, old, new)
    A_SECOND_CHANCE.CVARS.show_chat_messages = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_allow_key_respawn", function(name, old, new)
    A_SECOND_CHANCE.CVARS.allow_key_respawn = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_use_kill_history", function(name, old, new)
    A_SECOND_CHANCE.CVARS.use_kill_history = util.StringToType(new, "bool")
  end, nil)

  hook.Add("TTTUlxInitCustomCVar", "TTTASCInitCvars", function(name)
    ULib.replicatedWritableCvar("ttt_asc_max_revive_time", "rep_ttt_asc_max_revive_time", GetConVar("ttt_asc_max_revive_time"):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_min_revive_time", "rep_ttt_asc_min_revive_time", GetConVar("ttt_asc_min_revive_time"):GetFloat(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_need_corpse", "rep_ttt_asc_need_corpse", GetConVar("ttt_asc_need_corpse"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_start_pct_max", "rep_ttt_asc_start_pct_max", GetConVar("ttt_asc_start_pct_max"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_start_pct_min", "rep_ttt_asc_start_pct_min", GetConVar("ttt_asc_start_pct_min"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_gain_pct_max", "rep_ttt_asc_gain_pct_max", GetConVar("ttt_asc_gain_pct_max"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_gain_pct_min", "rep_ttt_asc_gain_pct_min", GetConVar("ttt_asc_gain_pct_min"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_lose_pct_max", "rep_ttt_asc_lose_pct_max", GetConVar("ttt_asc_lose_pct_max"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_lose_pct_min", "rep_ttt_asc_lose_pct_min", GetConVar("ttt_asc_lose_pct_min"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_mstack_messages", "rep_ttt_asc_mstack_messages", GetConVar("ttt_asc_mstack_messages"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_chat_messages", "rep_ttt_asc_chat_messages", GetConVar("ttt_asc_chat_messages"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_allow_key_respawn", "rep_ttt_asc_allow_key_respawn", GetConVar("ttt_asc_allow_key_respawn"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_use_kill_history", "rep_ttt_asc_use_kill_history", GetConVar("ttt_asc_use_kill_history"):GetInt(), true, false, name)
  end)

end

if CLIENT then

  hook.Add("TTTUlxModifyAddonSettings", "TTTASCModifySettings", function(name)
      local tttrspnl = xlib.makelistlayout{w = 415, h = 300, parent = xgui.null}
      --checkbox: +20, slider: +25
      local tttrsclp = vgui.Create("DCollapsibleCategory", tttrspnl)
      tttrsclp:SetSize(390, 300)
      tttrsclp:SetExpanded(1)
      tttrsclp:SetLabel('Second Chance Settings')

      local tttrslst = vgui.Create('DPanelList', tttrsclp)
      tttrslst:SetPos(5, 25)
      tttrslst:SetSize(390, 300)
      tttrslst:SetSpacing(5)
      tttrslst:EnableVerticalScrollbar()

      local slider1 = xlib.makeslider{label = 'ttt_asc_max_revive_time (Def. 10)', repconvar = 'rep_ttt_asc_max_revive_time', min = 0, max = 100, decimal = 1, parent = tttrslst}
  		tttrslst:AddItem(slider1)

  		local slider2 = xlib.makeslider{label = 'ttt_asc_min_revive_time (Def. 2)', repconvar = 'rep_ttt_asc_min_revive_time', min = 0, max = 100, decimal = 1, parent = tttrslst}
  		tttrslst:AddItem(slider2)

      local slider3 = xlib.makeslider{label = 'ttt_asc_start_pct_max (Def. 25)', repconvar = 'rep_ttt_asc_start_pct_max', min = 1, max = 100, decimal = 0, parent = tttrslst}
  		tttrslst:AddItem(slider3)

      local slider4 = xlib.makeslider{label = 'ttt_asc_start_pct_min (Def. 15)', repconvar = 'rep_ttt_asc_start_pct_min', min = 1, max = 100, decimal = 0, parent = tttrslst}
      tttrslst:AddItem(slider4)

      local slider5= xlib.makeslider{label = 'ttt_asc_gain_pct_max (Def. 25)', repconvar = 'rep_ttt_asc_gain_pct_max', min = 1, max = 100, decimal = 0, parent = tttrslst}
      tttrslst:AddItem(slider5)

      local slider6 = xlib.makeslider{label = 'ttt_asc_gain_pct_min (Def. 15)', repconvar = 'rep_ttt_asc_gain_pct_min', min = 1, max = 100, decimal = 0, parent = tttrslst}
      tttrslst:AddItem(slider6)

      local slider7= xlib.makeslider{label = 'ttt_asc_lose_pct_max (Def. 25)', repconvar = 'rep_ttt_asc_lose_pct_max', min = 1, max = 100, decimal = 0, parent = tttrslst}
      tttrslst:AddItem(slider7)

      local slider8 = xlib.makeslider{label = 'ttt_asc_lose_pct_min (Def. 15)', repconvar = 'rep_ttt_asc_lose_pct_min', min = 1, max = 100, decimal = 0, parent = tttrslst}
      tttrslst:AddItem(slider8)



      local checkbox1 = xlib.makecheckbox{label = "ttt_asc_need_corpse (Def. 1)", repconvar = "rep_ttt_asc_need_corpse", parent = tttrslst}
      tttrslst:AddItem(checkbox1)

      local checkbox2 = xlib.makecheckbox{label = "ttt_asc_mstack_messages (Def. 1)", repconvar = "rep_ttt_asc_mstack_messages", parent = tttrslst}
      tttrslst:AddItem(checkbox2)

      local checkbox3 = xlib.makecheckbox{label = "ttt_asc_chat_messages (Def. 1)", repconvar = "rep_ttt_asc_chat_messages", parent = tttrslst}
      tttrslst:AddItem(checkbox3)

      local checkbox4 = xlib.makecheckbox{label = "ttt_asc_allow_key_respawn (Def. 1)", repconvar = "rep_ttt_asc_allow_key_respawn", parent = tttrslst}
      tttrslst:AddItem(checkbox4)

      local checkbox5 = xlib.makecheckbox{label = "ttt_asc_use_kill_history (Def. 0)", repconvar = "rep_ttt_asc_use_kill_history", parent = tttrslst}
      tttrslst:AddItem(checkbox5)

      xgui.hookEvent('onProcessModules', nil, tttrspnl.processModules)
  		xgui.addSubModule('Second Chance', tttrspnl, nil, name)
    end)

end
