//
//  News.swift
//  newsApp
//
//  Created by Stephenson Ang on 31/05/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import Foundation

struct News {
    var title: String!
    var image: String!
    var description: String!
    
    init(title: String, image: String, description: String) {
        self.title = title
        self.image = image
        self.description = description
    }
}
