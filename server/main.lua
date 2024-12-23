local function GetPlayer(identifier, notifySource)
    if tonumber(identifier) then
        return exports.qbx_core:GetPlayer(identifier)
    else
        return exports.qbx_core:GetPlayerByCitizenId(identifier)
    end
    lib.notify(notifySource, {description = "Jogador nao encontrado.", type = "error", duration = 5000})
    return false
end

local function AddCitizenship(citizenId, identifier)
    local status, err = pcall(MySQL.insert.await, "INSERT INTO `mri_qwhitelist` (citizen) VALUES (?)", {citizenId})

    if status then
        return true
    end
    print(string.format("identifier: %s", identifier))
    print(err)
    return false
end

local function RemoveCitizenship(citizenId, identifier)
    local status, err = pcall(MySQL.update.await, "DELETE FROM `mri_qwhitelist` WHERE `citizen` = ?", {citizenId})

    if status then
        return true
    end
    print(string.format("identifier: %s", identifier))
    print(err)
    return false
end

local function GetConfig()
    local SELECT_DATA = "SELECT * FROM mri_qwhitelistcfg"
    local result = MySQL.Sync.fetchAll(SELECT_DATA, {})
    if not result or #result == 0 then
        return false
    end
    Config = json.decode(result[1].config)
end

local function SetConfig(data)
    local INSER_DATA = "INSERT INTO `mri_qwhitelistcfg` (id, config) VALUES (?, ?) ON DUPLICATE KEY UPDATE `config` = ?"
    local result = MySQL.Sync.execute(INSER_DATA, {1, data, data})
    print(json.encode(result))
end

local function SetPlayerBucket(target, bucket)
    exports.qbx_core:SetPlayerBucket(target, bucket)
end

local function Initialize()

    local success, result = pcall(MySQL.scalar.await, "SELECT 1 FROM mri_qwhitelist")

    if not success then
        MySQL.query(
            [[CREATE TABLE IF NOT EXISTS `mri_qwhitelist` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `citizen` VARCHAR(50) NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `citizen` (`citizen`)
        )]]
        )
        print("[mri_Qbox] Deployed database table for mri_qwhitelist")
    end

    success, result = pcall(MySQL.scalar.await, "SELECT 1 FROM mri_qwhitelistcfg")

    if not success then
        MySQL.query.await(
            [[CREATE TABLE IF NOT EXISTS `mri_qwhitelistcfg` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `config` LONGTEXT NOT NULL,
        PRIMARY KEY (`id`)
        )]]
        )
        print("[mri_Qbox] Deployed database table for mri_qwhitelistcfg")
    end

    GetConfig()
end

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
      Initialize()
   end
end)

lib.callback.register(
    "mri_Qwhitelist:getConfig",
    function(source)
        return Config
    end
)

lib.callback.register(
    "mri_Qwhitelist:saveConfig",
    function(source, data)
        SetConfig(json.encode(data))
        Config = data
        print("[mri_Qwhitelist] Config saved")
        return true
    end
)

lib.callback.register(
    "mri_Qwhitelist:checkCitizenship",
    function(source)
        local playerBucket = 1000 + source
        exports.qbx_core:SetPlayerBucket(source, playerBucket)
        local player = exports.qbx_core:GetPlayer(source)
        local citizenid = player.PlayerData.citizenid
        local row = MySQL.single.await("SELECT * FROM `mri_qwhitelist` WHERE `citizen` = ? LIMIT 1", {citizenid})
        if row then
            exports.qbx_core:SetPlayerBucket(source, 0)
            return true
        end
        return false
    end
)

lib.callback.register(
    "mri_Qwhitelist:addCitizenship",
    function(source, identifier)

        local player = GetPlayer(identifier or source, identifier and source or nil)
        if not player then
            return false
        end

        local status = AddCitizenship(player.PlayerData.citizenid, identifier or source)
        if not status then
            if identifier then
                lib.notify(source, {description = "Erro ao liberar player, verifique o console para mais informações.", type = "error", duration = 5000})
            end
            return status
        end

        SetPlayerBucket(player.PlayerData.source, 0)
        return status
    end
)

lib.callback.register(
    "mri_Qwhitelist:removeCitizenship",
    function(source, identifier)

        local player = GetPlayer(identifier)
        if not player then
            return false
        end
        print('has player')

        local status = RemoveCitizenship(player.PlayerData.citizenid, identifier)
        if not status then
            lib.notify(source, {description = "Erro ao revogar whitelist, verifique o console para mais informações.", type = "error", duration = 5000})
        end

        return status
    end
)
