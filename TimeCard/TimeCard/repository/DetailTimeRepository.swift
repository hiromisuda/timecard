//
//  DetailTimeRepository.swift
//  TimeCard
//
//  Created by works on 2020/06/10.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import RealmSwift

class DetailTimeRepository: CreateSerialNumber{
    var realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    // 全件検索
    func findAll() -> Results<DetailTimeModel> {
      return realm.objects(DetailTimeModel.self)
    }
    
    // 条件指定
    func find(predicate: NSPredicate) -> Results<DetailTimeModel> {
      return realm.objects(DetailTimeModel.self).filter(predicate)
    }
    
    //指定したidに該当するModelを取得
    func findById(id:Int) -> DetailTimeModel{
        return realm.objects(DetailTimeModel.self).filter("id == \(id)").first!
    }
    
    //idの最大値を取得
    func getNewID() -> Int{
        return newId(model: DetailTimeModel())
    }
    
    // データ追加と更新
    func add(model: DetailTimeModel) {
        do{
            try! realm.write {
              realm.add(model, update: .modified)
            }

        } catch {
            print("データ追加更新でエラーが発生しました:\(error)")
            
        }
    }
    
    // データ削除
    func delete(model: DetailTimeModel) {
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

