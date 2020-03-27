//
//  TaskModel.swift
//  TimeCard
//
//  Created by works on 2020/02/07.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

class TaskModel : Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var createDate: Date? = nil
    @objc dynamic var updateDate: Date? = nil

    override static func primaryKey() -> String? {
        return "id"
    }
    
}
