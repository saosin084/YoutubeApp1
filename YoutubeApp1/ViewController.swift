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

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var testDatas = [TestDataModel]()
    var videoIdArray = [String]()
    let KEY = "AIzaSyDMmJXDbpbbBYrorPKd71VvgwDKLKeRhcc"
    var youtubeURLArray = [String]()
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        getData()
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getData2(search: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testDatas.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        let profileImageURL = URL(string: self.testDatas[indexPath.row].imageUrl as String)!
        cell.mainImage.sd_setImage(with: profileImageURL)
        cell.titleLabel!.text = self.testDatas[indexPath.row].title
        cell.titleLabel.numberOfLines = 3
        cell.channelLabel!.text = self.testDatas[indexPath.row].channel
        cell.viewsLabel!.text = String(self.testDatas[indexPath.row].count) + "回"
 
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
                nextVC.youtubeURLArray2 = youtubeURLArray
                nextVC.row = index!
                
            }
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
                                            
                                            let model = TestDataModel(title: title!, channel: channelTitle!, count: Int(count!)!, imageUrl: imageURLString!)
                                                
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
    
    func getData2(search: String){
        
        var text = "https://www.googleapis.com/youtube/v3/search?key=\(KEY)&q=\(search)&part=snippet&maxResults=20&order=date"
        
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        videoIdArray.removeAll()
        youtubeURLArray.removeAll()
        testDatas.removeAll()
        
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
                                            
                                            let model = TestDataModel(title: title!, channel: channelTitle!, count: Int(count!)!, imageUrl: imageURLString!)
                                                
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
    
}
