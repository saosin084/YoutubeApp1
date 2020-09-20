//
//  ViewController.swift
//  YoutubeApp1
//
//  Created by yuta on 2020/09/17.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var testDatas = [TestDataModel]()
    var titleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1 //titleArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.titleLabel!.text = "aaa" //self.titleArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return view.frame.size.height/5
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "next", sender: indexPath.row)
            
    }
        
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
            
            switch responce.result{
                
                case .success:
                    
                    print("success")

                        let json:JSON = JSON(responce.data as Any)
            
                        let title = json["items"][0]["snippet"]["title"].string
                    
                        self.titleArray.append(title!)

                    break
                
                case .failure(let error):
                    
                    print("error")
                    break
                
            }
            self.loadView()
        }
    }
    
    
}
