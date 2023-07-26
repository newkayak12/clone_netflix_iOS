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
    var nowIndex: Int = 0
    var segmentIndex = PublishSubject<Int>()
    
    
    lazy var popularTable = {
        let tableView = UITableView(frame: .zero)
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.cellId)
        self.viewModel.popularSubject.bind(to : tableView.rx.items(cellIdentifier: SearchResultTableViewCell.cellId, cellType: SearchResultTableViewCell.self)) {
            (row, element, cell) in
            
            Log.debug("popularTable", element)
            cell.
            
        }.disposed(by: rx.disposeBag)
        tableView.isHidden = true
        return tableView
    }()
    
    lazy var movieCollection = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.itemSize.width = (view.frame.width - 20.0) / 3
        flowLayout.itemSize.height = flowLayout.itemSize.width * 1.4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SearchPosterCollectionViewCell.self, forCellWithReuseIdentifier: "movie_\(SearchPosterCollectionViewCell.cellId)")
        self.viewModel.movieSubject.bind(to: collectionView.rx.items(cellIdentifier: "movie_\(SearchPosterCollectionViewCell.cellId)", cellType:SearchPosterCollectionViewCell.self)) {
            (row, element, cell) in
            
            Log.debug("movieCollection", element)
            
        }.disposed(by: rx.disposeBag)
        collectionView.isHidden = true
        return collectionView
    }()
    
    lazy var tagCollection = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.itemSize.width = (view.frame.width - 20.0) / 3
        flowLayout.itemSize.height = flowLayout.itemSize.width * 1.4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SearchPosterCollectionViewCell.self, forCellWithReuseIdentifier: "tag_\(SearchPosterCollectionViewCell.cellId)")
        
        self.viewModel.movieSubject.bind(to: collectionView.rx.items(cellIdentifier: "tag_\(SearchPosterCollectionViewCell.cellId)", cellType:SearchPosterCollectionViewCell.self)) {
            (row, element, cell) in
            
            Log.debug("movieCollection", element)
            
        }.disposed(by: rx.disposeBag)
        
        collectionView.isHidden = true
        return collectionView
    }()
    
    lazy var personCollection = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize.width = ( view.frame.width - 10 ) / 2
        flowLayout.itemSize.height = flowLayout.itemSize.width 
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SearchPersonCollectionViewCell.self, forCellWithReuseIdentifier: SearchPersonCollectionViewCell.cellId)
        
        self.viewModel.personSubject.bind(to: collectionView.rx.items(cellIdentifier: SearchPersonCollectionViewCell.cellId, cellType:SearchPersonCollectionViewCell.self)) {
            (row, element, cell) in
            
            Log.debug("personCollection", element)
            
        }.disposed(by: rx.disposeBag)
        
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
        segmentIndex.onNext(self.nowIndex)
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
        
        popularTable.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(self.segment.snp.bottom).offset(10)
        }
        movieCollection.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(self.segment.snp.bottom).offset(10)
        }
        personCollection.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(self.segment.snp.bottom).offset(10)
        }
        tagCollection.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(self.segment.snp.bottom).offset(10)
        }
    }
    
    func prepareUI() {
        view.addSubview(self.segment)
        view.addSubview(self.popularTable)
        view.addSubview(self.movieCollection)
        view.addSubview(self.personCollection)
        view.addSubview(self.tagCollection)
        
        
        self.setConstraints()
        self.segmentChange()
    }
    func segmentChange() {
        segmentIndex.subscribe{
            guard let idx = $0.element else { return }
            
            self.popularTable.isHidden = true
            self.movieCollection.isHidden = true
            self.tagCollection.isHidden = true
            self.personCollection.isHidden = true
            switch idx {
                case 1:
                    self.nowIndex = idx
                    self.movieCollection.isHidden = false
                    self.viewModel.fetchMovie()
                case 2:
                    self.nowIndex = idx
                    self.tagCollection.isHidden = false
                    self.viewModel.fetchTag()
                case 3:
                    self.nowIndex = idx
                    self.personCollection.isHidden = false
                    self.viewModel.fetchPerson()
                default:
                    self.nowIndex = 0
                    self.popularTable.isHidden = false
                    self.viewModel.fetchPopular()
            }
        }.disposed(by: rx.disposeBag)
    }
}
