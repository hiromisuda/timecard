//
//  DetailTimeModel.swift
//  TimeCard
//
//  Created by works on 2020/06/10.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

class DetailTimeModel : Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var workTimeId: Int = 0
    @objc dynamic var memo: String = ""
    @objc dynamic var startDate: Date? = nil
    @objc dynamic var endDate: Date? = nil
    @objc dynamic var taskId: Int = 0
    @objc dynamic var createDate: Date? = nil
    @objc dynamic var updateDate: Date? = nil

    override static func primaryKey() -> String? {
        return "id"
    }
    
}
