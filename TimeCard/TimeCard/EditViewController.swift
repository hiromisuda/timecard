//
//  EditViewController.swift
//  TimeCard
//
//  Created by works on 2020/04/11.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var workTimeModels:Results<WorkTimeModel>!
    var workTimeRepo = WorkTimeRepository()
    
    var items1: NSMutableArray = ["ねずみ", "うし", "とら", "うさぎ", "りゅう"]
    var items2: NSMutableArray = ["へび", "うま","ひつじ","さる","とり","いぬ","いのしし","ねこ","しまうま"]
    var items3: NSMutableArray = ["やぎ","くま","しろくま","こぶら","ごりら","ぶた","ぞう","おおかみ"]
    var section1: Dictionary = [String:NSMutableArray]()
    var section2: Dictionary = [String:NSMutableArray]()
    var section3: Dictionary = [String:NSMutableArray]()
    
    var dateList: Array = [Dictionary<String,NSMutableArray>]()

    var isOpen1 = false
    var isOpen2 = false
    var isOpen3 = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------------------------
        // TableView初期設定
        //------------------------
        tableView.dataSource = self
        tableView.delegate = self
                
        //ヘッダーのViewを登録＆TableViewに設定
        tableView.register (UINib(nibName: "EditTableHeaderViewCell", bundle: nil),forCellReuseIdentifier:"headerCell")
        let headerCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "headerCell")!
        let headerView: UIView = headerCell.contentView
        tableView.tableHeaderView = headerView
        
        //セクションのViewを登録
        tableView.register(headerFooterViewClass: EditSectionTableViewCell.self)
        
        //TODO セルのViewを登録
        

        //------------------------
        //日付リスト作成
        //------------------------
        //1ヶ月分のWorkTimeNodel取得
        for i in 1..<30 {
        
            let day = Date()
            let targetDay = Calendar.current.date(byAdding: .day, value: i * -1, to: day)!
            print(targetDay);
        }
        
        let res = workTimeRepo.findByStartDate(from: Date())
        print("検索結果：\(res.count)")
        
        //WorkTimeModelから、日付毎のデータを取得
        
        //該当データがない場合、その日の労働はなしとする
        
        var workTime: NSMutableArray = ["ねずみ", "うし", "とら", "うさぎ", "りゅう"]
        var section1 = ["セクション１":items1]
        
        //同日をまとめるサンプル
//        let d = Date()
//        let dateA = Date()
//        let dateBa = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
//        if d.getYYYYMMDD(date: dateA) == d.getYYYYMMDD(date: dateBa) {
//            print("Same")
//        } else {
//            print("Different")
//        }
        
        
        //リストに追加
        dateList.append(section3)
        
        //全件データ取得
        self.workTimeModels = self.workTimeRepo.findAll()
        
    }
    
    func reloadTable(){
        // テーブルリストを再読み込みほげ
        self.tableView.reloadData()
    }
    
    // セクション数
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dateList.count
    }
    
    // セクションのタイトルのみ設定※廃止
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        for (key) in dateList[section].keys
        {
            title = key
        }
        return title
    }
    
    //セクションにViewを設定
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        //セクションを設定
        let sectionView = tableView.dequeueReusableHeaderFooterView(withClass: EditSectionTableViewCell.self)
        
        for (key) in dateList[section].keys
        {
            //label.text = key
            //sectionView.setLabel(str: key)
        }
        
        // セクションのビューに対応する番号を設定
        sectionView.section = section
        // セクションのビューにタップジェスチャーを設定
        sectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapHeader(gestureRecognizer:))))
        
        return sectionView
    }
    
    @objc func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        // タップされたセクションを取得
//        guard let section = gestureRecognizer.view?.tag as Int? else {
//            return
//        }
        guard let sectionView = gestureRecognizer.view as? EditSectionTableViewCell else { return }
        
        // タップされたセクションのフラグを設定（true-falseを入れ替える）
        switch sectionView.section {
        case 0:
            isOpen1 = isOpen1 ? false : true
        case 1:
            isOpen2 = isOpen2 ? false : true
        case 2:
            isOpen3 = isOpen3 ? false : true
        default:
            break
        }
        
        // タップされたセクションを再読込
        tableView.reloadSections(NSIndexSet(index: sectionView.section) as IndexSet, with: .none)
    }

    // セクションヘッダーの高さ
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //TODO 暫定
        return 60
    }
    
    //表示するCellの総数を返してやる
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セクション毎のセル数を設定
        switch section {
        case 0:
            return isOpen1 ? self.items1.count : 0
        case 1:
            return isOpen2 ? self.items2.count : 0
        case 2:
            return isOpen3 ? self.items3.count : 0
        default:
            return 0
        }
    }
    
    //Cellに値を設定する。Cell1つずつメソッド実行される
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath )

        //        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
//        cell.textLabel!.text = arr[indexPath.row]
//        return cell

        // セルにテキストを出力する。
        let cell = tableView.dequeueReusableCell(withIdentifier:  "cell", for:indexPath)
        for (value) in dateList[indexPath.section].values
        {
            cell.textLabel?.text = value[indexPath.row] as? String
        }

        return cell
        
    }
    
    //選択したCellを取得する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("cell：(indexPath.row) checkList：\(self.models[indexPath.row])")
    }

}


extension UITableView {

    // func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell
    // の代わりに使用する
    func dequeueReusableCell<T: UITableViewCell>(withClass type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }

    // func dequeueReusableHeaderFooterView(withIdentifier identifier: String) -> UITableViewHeaderFooterView?
    // の代わりに使用する
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass type: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as! T
    }

    // func register(_ nib: UINib?, forCellReuseIdentifier identifier: String)
    // func register(_ cellClass: Swift.AnyClass?, forCellReuseIdentifier identifier: String)
    // の代わりに使用する
    func register(tableViewCellClass cellClass: AnyClass) {
        let className = String(describing: cellClass)
        if UINib.fileExists(nibName: className) {
            self.register(UINib.cachedNib(nibName: className), forCellReuseIdentifier: className)
        } else {
            self.register(cellClass, forCellReuseIdentifier: className)
        }
    }

    // func register(_ nib: UINib?, forHeaderFooterViewReuseIdentifier identifier: String)
    // func register(_ aClass: Swift.AnyClass?, forHeaderFooterViewReuseIdentifier identifier: String)
    // の代わりに使用する
    func register(headerFooterViewClass aClass: AnyClass) {
        let className = String(describing: aClass)
        if UINib.fileExists(nibName: className) {
            self.register(UINib.cachedNib(nibName: className), forHeaderFooterViewReuseIdentifier: className)
        } else {
            self.register(aClass, forHeaderFooterViewReuseIdentifier: className)
        }
    }
}


extension UINib {

    static let nibCache = NSCache<NSString, UINib>()

    static func fileExists(nibName: String) -> Bool {
        return Bundle.main.path(forResource: nibName, ofType: "nib") != nil
    }

    static func cachedNib(nibName: String) -> UINib {
        if let nib = self.nibCache.object(forKey: nibName as NSString) {
            return nib
        } else {
            let nib = UINib(nibName: nibName, bundle: nil)
            self.nibCache.setObject(nib, forKey: nibName as NSString)
            return nib
        }
    }
}
