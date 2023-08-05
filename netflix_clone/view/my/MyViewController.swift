//
//  MyViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import UIKit
import SwiftUI

class MyViewController: BaseViewController, ViewModelBindable {
    var viewModel: MyViewModel!
    
    
    lazy var segment: UISegmentedControl = {
        let control = UISegmentedControl(items: ["보고싶어요한 컨텐츠", "다 본 컨텐츠"])
        control.selectedSegmentIndex = 0
        control.rx
            .selectedSegmentIndex
            .changed
            .bind(to: self.viewModel.segmentIndex)
            .disposed(by: rx.disposeBag)
        
        return control;
    }()
    
    
    lazy var watchedCollectionView = {
        var layout = UICollectionViewFlowLayout()
        let size = (view.frame.width - 40) / 3
        layout.itemSize.width = size
        layout.itemSize.height = size * 1.2
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PostTitleSubCollectionViewCell.self, forCellWithReuseIdentifier: PostTitleSubCollectionViewCell.watchedCellId)
        collectionView.backgroundColor = .cyan
        collectionView.isHidden = true
        return collectionView
    }()
    
    lazy var favoriteCollectionView = {
        var layout = UICollectionViewFlowLayout()
        let size = (view.frame.width - 40) / 3
        layout.itemSize.width = size
        layout.itemSize.height = size * 1.2
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PostTitleSubCollectionViewCell.self, forCellWithReuseIdentifier: PostTitleSubCollectionViewCell.favoriteCellId)
        collectionView.backgroundColor = .red
        collectionView.isHidden = true
        return collectionView
    }()
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        
        navigationItem.title = "보관함"
        navigationItem.titleView = UILabel(frame: .zero)
    }
    
    func setConstraints() {
        Log.warning("setConstraints")
        segment.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.leading.trailing.equalTo(view)
        }
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view)
        }
        watchedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view)
        }
    }
    
    func prepareUI() {
        Log.warning("prepareUI")
        view.addSubview(self.segment)
        view.addSubview(self.favoriteCollectionView)
        view.addSubview(self.watchedCollectionView)
        
        self.setConstraints()
    }
    
    func wireViewModel() {
        Log.warning("wireViewModel")
        self.wireWatchCollectionView()
        self.wireFavoriteCollectionView()
        self.wireSegmentCotroller()
    }
    
    
    
    func wireWatchCollectionView () {
        Log.info("wireWatchCollectionView")
        self.viewModel.watchSubject.bind(to: watchedCollectionView.rx.items(cellIdentifier: PostTitleSubCollectionViewCell.watchedCellId, cellType: PostTitleSubCollectionViewCell.self)) {
            (row, element, cell)in
            
            cell.nameLabel.text = "WATCHED"
        }.disposed(by: rx.disposeBag)
        
        
        watchedCollectionView.rx.itemSelected.bind {
            self.fnRouteDetail(indexPath: $0)
        }.disposed(by: rx.disposeBag)
        
    }
    
    func wireFavoriteCollectionView () {
        Log.info("wireFavoriteCollectionView")
        self.viewModel.favoriteSubject.bind(to: favoriteCollectionView.rx.items(cellIdentifier: PostTitleSubCollectionViewCell.favoriteCellId, cellType: PostTitleSubCollectionViewCell.self)) {
            (row, element, cell)in
            
            cell.nameLabel.text = "FAVORITE"
        }.disposed(by: rx.disposeBag)
        
        favoriteCollectionView.rx.itemSelected.bind {
            self.fnRouteDetail(indexPath: $0)
        }.disposed(by: rx.disposeBag)
    }
    
    func wireSegmentCotroller () {
        self.viewModel
            .segmentIndex
            .subscribe{
                self.viewModel.resetWatched()
                self.viewModel.resetFavorite()
                Log.error("_____________", $0)
                Log.warning("sect", self.segment.frame.height)
                Log.warning("sect", self.segment.constraints)
                Log.warning("fav?", self.favoriteCollectionView.isHidden)
                Log.warning("fav?", self.favoriteCollectionView.frame.height)
                Log.warning("fav", self.favoriteCollectionView.constraints)
                Log.warning("wat?", self.watchedCollectionView.isHidden)
                Log.warning("wat?", self.watchedCollectionView.frame.height)
                Log.warning("wat", self.watchedCollectionView.constraints)
                
                if let value =  $0.element, value == 0 {
                    self.watchedCollectionView.isHidden = true
                    self.favoriteCollectionView.isHidden = false
                    self.viewModel.fetchFavorite()
                } else {
                    self.watchedCollectionView.isHidden = false
                    self.favoriteCollectionView.isHidden = true
                    self.viewModel.fetchWatched()
                }
                self.view.layoutIfNeeded()
            }
            .disposed(by: rx.disposeBag)
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
    
    func fnRouteDetail( indexPath: IndexPath ) {
        Log.debug("INDEX", indexPath)
        let viewModel = DetailViewModel(title: "", service: self.viewModel.service)
        var viewController = DetailViewController();
        viewController.bind(viewModel: viewModel);
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
