//
//  MyViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
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
    lazy var flowLayout = {
        var layout = UICollectionViewFlowLayout()
        let size = (view.frame.width - 40) / 3
        layout.itemSize.width = size
        layout.itemSize.height = size * 1.2
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }()
    lazy var watchedCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.register(PostTitleSubCollectionViewCell.self, forCellWithReuseIdentifier: PostTitleSubCollectionViewCell.watchedCellId)
        self.viewModel.watchSubject.bind(to: collectionView.rx.items(cellIdentifier: PostTitleSubCollectionViewCell.watchedCellId, cellType: PostTitleSubCollectionViewCell.self)) {
            (row, element, cell)in
                                                                                                                                                                    
            cell.nameLabel.text = "WATCHED"
        }.disposed(by: rx.disposeBag)
        return collectionView
    }()
    lazy var favoriteCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.register(PostTitleSubCollectionViewCell.self, forCellWithReuseIdentifier: PostTitleSubCollectionViewCell.favoriteCellId)
        self.viewModel.favoriteSubject.bind(to: collectionView.rx.items(cellIdentifier: PostTitleSubCollectionViewCell.favoriteCellId, cellType: PostTitleSubCollectionViewCell.self)) {
            (row, element, cell)in
            
            cell.nameLabel.text = "FAVORITE"
        }.disposed(by: rx.disposeBag)
        collectionView.isHidden = true
        
        return collectionView
    }()
    
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
    func wireViewModel() {
        self.viewModel
            .segmentIndex
            .subscribe{
                Log.debug("BEHAVIOR", $0)
                switch $0.element! {
                    case 0:
                        self.watchedCollectionView.isHidden = true
                        self.favoriteCollectionView.isHidden = false
                        self.viewModel.fetchFavorite()
                        self.viewModel.resetWatched()
                    case 1:
                        self.watchedCollectionView.isHidden = false
                        self.favoriteCollectionView.isHidden = true
                        self.viewModel.fetchWatched()
                        self.viewModel.resetFavorite()
                    default: break;
                }
            }
            .disposed(by: rx.disposeBag)
    }
    
    func setConstraints() {
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
    
    
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.segmentIndex.onNext(0)
    }
    
    
    func prepareUI() {
        view.addSubview(self.segment)
        view.addSubview(self.favoriteCollectionView)
        view.addSubview(self.watchedCollectionView)
        
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
