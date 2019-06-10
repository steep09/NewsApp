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
    
    var sample = [News]()
    
    //    var newsList = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getJson(urlString: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e07d26ea273d41e2af174b026aea27b5")
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
    }
    
    @IBAction func reloadBtnWasPressed(_ sender: Any) {
        getJson(urlString: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e07d26ea273d41e2af174b026aea27b5")
        
        self.newsTableView.reloadData()
    }
    
    func getJson(urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                
                self.sample = [try JSONDecoder().decode(News.self, from: data)]
                
                DispatchQueue.main.async {
                    //reload tableView data
                    self.newsTableView.reloadData()
                }
                
            } catch let jsonErr {
                print("json error: ", jsonErr)
            }
            }.resume()
    }
}

extension NewsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample.first?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(235)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        let json = sample[0].articles[indexPath.row]
        cell.newsTitle.text = "\(json.title ?? "")"
        cell.newsDescription.text = "\(json.description ?? "")"
        
        if let url = NSURL(string: json.urlToImage ?? "") {
            if let data = NSData(contentsOf: url as URL) {
                cell.newsImage.image = UIImage(data: data as Data)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "NewsDetailVC") as! NewsDetailVC
        print(sample[0].articles[indexPath.row].url!)
        detail.initData(site: sample[0].articles[indexPath.row].url!)
        present(detail, animated: false, completion: nil)

    }
    
    
}
