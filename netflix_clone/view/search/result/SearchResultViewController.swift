//
//  SearchResultViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/20.
//

import Foundation
import UIKit
import SwiftUI
class SearchResultViewController: UIViewController, UISearchResultsUpdating, ViewModelBindable {
    var viewModel: SearchResultViewModel!
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        Log.debug("TEXT >>> ", text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    
    func setNavigation() {
    }
    
    func wireViewModel() {
    }
    
    func prepareUI() {
    }
}
