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
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var testDatas = [TestDataModel]()
    var videoIdArray = [String]()
    var titleArray = [String]()
    let KEY = "AIzaSyDMmJXDbpbbBYrorPKd71VvgwDKLKeRhcc"
    var Array = [1,2,3,4,5]
    var countArray = [Int]()
    var youtubeURLArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        //getData2()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testDatas.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        let profileImageURL = URL(string: self.testDatas[indexPath.row].imageName as String)!
        cell.imageView?.sd_setImage(with: profileImageURL, completed: { (image, error, _, _) in

            if error == nil{

                cell.setNeedsLayout()

            }

        })
        cell.titleLabel!.text = self.testDatas[indexPath.row].title
        cell.channelLabel!.text = self.testDatas[indexPath.row].channel
        cell.viewsLabel!.text = String(self.testDatas[indexPath.row].count) + "回"
 
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return view.frame.size.height/5
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexNumber = indexPath.row
        let webViewController = WebViewController()
        let url = youtubeURLArray[indexNumber]
        UserDefaults.standard.set(url, forKey: "url")
        present(webViewController, animated: true, completion: nil)

    }
        
    func getData(){
        
        var text = "https://www.googleapis.com/youtube/v3/search?key=\(KEY)&q=TOP&part=snippet&maxResults=20&order=date"
        
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (responce) in
            
            switch responce.result{
                
                case .success:
                    
                    print("success")
                    
                    for i in 0 ... 19{
                        
                        let json:JSON = JSON(responce.data as Any)
                        let videoId = json["items"][i]["id"]["videoId"].string
                        let youtubeURL = "http://www.youtube.com/watch?v=\(videoId!)"
                        self.videoIdArray.append(videoId!)
                        self.youtubeURLArray.append(youtubeURL)

                    }
                    
                    self.videoIdArray.forEach{ video in
                            
                        let text2 = "https://www.googleapis.com/youtube/v3/videos?id=\(video)&key=\(self.KEY)&part=snippet,statistics"
                           
                        
                        let url2 = text2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                            
                                AF.request(url2, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (responce) in
                            
                                    switch responce.result{
                            
                                        case .success:
                            
                                            print("success2")
                            
                                            let json:JSON = JSON(responce.data as Any)
                                            let title = json["items"][0]["snippet"]["title"].string
                                            let channelTitle = json["items"][0]["snippet"]["channelTitle"].string
                                            let count = json["items"][0]["statistics"]["viewCount"].string
                                            let imageURLString = json["items"][0]["snippet"]["thumbnails"]["default"]["url"].string
                                            
                                            let model = TestDataModel(title: title!, channel: channelTitle!, count: Int(count!)!, imageName: imageURLString!)
                                                
                                            self.testDatas.append(model)

                                            break
                                            
                            
                                        case .failure(let error2):
                            
                                            print("error2")
                                            break
                            
                                    }
                        self.loadView()
                                }
                    }
                    
                    break
                
                case .failure(let error):
                    
                    print("error")
                    break
            }
            
            self.loadView()
        }
    }
    
    
    
//    func getData2(){
//
//        let text2 = "https://www.googleapis.com/youtube/v3/videos?id=yYyni88QG9E&key=\(KEY)&part=snippet,statistics"
//        //ここの"id="にvideoIdArrayを入れたい
//
//        let url2 = text2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//
//        AF.request(url2, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (responce) in
//
//            switch responce.result{
//
//                case .success:
//
//                    print("success2")
//
//                    let json:JSON = JSON(responce.data as Any)
//                    let title2 = json["items"][0]["snippet"]["title"].string
//                    self.titleArray.append(title2!)
//                    break
//
//                case .failure(let error):
//
//                    print("error2")
//                    break
//
//            }
//            self.loadView()
//        }
//
//    }
}
