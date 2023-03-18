//
//  WorkHourRepository.swift
//  TimeCard
//
//  Created by works on 2020/02/07.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

class WorkTimeRepository: CreateSerialNumber{
    var realm: Realm
    
    init() {
        self.realm = try! Realm()      
    }
    
    // 全件検索
    func findAll() -> Results<WorkTimeModel> {
      return realm.objects(WorkTimeModel.self)
    }
    
    // 条件指定
    func find(predicate: NSPredicate) -> Results<WorkTimeModel> {
      return realm.objects(WorkTimeModel.self).filter(predicate)
    }
    
    //指定したidに該当するModelを取得
    func findById(id:Int) -> WorkTimeModel{
        return realm.objects(WorkTimeModel.self).filter("id == \(id)").first!
    }
    
    func findByStartDate(from day: Date) -> Results<WorkTimeModel> {
        let result = realm.objects(WorkTimeModel.self).filter("startDate == %@", day)
        return result
    }
    
    //idの最大値を取得
    func getNewID() -> Int{
        return newId(model: WorkTimeModel())
    }
    
    // データ追加と更新
    func add(model: WorkTimeModel) {
        do{
            try! realm.write {
              realm.add(model, update: .modified)
            }

        } catch {
            print("データ追加更新でエラーが発生しました:\(error)")
            
        }
    }
    
    // データ削除
    func delete(model: WorkTimeModel) {
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

