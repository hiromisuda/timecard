//
//  ButtonExtension.swift
//  TimeCard
//
//  Created by works on 2020/02/22.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import UIKit
public extension UIButton {
    func setBadge(count: Int) {
        //0のときバッジを表示しない
        if(count==0){
            self.isHidden = true
            return
        }
        self.isHidden = false
        self.setTitle("\(count)", for: .normal)
        
    }
}
