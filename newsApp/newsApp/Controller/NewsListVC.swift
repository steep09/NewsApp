//
//  NewsListVC.swift
//  newsApp
//
//  Created by Stephenson Ang on 30/05/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

class NewsListVC: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
//    var newsList = [ [String:Any] ]()
//    var NewsList = [News]()
////    var news = [String:Any]()
//    var newstitle: String!
//    var newsimage: String!
//    var newsdescription: String!
    
//    var newsList = [ [String:Any] ]()
    
//    var NewsList = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJson()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    func getJson() {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e07d26ea273d41e2af174b026aea27b5"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let newsList = try JSONDecoder().decode(News.self, from: data)
                
                for dict in newsList.articles {
                    print(dict.title)
                    print("")
                }
            } catch let jsonErr {
                print("json error: ", jsonErr)
            }
        }.resume()
    }
}



extension NewsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return NewsList.count
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(240)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else { return UITableViewCell() }
//
//        let news = NewsList[indexPath.row]
//        cell.configureCell(news: news)
//        return cell
        return UITableViewCell()
    }
}

//extension NewsListVC {
//
//    func parseURL() {
//
//        let theURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e07d26ea273d41e2af174b026aea27b5"
//        let url = URL(string: theURL)
//        URLSession.shared.dataTask(with:url!) { (data, response, error) in
//            //check if it has an error
//            if error != nil {
//                print("didn't work")
//            } else {
//                //this will try to present the keys and values inside json dictionary
//                do {
//                    //this will take the json that has a value of string and any value and store it in parseData
//                    let parseData = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
//
//                    //                    print(parseData["articles"]!)
//                    self.newsList = parseData["articles"] as! [[String : Any]]
//                    for x in self.newsList {
//                        self.NewsList.append(News(title: x["title"] as? String ?? "", image: x["urlToImage"] as? String ?? "", description: x["description"] as? String ?? ""))
//                        print("\(self.NewsList[self.NewsList.count - 1].title!) --- \(self.NewsList.count)")
//                    }
//                    print(self.NewsList.count)
//                } catch let error as NSError {
//                    print(error)
//                }
//            }
//            }.resume()
//    }
//}

//                    for (key, value) in parseData {
//                        if (key == "articles") {
//                            if let articleArray:[ [String:Any] ] = value as? [ [String:Any] ] {
//
//                                //this will loop through all articles
//                                for dict in articleArray {
//                                    for (key, value) in dict {
//                                        if (key == "urlToImage") {
//                                            self.newsimage = value as? String
//                                        } else if (key == "title") {
//                                            self.newstitle = value as? String
//                                        } else if (key == "description") {
//                                            self.newsdescription = value as? String
//                                        }
//
//                                    }
//                                    self.newsList.append(News(title: self.newstitle, image: self.newsimage, description: self.newsdescription))
//                                    print(self.newsList.count)
//                                }
//                            }
//                        }
//                    }
