//
//  StartPointRepository.swift
//  TimeCard
//
//  Created by works on 2020/02/07.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

/**
TODO 次リリース
*/
class StartPointRepository: CreateSerialNumber{
    var realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    // 全件検索
    func findAll() -> Results<StartPointModel> {
      return realm.objects(StartPointModel.self)
    }
    
    // 条件指定
    func find(predicate: NSPredicate) -> Results<StartPointModel> {
      return realm.objects(StartPointModel.self).filter(predicate)
    }
    
    //指定したidに該当するModelを取得
    func findById(id:Int) -> StartPointModel{
        return realm.objects(StartPointModel.self).filter("id == \(id)").first!
    }
    
    //idの最大値を取得
    func getNewID() -> Int{
        return newId(model: StartPointModel())
    }
    
    // データ追加と更新
    func add(model: StartPointModel) {
        do{
            try! realm.write {
              realm.add(model, update: .modified)
            }

        } catch {
            print("データ追加更新でエラーが発生しました:\(error)")
            
        }
    }
    
    // データ削除
    func delete(model: StartPointModel) {
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
