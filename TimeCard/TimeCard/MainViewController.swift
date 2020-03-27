//
//  MainViewController.swift
//  TimeCard
//
//  Created by works on 2019/12/28.
//  Copyright © 2019 pupuplanet. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var currentDate: UILabel!

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var lunchButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var workHourRepo = WorkHourRepository()
    
    var counter = 0
    var isStart = false
    var isLunch = false
    var editId = 0 // 記録中のcell
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //現在時刻
        let timer = Timer(timeInterval: 1,
                          target: self,
                          selector: #selector(timeCounter),
                          userInfo: nil,
                          repeats: true)
        RunLoop.main.add(timer, forMode: .default)
        
        //労働してない
        self.viewStatusUI(status: 0)

    }
    
    @objc func timeCounter() {
        let date = Date()
        currentTime.text = Util.convertJPDate(date: date)
        
    }
    

    //出勤ボタン
    @IBAction func startButtonAction(_ sender: Any) {
        print("出勤")
        
        //登録データ作成
        let workHourModel:WorkHourModel = WorkHourModel()

        
        let date = Date()
        print("開始時刻　：\(date)")
        workHourModel.startDate = date
        let newId = self.workHourRepo.getNewID()
        workHourModel.id = newId
        self.editId = newId
        
        //DB登録
        self.workHourRepo.add(model: workHourModel)

        //労働中
        self.viewStatusUI(status: 1)
        
        // テーブルリストを再読み込み
        let vc = children[0] as! HistoryTableViewController
        vc.reloadTable()
        
    }
    
    //休憩ボタン
    @IBAction func lunchButtonAction(_ sender: Any) {
//        if(!isLunch){
//            //休憩するよ
//            self.viewStatusUI(status: 2)
//
//            //登録データ作成
//            let timeModel:TimeModel = self.workHourRepo.findById(id: self.editId)
//
//
//            //DB更新
//            repo.transaction {
//
//                print("休憩時間りlist数：\(timeModel.lunchTimes.count)")
//                print("休憩時間：\(timeModel.lunchTimes)")
//                var model = LunchTimeModel()
//                model.startDate = Date()
//                var list = timeModel.lunchTimes
//                list.append(model)
//
//            }
//
//        }else{
//            //休憩やめるよ
//            self.viewStatusUI(status: 1)
//
//        }
    }
    
    //退勤ボタン
    @IBAction func stopButtonAction(_ sender: Any) {
        
        print("退勤")
        
        //登録データ作成
        let workHourModel:WorkHourModel = self.workHourRepo.findById(id: self.editId)
        
        //DB更新
        let date = Date()
        print("終了時刻　：\(date)")
        self.workHourRepo.transaction {
            workHourModel.endDate = date
            
            //休憩中の場合は休憩終了時間も一緒に設定
//            if(isLunch){
//                workHourModel.lunchTimes.last?.endDate = date
//            }
        }
        
        //労働終了
        self.viewStatusUI(status: 0)
        
        // テーブルリストを再読み込み
        let vc = children[0] as! HistoryTableViewController
        vc.reloadTable()
    }
    
    
    /**
     ステータスに沿ってUI制御する
     0:労働してない
     1:労働中
     2:休憩中
     */
    func viewStatusUI(status:Int){
        if(status == 0){
            isStart = false
            isLunch = false
            self.startButton.isEnabled = true
            self.stopButton.isEnabled = false
            self.lunchButton.isEnabled = false
            
        }else if(status == 1){
            isStart = true
            isLunch = false
            self.startButton.isEnabled = false
            self.stopButton.isEnabled = true
            self.lunchButton.isEnabled = true
            
        }else if(status == 2){
            isStart = true
            isLunch = true
            self.startButton.isEnabled = false
            self.stopButton.isEnabled = true
            self.lunchButton.isEnabled = true //休憩をやめる
            
        }else{

        }
    }

}
