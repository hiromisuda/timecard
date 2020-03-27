//
//  WorkHourModel.swift
//  TimeCard
//
//  Created by works on 2020/02/05.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

class WorkHourModel : Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var memo: String = ""
    @objc dynamic var startDate: Date? = nil
    @objc dynamic var endDate: Date? = nil
    @objc dynamic var createDate: Date? = nil
    @objc dynamic var updateDate: Date? = nil

    override static func primaryKey() -> String? {
        return "id"
    }
    
}
