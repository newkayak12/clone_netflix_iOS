//
//  SearchResultViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/20.
//

import Foundation
import UIKit
import SwiftUI
import RxSwift
import SnapKit

class SearchResultViewController: UIViewController, UISearchResultsUpdating, ViewModelBindable {
    var viewModel: SearchResultViewModel!
    var searchText = PublishSubject<String>()
    
    var segmentIndex = PublishSubject<Int>()
    
    
    lazy var segment: UISegmentedControl = {
        let control = UISegmentedControl(items: ["인기", "영화", "태그", "인물"])
        control.selectedSegmentIndex = 0
        control.rx
            .selectedSegmentIndex
            .changed
            .bind(to: segmentIndex)
            .disposed(by: rx.disposeBag)
        return control;
    }()
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchText.onNext(text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }    
    func setNavigation() {
    }
    
    func wireViewModel() {
        
    }
    
    func setConstraints() {
        segment.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.leading.trailing.equalTo(view)
        }
    }
    
    func prepareUI() {
        view.addSubview(self.segment)
        
        
        self.setConstraints()
        self.segmentChange()
    }
    func segmentChange() {
        segmentIndex.subscribe{
            guard let idx = $0.element else { return }
            Log.warning("CHANGED", idx)
        }.disposed(by: rx.disposeBag)
    }
}
