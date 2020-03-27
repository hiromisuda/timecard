//
//  ManageModel.swift
//  TimeCard
//
//  Created by works on 2020/02/07.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

class ManageModel : Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var status: Int = 0
    @objc dynamic var isStartPointIndividually: Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }
    
}

