//
//  HistoryTableViewController.swift
//  TimeCard
//
//  Created by works on 2020/02/07.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var models:Results<WorkTimeModel>!
    var workHourRepo = WorkTimeRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
        
        //全件データ取得
        self.models = self.workHourRepo.findAll()
        
    }
    
    func reloadTable(){
        // テーブルリストを再読み込み
        self.tableView.reloadData()
    }
    
    //表示するCellの総数を返してやる
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
        
    }
    
    //Cellに値を設定する。Cell1つずつメソッド実行される
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath ) as! HistoryTableViewCell
        cell.setCell(model: self.models[indexPath.row])
        return cell

        
    }
    
    //選択したCellを取得する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell：(indexPath.row) checkList：\(self.models[indexPath.row])")
    }
    

}
