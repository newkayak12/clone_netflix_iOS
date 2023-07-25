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
    
    
    lazy var pouplarCollection = {
        let tableView = UITableView(frame: .zero)
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.cellId)
        tableView.isHidden = false
        return tableView
    }()
    
    lazy var movieCollection = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.itemSize.width = (view.frame.width - 20.0) / 3
        flowLayout.itemSize.height = flowLayout.itemSize.width * 1.4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SearchPosterCollectionViewCell.self, forCellWithReuseIdentifier: SearchPosterCollectionViewCell.cellId)
        collectionView.isHidden = true
        return collectionView
    }()
    lazy var tagCollection = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isHidden = true
        return collectionView
    }()
    lazy var personCollection = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isHidden = true
        return collectionView
    }()
    
    
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
            
            self.pouplarCollection.isHidden = true
            self.movieCollection.isHidden = true
            self.tagCollection.isHidden = true
            self.personCollection.isHidden = true
            switch idx{
                case 1:
                    self.movieCollection.isHidden = false
                case 2:
                    self.tagCollection.isHidden = false
                case 3:
                    self.personCollection.isHidden = false
                default:
                    self.pouplarCollection.isHidden = false
            }
        }.disposed(by: rx.disposeBag)
    }
}
