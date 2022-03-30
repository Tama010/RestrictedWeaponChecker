-- 特定の兵装を装備した機体が離陸したときに強制排除するスクリプト
RestrictWeaponScript = {}

-- 禁止兵器リスト（デフォルトは核爆弾）
local _prohibitedWeaponList = {
    "weapons.bombs.RN-28",
    "weapons.bombs.RN-24",
}

function RestrictWeaponScript:onEvent(event)
		
	if event.id == world.event.S_EVENT_TAKEOFF then -- 離陸を検知

        -- trigger.action.outText("take off", 10, false)
        -- 離陸した機体の武装を取得
        local _unit = event.initiator
        local _ammo = _unit:getAmmo()

        if _ammo then
            for _i, _weapon in pairs(_ammo) do
                --trigger.action.outText("搭載兵器：".. _weapon.desc.typeName,10,false)
                if isProhibitedWeapon(_weapon) then
                    _unit:destroy()
                    return
                end
            end
        end
	end

    -- 禁止された兵器であるか判定
    function isProhibitedWeapon(_weapon)

        for _, _prohibitedWeapon in pairs(_prohibitedWeaponList) do
            if _prohibitedWeapon ==  _weapon.desc.typeName then
                return true
            end
        end
        
        return false
    end
end
    
world.addEventHandler(RestrictWeaponScript)