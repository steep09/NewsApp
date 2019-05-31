//
//  Datas.swift
//  newsApp
//
//  Created by Stephenson Ang on 31/05/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//


//PUTTING JSON DATAS IN NEWS MODEL
import CoreData

class DataList   {
    static let instance = DataList()
    
    var arrayNews: [NewsList] = []
    var newsTitle: String!
    var newsImage: String!
    var newsDescription: String!
    
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
//                        print("\(key) ----- \(value)")
                        //gets what's indside the articles array of disctionaries
                        if (key == "articles") {
                            //create a value of what's inside articles and put it inside articleArray
                            if let articleArray:[ [String:Any] ] = value as? [ [String:Any] ] {
                                //loop through array
                                for dict in articleArray {
                                    //loop through dictionary
                                    for (key, value) in dict {
                                        //printing the values inside dictionary
                                        if (key == "url") {
                                            print("url : \(value)")
                                        } else if (key == "title") {
                                            self.newsTitle = value as? String
                                            print("title : \(value)")
                                        } else if (key == "description") {
                                            self.newsDescription = value as? String
                                            print ("description : \(value)")
                                        } else if (key == "urlToImage") {
                                            self.newsImage = value as? String
                                            print ("urlToImage : \(value)")
                                        }
                                    }
                                    self.arrayNews.append(NewsList(title: self.newsTitle, imageName: self.newsImage, description: self.newsDescription))

                                    break
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
    
    func save(title: String, description: String, image: String, completion: (_ finished: Bool) -> ()) {
        //DATABASE
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        let news = News(context: manageContext)
        
        news.newsTitle = title
        news.newsImage = image
        news.newsDescription = description
        
        do {
            try manageContext.save()
            completion(true)
        } catch {
            debugPrint("Could not Save: \(error.localizedDescription)")
            completion(false)
        }
    }
    
}
