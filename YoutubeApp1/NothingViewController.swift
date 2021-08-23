//
//  NothingViewController.swift
//  YoutubeApp1
//
//  Created by yuta on 2020/11/16.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit

class NothingViewController: UIViewController {

    @IBOutlet weak var nothingLabel: UILabel!
    
    var searchWord2 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nothingLabel.text = searchWord2 + "の検索結果はありません"
        
    }
    

}
