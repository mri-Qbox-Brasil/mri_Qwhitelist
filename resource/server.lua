local success, result = pcall(MySQL.scalar.await, 'SELECT 1 FROM mri_qwhitelist')

if not success then
    MySQL.query([[CREATE TABLE IF NOT EXISTS `mri_qwhitelist` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `citizen` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `citizen` (`citizen`)
    )]])
    print('[mri_Qbox] Deployed database table for mri_qwhitelist')
end

lib.callback.register('mri_Qwhitelist:checkCitizenship', function(source)
    local randomBucket = 1000 + source
    exports.qbx_core:SetPlayerBucket(source, randomBucket)
    local player = exports.qbx_core:GetPlayer(source)
    local citizenid = player.PlayerData.citizenid
    local isCitizen = false
    local row = MySQL.single.await('SELECT * FROM `mri_qwhitelist` WHERE `citizen` = ? LIMIT 1', {citizenid})
    if row then
        exports.qbx_core:SetPlayerBucket(source, 0)
        isCitizen = true
    end
    return isCitizen
end)

lib.callback.register('mri_Qwhitelist:addCitizenship', function(source)
    local player = exports.qbx_core:GetPlayer(source)
    local citizenid = player.PlayerData.citizenid
    local id = MySQL.insert.await('INSERT INTO `mri_qwhitelist` (citizen) VALUES (?)', {citizenid})
    exports.qbx_core:SetPlayerBucket(source, 0)
    return id
end)
