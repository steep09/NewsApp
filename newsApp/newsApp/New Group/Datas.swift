//
//  Datas.swift
//  newsApp
//
//  Created by Stephenson Ang on 01/06/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import Foundation

class Data {
    
    class func getGenres(completionHandler: @escaping (_ genres: NSArray) -> ()) {
        print("Hello inside getGenres")
        let urlPath = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e07d26ea273d41e2af174b026aea27b5"
        print(urlPath)
        let url: NSURL = NSURL(string: urlPath)!
        let session = URLSession.shared
        var resultsArray:NSArray!
        let task = session.dataTask(with: url as URL) { data, response, error in
            print("Task completed")
            if((error) != nil) {
                print(error!.localizedDescription)
            }
//            var err: NSError?
            let options:JSONSerialization.ReadingOptions = JSONSerialization.ReadingOptions.mutableContainers
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: options) as?
                    NSDictionary {
                    print(jsonResult)
                    
                    let results: NSArray = jsonResult["genres"] as! NSArray
                    NSLog("jsonResults %@", results)
                    resultsArray = results
                    completionHandler(resultsArray)
//                    return resultsArray // error [anyObject] is not a subType of 'Void'
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            //NSLog("jsonResults %@", jsonResult)
            
        }
        task.resume()
        //return "Hello World!"
        // I want to return the NSArray...
    }
}
