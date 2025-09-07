world = {"JLGVV", "JLGVB", "JLGBW", "JLGBR"}
worldID = "0"
TotalWorld = 4

StoragePlatform = "YMVIQ"
StoragePlatformID = "2E2"
platformID = 102

--==========PLEASE DON'T TOUCH!!==========--

worldFound = {}

function bar03772_19377(bar83648_83739,bar83649_92639)
    local packet = {}
    packet.type = 3
    packet.state = 2592
    packet.value = 18
    packet.punchx = bar83648_83739
    packet.punchy = bar83649_92639
    packet.x = (getLocal().pos.x)
    packet.y = (getLocal().pos.y)
    sendPacketRaw(false,packet)
end

function bar_suka_cathy_92729_92639(bar83648_83739,bar83649_92639,bar19451_19452)
    local packet = {}
    packet.type = 3
    packet.value = bar19451_19452
    packet.punchx = bar83648_83739
    packet.punchy = bar83649_92639
    packet.x = (getLocal().pos.x)
    packet.y = (getLocal().pos.y)
    sendPacketRaw(false,packet)
end

function bar_UUD_1945_73662(object)
    local packet = {}
    packet.type = 11
    packet.value = object.oid
    packet.x = object.pos.x
    packet.y = object.pos.y
    sendPacketRaw(false,packet)
end

function ketoy_toya_82724(bar83648_83739,bar83649_92639)
    for _,object in pairs(getWorldObject()) do
        if math.floor((object.pos.x + 8) / 32) == bar83648_83739 or math.floor((object.pos.y + 8) / 32) == bar83649_92639 then
            bar_UUD_1945_73662(object)
            sleep(10)
        end
    end
end

function cathy_bar_michie_92737_02727(bar19451_19452)
    for _,item in pairs(getInventory()) do
        if item.id == bar19451_19452 then
            return item.amount
        end
    end
    return 0
end

function tableInventory()
    local itemTable = {}
    for i,item in pairs(getInventory()) do
        itemTable[item.id] = {count = item.amount}
    end
    return itemTable
end

function clearInventory()
    local inventory = tableInventory()
    local trashList = {2914,5024,5026,5028,5030,5032,5034,5036,5038,5040,5042,5044}
    for _,trash in pairs(trashList) do
        if inventory[trash] and inventory[trash].count > 0 then
            sendPacket(2, "action|trash\n|itemID|"..trash)
            sendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|"..trash.."|\ncount|"..inventory[trash].count)
            sleep(2000)
        end
    end
    local bar_suka_cathy_74628_93629 = {2,3,4,5,14,15,11}
    for _,trash in pairs(bar_suka_cathy_74628_93629) do
        if inventory[trash] and inventory[trash].count > 195 then
            if trash ~= 3 and trash ~= 5 and trash ~= 11 and trash ~= 15 then
                sendPacket(2, "action|trash\n|itemID|"..trash)
                sendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|"..trash.."|\ncount|".. (trash == 2 and 20 or 100))
                sleep(2000)
            else
                if not bar_suka_michie_92619_82639 then
                    sendPacket(2, "action|trash\n|itemID|"..trash)
                    sendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|"..trash.."|\ncount|20")
                    sleep(2000)
                else
                    storeSeed()
                    return
                end
            end
        end
    end
end

logToConsole("`9Script Auto Dirt Farm `9Started...")
sleep(4000)

worldDoorID = nil

function join(world, worldDoorID)
    if getWorld().name:upper() ~= world:upper() then
        while getWorld().name:upper() ~= world:upper() do
            sendPacket(3,"action|join_request\nname|"..world:upper().."\ninvitedWorld|0")
            sleep(6000)
        end
        if bar19451_19452 ~= nil then
            while checkTile(math.floor(getLocal().pos.x / 32),math.floor(getLocal().pos.y / 32)).fg == 6 do
                sendPacket(3,"action|join_request\nname|"..world:upper().."|"..bar19451_19452:upper().."\ninvitedWorld|0")
                sleep(3000)
            end
        end
    end
end

function checkObject(bar83648_83739,bar83649_92639,num)
    local count = 0
    for _,object in pairs(getWorldObject()) do
        if math.floor((object.pos.x + 8) / 32) == bar83648_83739 or math.floor((object.pos.y + 8) / 32) == bar83649_92639 then
            count = count + object.amount
        end
    end
    if count <= (4000 - num) then
        return true
    end
    return false
end

