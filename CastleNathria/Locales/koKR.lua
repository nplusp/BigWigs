local L = BigWigs:NewBossLocale("Shriekwing", "koKR")
if not L then return end
if L then
	 L.pickup_lantern = "%s 이(가) 등불을 들었습니다!"
	 L.dropped_lantern = " %s 이(가) 등불 떨어트림!"
end

L = BigWigs:NewBossLocale("Huntsman Altimor", "koKR")
if L then
	L.killed = "%s 죽음"
end

L = BigWigs:NewBossLocale("Hungering Destroyer", "koKR")
if L then
	L.miasma = "독기" -- Short for Gluttonous Miasma
end

L = BigWigs:NewBossLocale("Artificer Xy'mox", "koKR")
if L then
	L.stage2_yell = "이 유물을 써 보고 싶어서 숨이 멎을 뻔했답니다! 뭐, 당신네는 진짜로 멎겠지만."
	L.stage3_yell = "보기만큼 치명적인 물건이어야 할 텐데!"
	L.tear = "균열" -- Short for Dimensional Tear
	L.spirits = "영혼" -- Short for Fleeting Spirits
	L.seeds = "씨앗" -- Short for Seeds of Extinction
end

L = BigWigs:NewBossLocale("Lady Inerva Darkvein", "koKR")
if L then
	 L.times = "%dx %s"

	 L.level = "%s (Level |cffffff00%d|r)"
	 L.full = "%s (|cffff0000FULL|r)"

	 L.container_active = "활성화된 용기: %s"

	 L.anima_adds = "농축된 령 쫄"
	 L.anima_adds_desc = "농축된 령 쫄이 언제 생성되는 타이머 표시."

	-- L.custom_off_experimental = "Enable experimental features"
	-- L.custom_off_experimental_desc = "These features are |cffff0000not tested|r and could |cffff0000spam|r."

	-- L.anima_tracking = "Anima Tracking |cffff0000(Experimental)|r"
	-- L.anima_tracking_desc = "Messages and Bars to track anima levels in the containers.|n|cffaaff00Tip: You might want to disable the information box or bars, depending your preference."

	-- L.custom_on_stop_timers = "Always show ability bars"
	-- L.custom_on_stop_timers_desc = "Just for testing right now"

	 L.desires = "욕망"
	 L.bottles = "병에 담긴 령"
	 L.sins = "죄악"
end

L = BigWigs:NewBossLocale("The Council of Blood", "koKR")
if L then
	L.macabre_start_emote = "죽음의 무도를 위해 자신의 위치에 서야 합니다!" -- [RAID_BOSS_EMOTE] Take your places for the Danse Macabre!#Dance Controller#4#false"
	 L.custom_on_repeating_dark_recital = "어둠의 무도회 지속적으로 표시"
	 L.custom_on_repeating_dark_recital_desc = "지속적으로  {rt1}, {rt2}  로 표시를 해서 본인의 짝을 찾을수 있도록 표시."

	 L.custom_off_select_boss_order = "보스 킬 순서 표시"
	 L.custom_off_select_boss_order_desc = "보스를 잡을 순서를 {rt7} 로 표시. 부공대장 이상의 권한이 필요합니다."
	L.custom_off_select_boss_order_value1 = "니클라우스 -> 프리에다 -> 스타브로스"
	L.custom_off_select_boss_order_value2 = "프리에다 -> 니클라우스 -> 스타브로스"
	L.custom_off_select_boss_order_value3 = "스타브로스 -> 니클라우스 -> 프리에다"
	L.custom_off_select_boss_order_value4 = "니클라우스 -> 스타브로스 -> 프리에다"
	L.custom_off_select_boss_order_value5 = "프리에다 -> 스타브로스 -> 니클라우스"
	L.custom_off_select_boss_order_value6 = "스타브로스 -> 프리에다 -> 니클라우스"

	L.dance_assist = "춤 도우미"
	L.dance_assist_desc = "춤출때 방향 표시."
	L.dance_assist_up = "|T450907:0:0:0:0:64:64:4:60:4:60|t 앞으로 |T450907:0:0:0:0:64:64:4:60:4:60|t"
	L.dance_assist_right = "|T450908:0:0:0:0:64:64:4:60:4:60|t 오른쪽으로 |T450908:0:0:0:0:64:64:4:60:4:60|t"
	L.dance_assist_down = "|T450905:0:0:0:0:64:64:4:60:4:60|t 밑으로 |T450905:0:0:0:0:64:64:4:60:4:60|t"
	L.dance_assist_left = "|T450906:0:0:0:0:64:64:4:60:4:60|t 왼쪽으로 |T450906:0:0:0:0:64:64:4:60:4:60|t"
	-- These need to match the in-game boss yells
	L.dance_yell_up = "앞으로" -- Prance Forward!
	L.dance_yell_right = "오른쪽으로" -- Shimmy right!
	L.dance_yell_down = "밑으로" -- Boogie down!
	L.dance_yell_left = "왼쪽으로" -- Sashay left!
end

L = BigWigs:NewBossLocale("Sludgefist", "koKR")
if L then
	 L.stomp_shift = "발구르기 & 지진" -- Destructive Stomp + Seismic Shift

	 L.fun_info = "데미지 표시"
	 L.fun_info_desc = "파괴의 충격 중 얼마나 체력을 많이 뺐는가를 메세지로 표시."

	 L.health_lost = "진흙주먹이 피 %.1f%% 만큼 깎았습니다!"
end

L = BigWigs:NewBossLocale("Stone Legion Generals", "koKR")
if L then
	 L.first_blade = "첫번째 칼날"
	 L.second_blade = "두번째 칼날"

	 L.skirmishers = "척후병" -- Short for Stone Legion Skirmishers

	-- L.custom_on_stop_timers = "Always show ability bars"
	-- L.custom_on_stop_timers_desc = "Just for testing right now"
end

L = BigWigs:NewBossLocale("Sire Denathrius", "koKR")
if L then
	--L.add_spawn = "Crimson Cabalists answer the call of Denathrius." -- [RAID_BOSS_EMOTE] Crimson Cabalists answer the call of Denathrius.#Sire Denathrius#4#true"

	L.infobox_stacks = "%d 중첩: %d 명" -- 4 Stacks: 5 players // 1 Stack: 1 player

	--L.custom_on_repeating_nighthunter = "Repeating Night Hunter Yell"
	--L.custom_on_repeating_nighthunter_desc = "Repeating yell messages for the Night Hunter ability using icons {rt1} or {rt2} or {rt3} to find your line easier if you have to soak."

	--L.custom_on_repeating_impale = "Repeating Impale Say"
	--L.custom_on_repeating_impale_desc = "Repeating say messages for the Impale ability using '1' or '22' or '333' or '4444' to make it clear in what order you will be hit."

	-- L.hymn_stacks = "Nathrian Hymn"
	-- L.hymn_stacks_desc = "Alerts for the amount of Nathrian Hymn stacks currently on you."

	-- L.ravage_target = "Reflection: Ravage Target Cast Bar"
	-- L.ravage_target_desc = "Cast bar showing the time until the reflection targets a location for Ravage."
	-- L.ravage_targeted = "Ravage Targeted" -- Text on the bar for when Ravage picks its location to target in stage 3

	 L.no_mirror = "거울 없음: %d" -- Player amount that does not have the Through the Mirror
	 L.mirror = "거울: %d" -- Player amount that does have the Through the Mirror
end
