//
//  BaseNavigationController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/18.
//

import UIKit
import SwiftUI

class BaseNavigationViewController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