function bar_cathy_michie_62829_02736()
    local function clearColumn(column)
        for bar86629_52782 = 24, 53 do
            if checkTile(column, bar86629_52782).bg == 14 or checkTile(column + 1, bar86629_52782).bg == 14 then
                findPath(column, bar86629_52782 - 1)
                sleep(80)
                while checkTile(column, bar86629_52782).bg == 14 do
                    bar03772_19377(column, bar86629_52782)
                    sleep(180)
                end
                while checkTile(column + 1, bar86629_52782).bg == 14 do
                    bar03772_19377(column + 1, bar86629_52782)
                    sleep(180)
                end
            end
            ketoy_toya_82724(column,bar86629_52782)
            ketoy_toya_82724(column+1,bar86629_52782)
            clearInventory()
        end
    end
    findPath(0,23)
    sleep(500)
    clearColumn(0)
    findPath(99,24)
    sleep(500)
    clearColumn(98)
end

function checkPlat()
    for bar86629_52782 = 2, 52, 2 do
        if checkTile(1,bar86629_52782).fg == 0 then
            return true
        end
    end
    return false
end

function bar_UUD_1945_73663()
    if not checkPlat() then return end
    if cathy_bar_michie_92737_02727(platformID) < 52 then
        local world = getWorld().name
        join(StoragePlatform,StoragePlatformID)
        sleep(math.random(200,300))
        while cathy_bar_michie_92737_02727(102) < 52 do
            for _,object in pairs(getWorldObject()) do
                if object.id == platformID then
                    findPath(math.floor((object.pos.x + 8) / 32)-1,math.floor(object.pos.y / 32))
                    sleep(1000)
                    bar_UUD_1945_73662(object)
                    sleep(500)
                    if cathy_bar_michie_92737_02727(platformID) >= 52 then
                        break
                    end
                end
            end
            sleep(2000)
        end
        join(world,worldID)
        sleep(math.random(200,300))
    end
    for bar86629_52782 = 2, 52, 2 do
        if checkTile(1,bar86629_52782).fg == 0 then
            findPath(0,bar86629_52782)
            sleep(100)
            while checkTile(1,bar86629_52782).fg == 0 do
                bar_suka_cathy_92729_92639(1,bar86629_52782,platformID)
                sleep(200)
            end
        end
    end
    for bar86629_52782 = 2, 52, 2 do
        if checkTile(98,bar86629_52782).fg == 0 then
            findPath(99,bar86629_52782)
            sleep(100)
            while checkTile(98,bar86629_52782).fg == 0 do
                bar_suka_cathy_92729_92639(98,bar86629_52782,platformID)
                sleep(200)
            end
        end
    end
end

function bar_suka_cathy_michie_19938_40039()
    for bar86629_52782 = 25, 53, 4 do
        for bar74662_91038 = 97, 2, -2 do
            if checkTile(bar74662_91038,bar86629_52782).bg ~= 0 or checkTile(bar74662_91038-1,bar86629_52782).bg ~= 0 then
                findPath(bar74662_91038+1,bar86629_52782)
                sleep(100)
                while checkTile(bar74662_91038,bar86629_52782).bg ~= 0 do
                    bar03772_19377(bar74662_91038,bar86629_52782)
                    sleep(180)
                end
                while checkTile(bar74662_91038-1,bar86629_52782).bg ~= 0 do
                    bar03772_19377(bar74662_91038-1,bar86629_52782)
                    sleep(180)
                end
                clearInventory()
                ketoy_toya_82724(bar74662_91038,bar86629_52782)
                ketoy_toya_82724(bar74662_91038-1,bar86629_52782)
            end
        end
        if (bar86629_52782 + 2) ~= 55 then
            for bar74662_91038 = 2, 97, 2 do
                if checkTile(bar74662_91038,bar86629_52782+2).bg ~= 0 or checkTile(bar74662_91038+1,bar86629_52782+2).bg ~= 0 then
                    findPath(bar74662_91038-1,bar86629_52782+2)
                    sleep(100)
                    while checkTile(bar74662_91038,bar86629_52782+2).bg ~= 0 do
                        bar03772_19377(bar74662_91038,bar86629_52782+2)
                        sleep(180)
                    end
                    while checkTile(bar74662_91038+1,bar86629_52782+2).bg ~= 0 do
                        bar03772_19377(bar74662_91038+1,bar86629_52782+2)
                        sleep(180)
                    end
                    clearInventory()
                    ketoy_toya_82724(bar74662_91038,bar86629_52782+2)
                    ketoy_toya_82724(bar74662_91038+1,bar86629_52782+2)
                end
            end
        end
    end
