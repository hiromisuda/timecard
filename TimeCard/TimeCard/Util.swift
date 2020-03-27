//
//  Util.swift
//  TimeCard
//
//  Created by works on 2019/12/31.
//  Copyright © 2019 pupuplanet. All rights reserved.
//

import Foundation


class Util{

    //Date → String（日本時間への変換）
    //Dateを日本変換
    static func convertJPDate(date:Date) -> String{
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let hour = calendar?.component(.hour, from: date as Date)
        let minute = calendar?.component(.minute, from: date as Date)
        let second = calendar?.component(.second, from: date as Date)
        var timeHH = String(format: "%02d", hour!)
        var timeMM = String(format: "%02d", minute!)
        var timeSS = String(format: "%02d", second!)
        
        //こういうやり方もある
        //        var formatter = DateFormatter()
        //        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyyMMdd", options: 0, locale: Locale(identifier: "ja_JP"))
        //        print(formatter.string(from: Date()))
        
        return "\(timeHH):\(timeMM)"
    }
    
//    //指定のフォーマットにローカライズして返却
//    class func convertJPFormat(date:Date,formatStr:String) -> String {
//        let format = DateFormatter()
//        format.dateFormat = "\(formatStr)"
//        return format.string(from: date)
//    }
//
    
    //労働時間のみを算出　労働時間（開始〜終了） -　休憩時間
    
    
}
