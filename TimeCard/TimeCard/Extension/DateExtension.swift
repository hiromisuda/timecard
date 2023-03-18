//
//  DateExtension.swift
//  TimeCard
//
//  Created by works on 2020/06/18.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import Foundation
public extension Date{
    func getStrDay(date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        return f.string(from: date)
    }
    
    //指定のフォーマットにローカライズして返却
    //例："yyyyMMddHHmmss", "yyyy/MM/dd HH:mm:ss"
    func getLocalizeToFormat(date:Date,formatStr:String) -> String {
        let format = DateFormatter()
        format.dateFormat = "\(formatStr)"
        return format.string(from: date)
    }
    
    //ミリ秒を時刻フォーマットに変換して返却
    func getTimeIntervelToHH_MM_SS(time:Int) -> String {
        let hh = time / 3600 % 24
        let mm = time / 60 % 60
        let ss = time % 60
        
        let shh = String(format:"%02d", hh)
        let smm = String(format:"%02d", mm)
        let sss = String(format:"%02d", ss)

        let string = "\(shh):\(smm):\(sss)"
        return string
    }
}
