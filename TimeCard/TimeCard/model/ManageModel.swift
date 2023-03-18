//
//  ManageModel.swift
//  TimeCard
//
//  Created by works on 2020/02/07.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

/**
 管理系
 */
class ManageModel : Object{
    @objc dynamic var id: Int = 0
    
    //0:労働してない、1:労働中、2:休憩中
    @objc dynamic var status: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }
    
}

