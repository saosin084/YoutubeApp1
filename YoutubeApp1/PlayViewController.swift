//
//  PlayViewController.swift
//  YoutubeApp1
//
//  Created by yuta on 2020/09/13.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
//    var imageNameArray2 = [String](repeating: "0", count: 50)
//    var titleArray2 = [String](repeating: "0", count: 50)
//    var channelArray2 = [String](repeating: "0", count: 50)
//    var viewsArray2 = [String](repeating: "0", count: 50)
    
    var testDatas2 = [TestDataModel]()
    var row = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = testDatas2[row].title
        channelLabel.text = testDatas2[row].channel
        viewsLabel.text = String(testDatas2[row].count)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
