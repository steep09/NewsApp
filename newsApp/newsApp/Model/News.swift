//
//  News.swift
//  newsApp
//
//  Created by Stephenson Ang on 31/05/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import Foundation

struct News: Decodable {
    let articles: [Article]
    
    struct Article: Decodable {
        let title: String?
        let urlToImage: String?
        let description: String?
        let url: String?
    }
}
