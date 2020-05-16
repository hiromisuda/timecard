//
//  EditViewController.swift
//  TimeCard
//
//  Created by works on 2020/04/11.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import UIKit

class EditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var items1: NSMutableArray = ["ねずみ", "うし", "とら", "うさぎ", "りゅう"]
    var items2: NSMutableArray = ["へび", "うま","ひつじ","さる","とり","いぬ","いのしし","ねこ","しまうま"]
    var items3: NSMutableArray = ["やぎ","くま","しろくま","こぶら","ごりら","ぶた","ぞう","おおかみ"]
    var section1: Dictionary = [String:NSMutableArray]()
    var section2: Dictionary = [String:NSMutableArray]()
    var section3: Dictionary = [String:NSMutableArray]()
    var sections: Array = [Dictionary<String,NSMutableArray>]()
    var isOpen1 = false
    var isOpen2 = false
    var isOpen3 = false
    
//    var arr:[String]  = [
//        "2020/04/20(月) 10:00-19:00"
//        ,"2020/04/19(日) 10:00-19:00"
//        ,"2020/04/18(土) 10:00-19:00"
//        ,"2020/04/17(金) 10:00-19:00"
//        ,"2020/04/16(木) 10:00-19:00"
//        ,"2020/04/15(水) 10:00-19:00"
//        ,"2020/04/14(火) 10:00-19:00"
//        ,"2020/04/13(月) 10:00-19:00"
//        ,"2020/04/12(日) 10:00-19:00"
//        ,"2020/04/11(土) 10:00-19:00"
//    ]
//
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // セクションのタイトルとデータの配列を設定
        section1 = ["セクション１":items1]
        section2 = ["セクション２":items2]
        section3 = ["セクション３":items3]
        sections.append(section1)
        sections.append(section2)
        sections.append(section3)
        
        //ヘッダーのViewを登録＆TableViewに設定
        tableView.register (UINib(nibName: "EditTableHeaderViewCell", bundle: nil),forCellReuseIdentifier:"headerCell")
        let headerCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "headerCell")!
        let headerView: UIView = headerCell.contentView
        tableView.tableHeaderView = headerView
        
        //セクションのViewを登録
        tableView.register(headerFooterViewClass: EditSectionTableViewCell.self)
        
        //TODO セルのViewを登録
        
    }
    
    func reloadTable(){
        // テーブルリストを再読み込みほげ
        self.tableView.reloadData()
    }
    
    // セクション数
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    // セクションのタイトルのみ設定※廃止
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        for (key) in sections[section].keys
        {
            title = key
        }
        return title
    }
    
    //セクションにViewを設定
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        //セクションを設定
        let sectionView = tableView.dequeueReusableHeaderFooterView(withClass: EditSectionTableViewCell.self)
        
        for (key) in sections[section].keys
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
        for (value) in sections[indexPath.section].values
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
