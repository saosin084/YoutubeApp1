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
    
//    var imageNameArray = [String](repeating: "0", count: 50)
//    var titleArray = [String](repeating: "0", count: 50)
//    var channelArray = [String](repeating: "0", count: 50)
//    var viewsArray = [String](repeating: "0", count: 50)
    
    var testDatas = [TestDataModel]()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<50{
            
//            imageNameArray[i] = "cat"
//            titleArray[i] = "aaaaaa\(i)"
//            channelArray[i] = "xxxxxxx\(i)チャンネル"
//            viewsArray[i] = "10000\(i)回"
            
            var model = TestDataModel(title: "aaaaaa\(i)", channel: "xxxxxxx\(i)チャンネル", count: i, imageName: "cat")
            testDatas.append(model)
            
        }
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return testDatas.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.mainImage.image = UIImage(named: testDatas[indexPath.row].imageName)
        cell.titleLabel.text = testDatas[indexPath.row].title
        cell.titleLabel.numberOfLines = 3
        cell.channelLabel.text = testDatas[indexPath.row].channel
        cell.viewsLabel.text = String(testDatas[indexPath.row].count)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 180
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "next", sender: indexPath.row)
        
    }
    
//    @IBAction func playButton(_ sender: Any) {
//        
//        self.performSegue(withIdentifier: "next", sender: nil)
//        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{

            let nextVC = segue.destination as! PlayViewController
            let index = sender as? Int
            nextVC.testDatas2 = testDatas
            nextVC.row = index!
            
}
}
    
    
}

