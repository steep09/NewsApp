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
    
    var newsList: [News] = [
        News(title: "Swift", image: "https://g.foolcdn.com/editorial/images/527387/master-investor-warren-buffett.jpg", description: "I have no idea what i'm doing"),
        News(title: "Python", image: "https://static.foxnews.com/foxnews.com/content/uploads/2019/05/BenJerryCBD.jpg", description: "It's late and I'm very sleepy"),
    ]
    var newstitle: String!
    var newsimage: String!
    var newsdescription: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(parseURL())
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }

}
extension NewsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(240)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else { return UITableViewCell() }
        let news = newsList[indexPath.row]
        cell.configureCell(news: news)
        return cell
//        return UITableViewCell()
    }
}

extension NewsListVC {
    
    func parseURL() -> [News] {
        let theURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e07d26ea273d41e2af174b026aea27b5"
        let url = URL(string: theURL)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            //check if it has an error
            if error != nil {
                print("didn't work")
            } else {
                //this will try to present the keys and values inside json dictionary
                do {
                    //this will take the json that has a value of string and any value and store it in parseData
                    let parseData = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                    
                    for (key, value) in parseData {
                        if (key == "articles") {
                            if let articleArray:[ [String:Any] ] = value as? [ [String:Any] ] {
                                //this will loop through all articles
                                for dict in articleArray {
                                    for (key, value) in dict {
                                        if (key == "urlToImage") {
                                            self.newsimage = value as? String
                                        } else if (key == "title") {
                                            self.newstitle = value as? String
                                        } else if (key == "description") {
                                            self.newsdescription = value as? String
                                        }
                                        
                                    }
                                    self.newsList.append(News(title: self.newstitle, image: self.newsimage, description: self.newsdescription))
                                }
                            }
                        }
                    }

                    
                } catch let error as NSError {
                    print(error)
                }
            }
            }.resume()
        return self.newsList
    }
}
