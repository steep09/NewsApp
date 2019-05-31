//
//  NewsListVC.swift
//  newsApp
//
//  Created by Stephenson Ang on 30/05/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import CoreData

class NewsListVC: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var news: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseURL(theURL: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e07d26ea273d41e2af174b026aea27b5")
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    func parseURL(theURL: String) {
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
                        print("\(key) ----- \(value)")
                        if (key == "articles") {
                            if let articleArray:[ [String:Any] ] = value as? [ [String:Any] ] {
                                for dict in articleArray {
                                    for (key, value) in dict {
                                        if (key == "url") {
                                            print(value)
                                        } else if (key == "title") {
                                            print("title is : \(value)")
                                        }
                                    }
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

extension NewsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else { return UITableViewCell() }
        let newsList = news[indexPath.row]
        cell.configureCell(news: newsList)
        return cell
    }
}
