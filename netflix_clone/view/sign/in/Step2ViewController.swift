//
//  Step2ViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/14.
//

import Foundation
import UIKit
import SwiftUI

class Step2ViewController: BaseViewController, ViewModelBindable {
    var viewModel: Step2ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        Log.debug("ID", viewModel.id)
    }
    
    func setNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func wireViewModel() {
        
    }
    
    func prepareUI() {
        
    }
}
