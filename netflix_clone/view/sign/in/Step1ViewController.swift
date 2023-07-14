//
//  Step1ViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/14.
//

import Foundation
import UIKit
import SwiftUI

class Step1ViewController: BaseViewController, ViewModelBindable {
    var viewModel: Step1ViewModel!
    
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
