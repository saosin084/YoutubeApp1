//
//  CustomTableViewCell.swift
//  YoutubeApp1
//
//  Created by yuta on 2020/09/12.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    

    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
