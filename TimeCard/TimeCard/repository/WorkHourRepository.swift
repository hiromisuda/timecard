//
//  WorkHourRepository.swift
//  TimeCard
//
//  Created by works on 2020/02/07.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

class WorkHourRepository: CreateSerialNumber{
    var realm: Realm
    
    init() {
        self.realm = try! Realm()      
    }
    
    // 全件検索
    func findAll() -> Results<WorkHourModel> {
      return realm.objects(WorkHourModel.self)
    }
    
    // 条件指定
    func find(predicate: NSPredicate) -> Results<WorkHourModel> {
      return realm.objects(WorkHourModel.self).filter(predicate)
    }
    
    //指定したidに該当するModelを取得
    func findById(id:Int) -> WorkHourModel{
        return realm.objects(WorkHourModel.self).filter("id == \(id)").first!
    }
    
    //idの最大値を取得
    func getNewID() -> Int{
        return newId(model: WorkHourModel())
    }
    
    // データ追加と更新
    func add(model: WorkHourModel) {
        do{
            try! realm.write {
              realm.add(model, update: .modified)
            }

        } catch {
            print("データ追加更新でエラーが発生しました:\(error)")
            
        }
    }
    
    // データ削除
    func delete(model: WorkHourModel) {
        do{
            try! realm.write {
              realm.delete(model)
            }
        } catch {
            print("データ削除でエラーが発生しました:\(error)")
        }

    }
    
    // トランザクション
    func transaction(_ transactionBlock: () -> Void) {
      try! realm.write {
        transactionBlock()
      }
    }
    
    
}

