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
                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    //JUST DEAL
                }
            } else {
                do {
                    let parseData = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                    
                    for (key, value) in parseData {
                        print(" \(key) --- \(value) ")
                    }
                    
                } catch let error as NSError {
                    print(error)
                    
                    //display pop-up alert if the code does not work
                    DispatchQueue.main.asyncAfter(deadline: .now() ) {
                        //JUST DEAL
                    }
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
