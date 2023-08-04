//
//  ViewModelBindable.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/01.
//

import UIKit
protocol ViewModelBindable {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
    func setNavigation()
    func wireViewModel()
    func prepareUI()
}

extension ViewModelBindable where Self: UIViewController {
    mutating func bind( viewModel: Self.ViewModel ) {
        self.viewModel = viewModel
        setNavigation()
        prepareUI()
        wireViewModel()
        loadViewIfNeeded()
    }
}
