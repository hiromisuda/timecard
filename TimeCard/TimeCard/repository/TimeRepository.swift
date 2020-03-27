//
//  TimeRepository.swift
//  TimeCard
//
//  Created by works on 2019/12/31.
//  Copyright © 2019 pupuplanet. All rights reserved.
//

import Foundation
import RealmSwift

class TimeRepository: CreateSerialNumber{
    var realm: Realm
    
    init() {
        do{
            self.realm = try! Realm()
        } catch {
            print("Realm初期化でエラーが発生しました:\(error)")
        }
      
    }
    
    // 全件検索
    func findAll() -> Results<TimeModel> {
      return realm.objects(TimeModel.self)
    }
    
    // 条件指定
    func find(predicate: NSPredicate) -> Results<TimeModel> {
      return realm.objects(TimeModel.self).filter(predicate)
    }
    
    //指定したidに該当するModelを取得
    func findById(id:Int) -> TimeModel{
        return realm.objects(TimeModel.self).filter("id == \(id)").first!
    }
    
    //idの最大値を取得
    func getNewID() -> Int{
        return newId(model: TimeModel())
    }
    
    // データ追加と更新
    func add(timeModel: TimeModel) {
        do{
            try! realm.write {
              realm.add(timeModel, update: .modified)
            }

        } catch {
            print("データ追加更新でエラーが発生しました:\(error)")
            
        }
    }
    
    // データ削除
    func delete(timeModel: TimeModel) {
        do{
            try! realm.write {
              realm.delete(timeModel)
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
