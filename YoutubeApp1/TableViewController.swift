//
//  ViewController.swift
//  YoutubeApp1
//
//  Created by yuta on 2020/09/12.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController{
    
//    let imageName = "cat"
//    let titles = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbcccccccccccccccccccc"
//    let channel = "xxxxxxxxxチャンネル"
//    let views = "10000回"
    
    var youtubeData = YoutubeData()
    //var titleArray = [String]()
    
    
//    var imageNameArray = [String](repeating: "0", count: 50)
//    var titleArray = [String](repeating: "0", count: 50)
//    var channelArray = [String](repeating: "0", count: 50)
//    var viewsArray = [String](repeating: "0", count: 50)
    
    var testDatas = [TestDataModel]()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for i in 0..<19{
            
//            imageNameArray[i] = "cat"
//            titleArray[i] = "aaaaaa\(i)"
//            channelArray[i] = "xxxxxxx\(i)チャンネル"
//            viewsArray[i] = "10000\(i)回"
            
//            let model = TestDataModel(title: "aaaaa", channel: "xxxxxxx\(i)チャンネル", count: i, imageName: "cat")
//            testDatas.append(model)
//       }
        
        
        
        getData()
        
    }
    
    @objc var scrollView: UIScrollView{
        
        return tableView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return testDatas.count
    
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.mainImage.image = UIImage(named: testDatas[indexPath.row].imageName)
        cell.titleLabel.text = testDatas[indexPath.row].title
        cell.titleLabel.numberOfLines = 3
        cell.channelLabel.text = testDatas[indexPath.row].channel
        cell.viewsLabel.text = String(testDatas[indexPath.row].count)
    
  
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height/5
 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func getData(){
           
           var text = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyDMmJXDbpbbBYrorPKd71VvgwDKLKeRhcc&q=TOP&part=snippet&maxResults=20&order=date"
           
           let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           
           AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (responce) in
               
               
               print(responce)
               
               switch responce.result{
                   
               case .success:
                
                   for i in 0 ... 19{
                       
                       let json:JSON = JSON(responce.data as Any)
                       
                       let title = json["items"][i]["snippet"]["title"].string
                    
                    let model = TestDataModel(title: "aaa", channel: "xxxxxxx\(i)チャンネル", count: i, imageName: "cat")
                    self.testDatas.append(model)
                 
                   }
                   
                   print(self.testDatas[0].title)
                   
                   break
                   
               case .failure(let error):
                   print(error)
                
                   break
               }
               
            self.tableView.reloadData()
               
           }
       
       }
    
}