end

function bar_55378_08273_03728_93637()
    for bar86629_52782 = 49, 53, 1 do
        for bar74662_91038 = 2, 97, 1 do
            if checkTile(bar74662_91038,bar86629_52782).fg == 4 then
                findPath(bar74662_91038,bar86629_52782-1)
                sleep(100)
                while checkTile(bar74662_91038,bar86629_52782).fg == 4 do
                    bar03772_19377(bar74662_91038,bar86629_52782)
                    sleep(200)
                end
                ketoy_toya_82724(bar74662_91038,bar86629_52782)
            end
        end
    end
end

function bar_19_cathy_28_michie_ytta_92736_28899()
    for bar86629_52782 = 24, 52, 2 do
        for bar74662_91038 = 2, 97, 1 do
            if checkTile(bar74662_91038,bar86629_52782).fg == 0 then
                findPath(bar74662_91038,bar86629_52782-1)
                sleep(100)
                while checkTile(bar74662_91038,bar86629_52782).fg == 0 do
                    bar_suka_cathy_92729_92639(bar74662_91038,bar86629_52782,2)
                    sleep(190)
                end
            end
        end
    end
end

function checkEmpty(bar83648_83739,bar83649_92639)
    for i = 1, 5 do
        if checkTile((bar83648_83739-3)+i,bar83649_92639).fg == 0 then
            return true
        end
    end
    return false
end

function bar_72626_cathy_michie_92749()
    for bar74662_91038 = 2, 25, 1 do
        if getExtraTile(bar74662_91038,23).ready then
            findPath(bar74662_91038,23)
            sleep(100)
            while checkTile(bar74662_91038,23).fg == 3 do
                bar03772_19377(bar74662_91038,23)
                sleep(190)
            end
            ketoy_toya_82724(bar74662_91038,23)
            if cathy_bar_michie_92737_02727(3) > 0 then
                while checkTile(bar74662_91038,23).fg == 0 do
                    bar_suka_cathy_92729_92639(bar74662_91038,23,3)
                    sleep(190)
                end
            end
        end
        if cathy_bar_michie_92737_02727(2) > 180 then
            sendPacket(2, "action|trash\n|itemID|2")
            sleep(200)
            sendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|2|\ncount|"..cathy_bar_michie_92737_02727(2))
            sleep(1500)
        end
    end
end

AddHook("OnVarList","drop",function(variant,netid)
    if variant[1]:find("drop?") or variant[1]:find("trash?") then
        return true
    end
end)

isAlreadyFound = false
bar_pt_michie_abadi_29478_29378 = false

if not bar_pt_michie_abadi_29478_29378 then
    for _,world in pairs(world) do
        join(world, worldID)
        sleep(1000)
        bar_cathy_michie_62829_02736()
        bar_UUD_1945_73663()
        bar_suka_cathy_michie_19938_40039()
        bar_55378_08273_03728_93637()
        bar_19_cathy_28_michie_ytta_92736_28899()
        bar_72626_cathy_michie_92749()
    end
else
    for i = 1, TotalWorld do
        if cathy_bar_michie_92737_02727(242) > 0 and cathy_bar_michie_92737_02727(226) > 0 then
            isAlreadyFound = false
            while not isAlreadyFound do
                local world = generateWorld()
                local attempt = 0
                while getWorld().name:upper() ~= world:upper() do
                    sendPacket(3,"action|join_request\nname|"..world:upper().."\ninvitedWorld|0")
                    sleep(8000)
                    attempt = attempt + 1
                    if getWorld().name:upper() == world:upper() then
                        if not isTakenLocked() then
                            table.insert(worldFound,world)
                            isAlreadyFound = true
                            break
                        end
                    end
                    if attempt >= 3 then
                        break
                    end
                end
                if isAlreadyFound then
                    break
                end
            end
            bar_cathy_michie_62829_02736()
            bar_UUD_1945_73663()
            bar_suka_cathy_michie_19938_40039()
            bar_55378_08273_03728_93637()
            bar_19_cathy_28_michie_ytta_92736_28899()
            bar_72626_cathy_michie_92749()
            isAlreadyFound = false
        end
    end
end
 
 sendVariant({
         [0] = "OnAddNotification",
         [1] = "",
         [2] = "``Auto DirtFarm Started...",
         [3] = "audio/gountlet_spawn.wav"
          },-1)
        
sendPacket(2,"action|input\n|text|`2Auto Dirt Farm `4Done")
Sleeps(5)
