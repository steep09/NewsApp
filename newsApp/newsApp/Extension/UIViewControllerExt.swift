//
//  UIViewControllerExt.swift
//  newsApp
//
//  Created by Stephenson Ang on 10/06/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
}
