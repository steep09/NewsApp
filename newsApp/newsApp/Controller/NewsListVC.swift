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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }

}

extension NewsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else { return UITableViewCell() }
//        let newsList = news[indexPath.row]
//        cell.configureCell(news: newsList)
//        return cell
        return UITableViewCell()
    }
}

extension NewsListVC {
    
    func parseURL() {
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
                                for dict in articleArray {
                                    for (key, value) in dict {
                                        if (key == "urlToImage") {
                                            print("url is : \(value)")
                                        } else if (key == "title") {
                                            print("title is : \(value)")
                                        } else if (key == "description") {
                                            print("description is : \(value)")
                                        }
                                    }
                                    print("")
                                }
                            }
                        }
                    }
                    
                    
                } catch let error as NSError {
                    print(error)
                    
                }
            }
            }.resume()
    }
}
