//
//  SearchViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import UIKit
import SwiftUI
import RxSwift

class SearchViewController: BaseViewController, ViewModelBindable {
    var viewModel: SearchViewModel!
    
    
    private var isScrollShow = BehaviorSubject(value: true)
    
    lazy var popularCollectionView: UIStackView = {
        let label = UILabel(frame: .zero)
        label.text = "인기"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        var layout = UICollectionViewFlowLayout()
        let size = view.frame.width / 3
        layout.itemSize.width = size
        layout.itemSize.height = size
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCommonCell.self, forCellWithReuseIdentifier: "\(SearchCommonCell.cellId)_popular")
        self.viewModel.popular.bind(to: collectionView.rx.items(cellIdentifier: "\(SearchCommonCell.cellId)_popular", cellType: SearchCommonCell.self)) { (row, element, cell) in
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
        
        var layout = UICollectionViewFlowLayout()
        let size = view.frame.width / 3
        layout.itemSize.width = size
        layout.itemSize.height = size
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        var layout = UICollectionViewFlowLayout()
        let size = view.frame.width / 3
        layout.itemSize.width = size
        layout.itemSize.height = size * 0.6
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    
    lazy var searchTextTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(RecommandTableViewCell.self, forCellReuseIdentifier: RecommandTableViewCell.cellId)
        tableView.isHidden = true
        self.viewModel.lastSearchText.bind(to: tableView.rx.items(cellIdentifier: RecommandTableViewCell.cellId, cellType: RecommandTableViewCell.self)) {
            (row, element, cell) in
            cell.rowNumber = row
            cell.label.text = element
            cell.button.tag = row
            cell.callBackMehtod = self.searchTextTableTouchXmark
        }.disposed(by: rx.disposeBag)
        
        return tableView
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
                self.searchTextTable.isHidden = false
            }).disposed(by: rx.disposeBag)
        
        bar.searchBar.rx
            .textDidEndEditing
            .subscribe(onNext: {
                self.container.isHidden = false
                self.searchTextTable.isHidden = true
            }).disposed(by: rx.disposeBag)
        
        bar.searchBar
            .searchTextField
            .rx.text
            .debounce(.milliseconds(300), scheduler: MainScheduler().self)
            .withUnretained(self)
            .subscribe(onNext: { (this, data) in
                if let txt = data, !txt.isEmpty, txt.count > 0 {
                    this.viewModel.searchText.append(txt)
                    this.viewModel.lastSearchText.onNext(this.viewModel.searchText)
                }
            })
            .disposed(by: rx.disposeBag)
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
        
        self.loadSearchText()
    }
 
    
    func loadSearchText () {
        UserDefaults.standard.setValue(["test1", "test2", "test3", "test4", "test5"], forKey: Constants.SEARCH_KEYWORK.rawValue)
        
        guard let array = UserDefaults.standard.array(forKey: Constants.SEARCH_KEYWORK.rawValue) else { return }
        if let keyword = array as? [String], keyword.count > 0 {
            viewModel.searchText = keyword
            viewModel.lastSearchText.onNext(keyword)
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
        self.searchTextTable.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view)
        }
    }
    
    func prepareUI() {
        view.addSubview(self.container)
        view.addSubview(self.searchTextTable)
        
        
        self.setConstraints()
        self.searchTextTableSelectEvent()
    }
    
    
    
    @objc
    private func fnRouteNotice () {
        let noticeViewModel = NoticeViewModel(title: "알림", service: self.viewModel.service)
        var noticeView = NoticeViewController()
        noticeView.bind(viewModel: noticeViewModel)
        navigationController?.pushViewController(noticeView, animated: true)
        //        navigationController?.modalPresentationStyle = .fullScreen
    }
    @objc
    func fnRouteProfile () {
        //        if let token = UserDefaults.standard.string(forKey: Constants.TOKEN.rawValue)  {
        //        } else {
        var signInStep1ViewController = Step1ViewController()
        let signInStep1ViewModel = Step1ViewModel(title: "", service: viewModel.service)
        signInStep1ViewController.bind(viewModel: signInStep1ViewModel)
        navigationController?.pushViewController(signInStep1ViewController, animated: true)
        //            navigationController?.push = .fullScreen
        //        }
    }
    
    func searchTextTableTouchXmark(index: Int){
        var keyList = viewModel.searchText
        keyList.remove(at: index)
        viewModel.searchText = keyList
        viewModel.lastSearchText.onNext(keyList)
    }
    
    func searchTextTableSelectEvent(){
        Observable.zip(self.searchTextTable.rx.modelSelected(String.self) , self.searchTextTable.rx.itemSelected)
            .withUnretained(self)
            .do(onNext: { this, data in
                this.searchTextTable.deselectRow(at: data.1, animated: true)
            })
                .map{$0.1}
                .withUnretained(self)
                .subscribe{
                    this, data in
                    this.searchBar.searchBar.text = data.0
                }.disposed(by: rx.disposeBag)
    }
   
    
}
