//
//  HistoryTableViewCell.swift
//  TimeCard
//
//  Created by works on 2020/02/07.
//  Copyright © 2020 pupuplanet. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var blankLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    var model:WorkTimeModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    //セル初期表示
    func setCell(model: WorkTimeModel) {
  
        //開始時間
        if((model.startDate) != nil){
            startTimeLabel.text = Util.convertJPDate(date: model.startDate!)
         }
        
        //終了時間
        if((model.endDate) != nil){
            endTimeLabel.text = Util.convertJPDate(date: model.endDate!)
            blankLabel.isHidden = false
        }else{
            endTimeLabel.text = ""
            blankLabel.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
