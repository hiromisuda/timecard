//
//  AppDelegate.swift
//  TimeCard
//
//  Created by works on 2019/12/11.
//  Copyright © 2019 pupuplanet. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print("Realm初期化")
        
        //Realmのマイグレーション対応
        if(!self.realmMigration(isProduct:false)){
            //TODO エラー処理
        }
        
        //Realmファイルの保存先をapplicationSupportに変更
        if(!self.setRealmFilePath()){
            //TODO エラー処理
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("Realm初期化完了")
        
        return true
    }
    
    func realmMigration(isProduct:Bool,version:Int=0)->Bool{
        if(isProduct){
            //リリース用（モデル定義を変更する毎にバージョンをインクリメントしてやることで、Realmデータ維持したままモデル定義を更新する）
            var config = Realm.Configuration()
            config.schemaVersion = UInt64(version) // 変更するごとにインクリメントする
            Realm.Configuration.defaultConfiguration = config
        }else{
            //開発用（モデル定義を変更する毎にRealmファイルを生成しなおすことで、モデル定義を更新する）
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)//true:Migrationするときに元のデータを消す。false:元のデータを引き継ぐ
            Realm.Configuration.defaultConfiguration = config
        }
        return true
    }
    
    func setRealmFilePath()->Bool{
        do{
            let realmDir = try FileManager.default.url(for: .applicationSupportDirectory,in: .userDomainMask,appropriateFor: nil,create: true)//先にApplication Support Dirを作成
            let path = realmDir.appendingPathComponent("default.realm")
            var config = Realm.Configuration.defaultConfiguration
            config.fileURL = path
            Realm.Configuration.defaultConfiguration = config
        }catch{
            print("Realm保存先の指定に失敗")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

