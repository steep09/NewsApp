//
//  NewsCell.swift
//  newsApp
//
//  Created by Stephenson Ang on 30/05/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescription: UILabel!
    
    func configureCell(news: News) {
        self.newsTitle.text = news.title
        if let url = NSURL(string: news.image) {
            if let data = NSData(contentsOf: url as URL) {
                self.newsImage.image = UIImage(data: data as Data)
            }
        }
        self.newsDescription.text = news.description
    }

}

