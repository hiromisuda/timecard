//
//  ViewController.swift
//  TimeCard
//
//  Created by works on 2019/12/11.
//  Copyright © 2019 pupuplanet. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CreateSerialNumber {

    @IBOutlet weak var timeHH: UILabel!
    @IBOutlet weak var timeMM: UILabel!
    @IBOutlet weak var timeSS: UILabel!
    @IBOutlet weak var countdown: UILabel!
    @IBOutlet weak var task: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var hour = ""
    var counter = 0
    var timeList: Results<TimeModel>!
    var isStart = false
    var isLunch = false
    // 記録中のcell
    var editId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //一覧取得
        var realm = try! Realm()
        
        self.timeList = realm.objects(TimeModel.self)
        tableView.dataSource = self
        
        //現在時刻
        let timer = Timer(timeInterval: 1,
                          target: self,
                          selector: #selector(timeCheck),
                          userInfo: nil,
                          repeats: true)
        RunLoop.main.add(timer, forMode: .default)
        
        //経過時間
        let countTimer = Timer(timeInterval: 1,
                          target: self,
                          selector: #selector(countUp),
                          userInfo: nil,
                          repeats: true)
        RunLoop.main.add(countTimer, forMode: .default)
    }

    @objc func timeCheck() {
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)


        let hour = calendar?.component(.hour, from: date as Date)
        let minute = calendar?.component(.minute, from: date as Date)
        let second = calendar?.component(.second, from: date as Date)
        
        self.timeHH.text = String(format: "%02d", hour!)
        self.timeMM.text = String(format: "%02d", minute!)
        self.timeSS.text = String(format: "%02d", second!)
        
    }
    
    @objc func countUp() {
        counter += 1
        self.countdown.text = "\(counter)"
        
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        print("出勤")
        
        //seqの最大値+1を取得
        let realm = try! Realm()
        let maxTimeModel = realm.objects(TimeModel.self).sorted(byKeyPath: "id", ascending: false).first
        
        //登録
        let timeModel:TimeModel = TimeModel()
        var formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyyMMdd", options: 0, locale: Locale(identifier: "ja_JP"))
        print(formatter.string(from: Date()))
        timeModel.date = formatter.string(from: Date())
        timeModel.task = self.task.text!
        timeModel.hhStart = self.timeHH.text!
        timeModel.mmStart = self.timeMM.text!
        
        self.editId = newId(model: timeModel)
        timeModel.id = self.editId

        
        try! realm.write {
            realm.add(timeModel)
        }
        isStart = true
        // テーブルリストを再読み込み
        self.tableView.reloadData()
        
    }
    
    /**
     一時停止/再開
     */
    @IBAction func pauseButtonAction(_ sender: Any) {
        print("休憩")
        //累計時間の一時停止
        
        //累計時間の再開
        
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        print("退勤")
        //累計時間のリセット
        
        //編集中のTimeModelを取得
        let realm = try! Realm()
//        let timeModel_all = realm.objects(TimeModel.self)
//        print("timeModel_all:\(timeModel_all.count)")
//        let timeModel_filter = realm.objects(TimeModel.self).filter("id == \(self.editId)")
//        print("timeModel_filter:\(timeModel_filter.count)")
        var timeModel = realm.objects(TimeModel.self).filter("id == \(self.editId)").first
        try! realm.write {
            timeModel?.hhEnd = self.timeHH.text!
            timeModel?.mmEnd = self.timeMM.text!
            timeModel?.total = self.countdown.text!
        }
        isStart = false
        // テーブルリストを再読み込み
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      print("セルの総数：\(self.timeList.count)")
      return self.timeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //TODO 表示するセル番号をStartとEndで持っておく
        
        var time: TimeModel = self.timeList[(indexPath as NSIndexPath).row];
        var hhStart = "\(time.hhStart)"
        var mmStart = ":\(time.mmStart)"
        var hhEnd = " | \(time.hhEnd)"
        var mmEnd = ":\(time.mmEnd)"
        var timeStr = ""
        if(!hhStart.isEmpty){
            timeStr = hhStart + mmStart
        }
        if(!hhEnd.isEmpty){
            var str = hhEnd + mmEnd
            timeStr += str
        }
          
        cell.textLabel?.text = timeStr
          
        return cell
    }
}

