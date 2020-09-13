//
//  ViewController.swift
//  YoutubeApp1
//
//  Created by yuta on 2020/09/12.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let imageName = "cat"
    let titles = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbcccccccccccccccccccc"
    let channel = "xxxxxxxxxチャンネル"
    let views = "10000回"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return 10
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.mainImage.image = UIImage(named: imageName)
        cell.titleLabel.text = titles
        cell.titleLabel.numberOfLines = 3
        cell.channelLabel.text = channel
        cell.viewsLabel.text = views
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 180
 
    }
    
    @IBAction func playButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    
}

