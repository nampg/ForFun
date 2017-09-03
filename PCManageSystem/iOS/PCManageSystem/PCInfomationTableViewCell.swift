//
//  PCInfomationTableViewCell.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/07.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import UIKit

class PCInfomationTableViewCell: UITableViewCell {
    @IBOutlet weak var pcNoLabel: UILabel!
    @IBOutlet weak var osLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var officeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var damagedLabel: UILabel!
    @IBOutlet weak var securityLabel: UILabel!
    
    public var osid: Int32 = 0
    public var locationid: Int32 = 0

    //var pcinfoData:PCINFOMATION?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
