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
    var videoIdArray = [String]()
    var titleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        getData2()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testDatas.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.titleLabel!.text = self.testDatas[indexPath.row].title
        cell.channelLabel!.text = self.testDatas[indexPath.row].channel
        cell.viewsLabel!.text = String(self.testDatas[indexPath.row].count)
        print(self.titleArray[0])//ここは表示できた
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
        
        var text = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyDXalHNRJ_8m2HTVHAMPIA0bLwrLDWVL10&q=TOP&part=snippet&maxResults=20&order=date"
        
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (responce) in
            
            switch responce.result{
                
                case .success:
                    
                    print("success")
                        
                        let json:JSON = JSON(responce.data as Any)
                        let videoId = json["items"][0]["id"]["videoId"].string
                        let title = json["items"][0]["snippet"]["title"].string
                        let channelTitle = json["items"][0]["snippet"]["channelTitle"].string
                        
                        let model = TestDataModel(title: title!, channel: channelTitle!, count: 0, imageName: "cat")
                        
                        self.testDatas.append(model)
                        self.videoIdArray.append(videoId!)
                   
                    break
                
                case .failure(let error):
                    
                    print("error")
                    break
            }
            
            self.loadView()
        }
    }
    
    func getData2(){
        
        let text2 = "https://www.googleapis.com/youtube/v3/videos?id=yYyni88QG9E&key=AIzaSyDMmJXDbpbbBYrorPKd71VvgwDKLKeRhcc&part=snippet,statistics"
        //ここの"id="にvideoIdArrayを入れたい

        let url2 = text2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        AF.request(url2, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (responce) in

            switch responce.result{

                case .success:

                    print("success2")

                    let json:JSON = JSON(responce.data as Any)
                    let title2 = json["items"][0]["snippet"]["title"].string
                    self.titleArray.append(title2!)
                    break

                case .failure(let error):

                    print("error2")
                    break

            }
            self.loadView()
        }
        
    }
}
