local L = BigWigs:NewBossLocale("Shriekwing", "zhCN")
if not L then return end
if L then
	L.pickup_lantern = "%s 捡起了灯笼！"
	L.dropped_lantern = "%s 丢掉了灯笼!"
end

L = BigWigs:NewBossLocale("Huntsman Altimor", "zhCN")
if L then
	L.killed = "%s 已击杀"
end

L = BigWigs:NewBossLocale("Hungering Destroyer", "zhCN")
if L then
	L.miasma = "瘴气" -- Short for Gluttonous Miasma
end

L = BigWigs:NewBossLocale("Artificer Xy'mox", "zhCN")
if L then
	L.stage2_yell = "我一直想玩玩这件圣物，都快想疯了！而你们的死，可以填补我多年的空虚。"
	L.stage3_yell = "如此美妙的东西，如果没有杀伤力就太可惜了！"
	L.tear = "撕裂" -- Short for Dimensional Tear
	L.spirits = "灵魂" -- Short for Fleeting Spirits
	L.seeds = "种" -- Short for Seeds of Extinction
end

L = BigWigs:NewBossLocale("Lady Inerva Darkvein", "zhCN")
if L then
	L.times = "%d层 %s"

	L.level = "%s（等级 |cffffff00%d|r）"
	L.full = "%s（|cffff0000满|r）"

	L.container_active = "启用容器：%s"

	L.anima_adds = "浓缩心能增援"
	L.anima_adds_desc = "当浓缩心能负面效果刷新增援时显示一个计时器。"

	L.custom_off_experimental = "启用实验性功能"
	L.custom_off_experimental_desc = "此功能|cffff0000未测试|r并可能|cffff0000刷屏|r。"

	L.anima_tracking = "心能追踪|cffff0000（实验性）|r"
	L.anima_tracking_desc = "追踪容器的心能等级的信息和计时条。|n|cffaaff00提示：可能要禁用信息盒或计时条，根据配置。"

	L.custom_on_stop_timers = "总是显示技能条"
	L.custom_on_stop_timers_desc = "只是为了马上测试"

	L.desires = "欲望"
	L.bottles = "瓶子"
	L.sins = "罪孽"
end

L = BigWigs:NewBossLocale("The Council of Blood", "zhCN")
if L then
	L.macabre_start_emote = "找到你的位置，准备开始断魂之舞！" -- [RAID_BOSS_EMOTE] Take your places for the Danse Macabre!#Dance Controller#4#false"
	L.custom_on_repeating_dark_recital = "重复黑暗伴舞"
	L.custom_on_repeating_dark_recital_desc = "重复黑暗伴舞喊话信息使用 {rt1}，{rt2} 图标，和伙伴共舞。"

	L.custom_off_select_boss_order = "标记首领击杀顺序"
	L.custom_off_select_boss_order_desc = "使用叉子 {rt7} 标记团队首领击杀顺序。需要权限。"
	L.custom_off_select_boss_order_value1 = "堡主 -> 男爵 -> 勋爵"
	L.custom_off_select_boss_order_value2 = "女男爵 -> 堡主 -> 勋爵"
	L.custom_off_select_boss_order_value3 = "勋爵 -> 堡主 -> 女男爵"
	L.custom_off_select_boss_order_value4 = "堡主 -> 勋爵 -> 女男爵"
	L.custom_off_select_boss_order_value5 = "女男爵 -> 勋爵 -> 堡主"
	L.custom_off_select_boss_order_value6 = "勋爵 -> 女男爵 -> 堡主"

	L.dance_assist = "跳舞助手"
	L.dance_assist_desc = "显示舞台的定向警报。"
	L.dance_assist_up = "|T450907:0:0:0:0:64:64:4:60:4:60|t 向前跳 |T450907:0:0:0:0:64:64:4:60:4:60|t"
	L.dance_assist_right = "|T450908:0:0:0:0:64:64:4:60:4:60|t 向右跳 |T450908:0:0:0:0:64:64:4:60:4:60|t"
	L.dance_assist_down = "|T450905:0:0:0:0:64:64:4:60:4:60|t 向后跳 |T450905:0:0:0:0:64:64:4:60:4:60|t"
	L.dance_assist_left = "|T450906:0:0:0:0:64:64:4:60:4:60|t 向左跳 |T450906:0:0:0:0:64:64:4:60:4:60|t"
	-- These need to match the in-game boss yells
	L.dance_yell_up = "前阔步" -- Prance Forward!
	L.dance_yell_right = "右摆步" -- Shimmy right!
	L.dance_yell_down = "后摇步" -- Boogie down!
	L.dance_yell_left = "左滑步" -- Sashay left!
end

L = BigWigs:NewBossLocale("Sludgefist", "zhCN")
if L then
	L.stomp_shift = "踩踏和位移" -- Destructive Stomp + Seismic Shift

	L.fun_info = "伤害信息"
	L.fun_info_desc = "显示一个毁灭冲击期间损失了多少血量的信息。"

	L.health_lost = "泥拳倒下 %.1f%%！"
end

L = BigWigs:NewBossLocale("Stone Legion Generals", "zhCN")
if L then
	L.first_blade = "第一刀"
	L.second_blade = "第二刀"

	L.skirmishers = "散兵" -- Short for Stone Legion Skirmishers

	L.custom_on_stop_timers = "总是显示技能条"
	L.custom_on_stop_timers_desc = "为了马上测试"
end

L = BigWigs:NewBossLocale("Sire Denathrius", "zhCN")
if L then
	L.add_spawn = "赤红秘法师回应了德纳修斯的召唤。" -- [RAID_BOSS_EMOTE] Crimson Cabalists answer the call of Denathrius.#Sire Denathrius#4#true"

	L.infobox_stacks = "%d 堆叠：%d 玩家" -- 4 Stacks: 5 players // 1 Stack: 1 player

	L.custom_on_repeating_nighthunter = "重复午夜猎手喊话"
	L.custom_on_repeating_nighthunter_desc = "使用 {rt1}、{rt2}、{rt3} 图标重复午夜猎手技能喊话信息让你找线更容易。"

	L.custom_on_repeating_impale = "重复穿刺说话"
	L.custom_on_repeating_impale_desc = "使用“1”、“22”、“333”、“4444”重复穿刺技能说话信息让你清楚击中顺序。"

	L.hymn_stacks = "纳斯利亚赞歌"
	L.hymn_stacks_desc = "你的纳斯利亚赞歌当前堆叠层数警报。"

	L.ravage_target = "镜像：毁灭目标施放条"
	L.ravage_target_desc = "计时条显示时间直到镜像目标位置毁灭。"
	L.ravage_targeted = "毁灭已目标" -- Text on the bar for when Ravage picks its location to target in stage 3

	L.no_mirror = "没镜子：%d" -- Player amount that does not have the Through the Mirror
	L.mirror = "镜子：%d" -- Player amount that does have the Through the Mirror
end
