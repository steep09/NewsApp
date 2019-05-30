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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
