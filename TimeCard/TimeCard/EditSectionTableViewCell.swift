//
//  EditSectionTableViewCell.swift
//  TimeCard
//
//  Created by works on 2020/05/09.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import UIKit

class EditSectionTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var nyoroLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    var section: Int = 0
    
    
    func setLabel(str: String){
        print(str)
    }
    
}
