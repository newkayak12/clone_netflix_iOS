//
//  SearchViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
import UIKit
import SwiftUI
import RxSwift

class SearchViewController: BaseViewController, ViewModelBindable {
    var viewModel: SearchViewModel!
    
    private var isScrollShow = BehaviorSubject(value: true)
    
    private lazy var squareFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        let size = view.frame.width / 3
        layout.itemSize.width = size
        layout.itemSize.height = size
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }()
    private lazy var rectangleFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        let size = view.frame.width / 3
        layout.itemSize.width = size
        layout.itemSize.height = size * 0.6
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }()
    
    lazy var popularCollectionView: UIStackView = {
        let label = UILabel(frame: .zero)
        label.text = "인기"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.squareFlowLayout)
        collectionView.register(SearchCommonCell.self, forCellWithReuseIdentifier: "\(SearchCommonCell.cellId)_popular")
        self.viewModel.popular.bind(to: collectionView.rx.items(cellIdentifier: "\(SearchCommonCell.cellId)_popular", cellType: SearchCommonCell.self)) { (row, element, cell) in
            Log.warning("POPULAR", "EMIT")
        }.disposed(by: rx.disposeBag)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        let container = UIStackView(arrangedSubviews: [label, collectionView])
        container.axis = .vertical
        return container
    }()
    lazy var recommandCollectionView: UIStackView = {
        let label = UILabel(frame: .zero)
        label.text = "추천 작품"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.squareFlowLayout)
        collectionView.register(SearchCommonCell.self, forCellWithReuseIdentifier: "\(SearchCommonCell.cellId)_recommand")
        self.viewModel.recommand.bind(to: collectionView.rx.items(cellIdentifier: "\(SearchCommonCell.cellId)_recommand", cellType: SearchCommonCell.self)) { (row, element, cell) in
            Log.warning("RECOMMAND", "EMIT")
        }.disposed(by: rx.disposeBag)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        let container = UIStackView(arrangedSubviews: [label, collectionView])
        container.axis = .vertical
        return container
    }()
    lazy var categoryCollectionView: UIStackView = {
        let label = UILabel(frame: .zero)
        label.text = "카테고리"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: rectangleFlowLayout)
        collectionView.register(SearchCommonCell.self, forCellWithReuseIdentifier: "\(SearchCommonCell.cellId)_popular")
        self.viewModel.category.bind(to: collectionView.rx.items(cellIdentifier: "\(SearchCommonCell.cellId)_popular", cellType: SearchCommonCell.self)) { (row, element, cell) in
            Log.warning("CATEGORY", "EMIT")
        }.disposed(by: rx.disposeBag)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        let container = UIStackView(arrangedSubviews: [label, collectionView])
        container.axis = .vertical
        return container
    }()
    
    lazy var container: UIScrollView = {
        let stackView = UIStackView(arrangedSubviews: [popularCollectionView, recommandCollectionView, categoryCollectionView])
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        return scrollView
    }()
    
    lazy var searchBar = {
        let viewModel = SearchResultViewModel(title: "", service: self.viewModel.service)
        var view = SearchResultViewController();
        view.bind(viewModel: viewModel)
        
       let bar = UISearchController(searchResultsController: view)
        
        bar.searchResultsUpdater = view
        bar.searchBar.placeholder = "콘텐츠, 태그, 인물, 리스트 검색"
        bar.searchBar.rx
            .textDidBeginEditing
            .subscribe(onNext: {
                self.container.isHidden = true
            })
            .disposed(by: rx.disposeBag)
        bar.searchBar.rx
            .textDidEndEditing
            .subscribe(onNext: {
                self.container.isHidden = false
            }).disposed(by: rx.disposeBag)
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for view in self.navigationController?.navigationBar.subviews ?? [] {
            let subviews = view.subviews
            if subviews.count > 0, let label = subviews[0] as? UILabel {
                label.textColor = .white
            }
        }
    }
    
    func setNavigation() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        

        
        
        let symbolConf = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        let bellImg = UIImage(systemName: "bell", withConfiguration: symbolConf)
        let profileImg = UIImage(systemName: "person.crop.circle", withConfiguration: symbolConf)
        let profile = UIBarButtonItem(image: profileImg, style: .plain, target: self, action: #selector(fnRouteProfile))
        let bell = UIBarButtonItem(image: bellImg, style: .plain, target: self, action: #selector(fnRouteNotice))
        
        profile.tintColor = .white
        bell.tintColor = .white
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItems = [ profile, bell]
        self.navigationItem.searchController = self.searchBar
        
        navigationItem.title = "찾기"
        navigationItem.titleView = UILabel(frame: .zero)
        
    }
    
    
    func wireViewModel() {
        viewModel.fetchPopular()
        viewModel.fetchRecommand()
        viewModel.fetchCategory()
    }
    
    func setConstraints () {
        self.container.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
    
    func prepareUI() {
        view.addSubview(self.container)
        
        
        self.setConstraints()
    }
    
    
    
    @objc
    private func fnRouteNotice () {
        let noticeViewModel = NoticeViewModel(title: "알림", service: self.viewModel.service)
        var noticeView = NoticeViewController()
        noticeView.bind(viewModel: noticeViewModel)
        let navtigation = UINavigationController(rootViewController: noticeView)
        navigationController?.present(navtigation, animated: true)
        navigationController?.modalPresentationStyle = .fullScreen
    }
    @objc
    func fnRouteProfile () {
        if let token = UserDefaults.standard.string(forKey: Constants.TOKEN.rawValue)  {
            Log.warning("TOKEN", token)
        } else {
            var signInStep1ViewController = Step1ViewController()
            let signInStep1ViewModel = Step1ViewModel(title: "", service: viewModel.service)
            signInStep1ViewController.bind(viewModel: signInStep1ViewModel)
            navigationController?.present(UINavigationController(rootViewController: signInStep1ViewController), animated: true)
            navigationController?.modalPresentationStyle = .fullScreen
        }
    }
    
}