//
//  StartPointModel.swift
//  TimeCard
//
//  Created by works on 2020/02/07.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

/**
 TODO 次リリース
 基準時間
 */
class StartPointModel : Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var startPoint: Int = 0
    @objc dynamic var date: Date? = nil

    override static func primaryKey() -> String? {
        return "id"
    }
    
}
