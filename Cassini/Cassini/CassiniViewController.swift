//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Martin Vacas on 6/9/17.
//  Copyright © 2017 Martin Vacas. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let url = DemoURL.NASA[segue.identifier ?? ""] {
            if let imageVC = segue.destination.contents as? ImageViewController {
                imageVC.imageURL = url
                imageVC.title = segue.identifier
                
            }
        }
    }


}

extension UIViewController {
    var contents: UIViewController {
        if let navCon = self as? UINavigationController {
            return navCon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
