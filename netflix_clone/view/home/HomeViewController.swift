//
//  MainViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/01.
//

import UIKit
import SwiftUI
import RxCocoa
import SnapKit
import RxSwift
import NSObject_Rx


class HomeViewController: BaseViewController, ViewModelBindable {
    var viewModel: HomeViewModel!
    
    private let analyzeflowDelegate = AnalyzeFlow()
    
    private let logo = {
        let imageView = UIImageView(image: UIImage(named: "logo")?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: 0, bottom: -5, right: 0)))
        return imageView
    }()
    
    private let scrollView = UIScrollView(frame: .zero)
    private var stackView: UIStackView?
    private let bannerView = UIView(frame: .zero)
    private let analysticView = UIView(frame: .zero)
    private let rankView = UIView(frame: .zero)
    private let watchedView = UIView(frame: .zero)
    private let newEpisodeView = UIView(frame: .zero)
    private let categoryView = UIView(frame: .zero)
    private let footerView = Footer(frame: .zero)
    
    private let rankLabel = UILabel(frame: .zero)
    private let watchLabel = UILabel(frame: .zero)
    private let newEpisodeLabel = UILabel(frame: .zero)
    private let categoryLabel = UILabel(frame: .zero)
    
    private lazy var bannerCollection: UICollectionView  = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize.width = view.frame.width
        layout.itemSize.height = 500
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    private lazy var analysticCollection = {
        var layout = UICollectionViewFlowLayout()
        
        var collectionLayout = UICollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Paging.itemSize // <-
        layout.minimumLineSpacing = Paging.itemSpacing // <-
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .clear
        
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
     
        
        collectionView.contentInset = Paging.collectionViewContentInset
        collectionView.decelerationRate = .fast
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    private lazy var posterFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize.width = view.frame.width / 4
        layout.itemSize.height = 200
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }()
    private lazy var rankCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.posterFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = false
        return collectionView
    }()
    private lazy var watchedCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.posterFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    private lazy var newEpisodeCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.posterFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    private lazy var categoryCollection = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize.width = view.frame.width / 2
        layout.itemSize.height = 150
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = false
        return collectionView
    }()
    
    private lazy var rankStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.rankLabel, self.rankCollection])
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var watchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.watchLabel, self.watchedCollection])
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var newEpisodeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.newEpisodeLabel, self.newEpisodeCollection])
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.categoryLabel, self.categoryCollection])
        stackView.axis = .vertical
        return stackView
    }()
    
    func wireBanner () {
        bannerCollection.dataSource = nil
        bannerCollection.delegate = nil
        bannerCollection.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.cellId)
        viewModel.banners.bind(to: bannerCollection.rx.items(cellIdentifier: BannerCell.cellId, cellType: BannerCell.self)){ (row, element, cell) in
            Log.warning("BANNER", "..")
        }.disposed(by: rx.disposeBag)
    }
    func wireAnalyze () {
        
        analysticCollection.delegate = analyzeflowDelegate
        analysticCollection.register(AnalyzeCell.self, forCellWithReuseIdentifier: AnalyzeCell.cellId)
        viewModel.analyze.bind(to: analysticCollection.rx.items(cellIdentifier: AnalyzeCell.cellId, cellType: AnalyzeCell.self)) {(row, element, cell) in
            Log.warning("ANAYLSTIC", "..")
        }.disposed(by: rx.disposeBag)
    }
    func wireRank () {
        rankCollection.dataSource = nil
        rankCollection.delegate = nil
        rankCollection.register(PosterCell.self, forCellWithReuseIdentifier: PosterTypeId.WATCHED.rawValue)
        viewModel.rank.bind(to: rankCollection.rx.items(cellIdentifier: PosterTypeId.WATCHED.rawValue, cellType: PosterCell.self)){ (row, element, cell) in
            Log.warning("RANK", "..")
        }.disposed(by: rx.disposeBag)
    }
    func wireWatched () {
        watchedCollection.dataSource = nil
        watchedCollection.delegate = nil
        watchedCollection.register(PosterCell.self, forCellWithReuseIdentifier: PosterTypeId.WATCHED.rawValue)
        viewModel.watched.bind(to: watchedCollection.rx.items(cellIdentifier: PosterTypeId.WATCHED.rawValue, cellType: PosterCell.self)){ (row, element, cell) in
            Log.warning("WATCHED", "..")
            cell.type = PosterTypeId.WATCHED
            cell.drawInfoLine()
        }.disposed(by: rx.disposeBag)
    }
    func wireEpisode () {
        newEpisodeCollection.dataSource = nil
        newEpisodeCollection.delegate = nil
        newEpisodeCollection.register(PosterCell.self, forCellWithReuseIdentifier: PosterTypeId.EPISODE.rawValue)
        viewModel.watched.bind(to: newEpisodeCollection.rx.items(cellIdentifier: PosterTypeId.EPISODE.rawValue, cellType: PosterCell.self)){ (row, element, cell) in
            Log.warning("EPI", "..")
            cell.type = PosterTypeId.EPISODE
        }.disposed(by: rx.disposeBag)
    }
    func wireCategory () {
        categoryCollection.dataSource = nil
        categoryCollection.delegate = nil
        categoryCollection.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.cellId)
        viewModel.category.bind(to: categoryCollection.rx.items(cellIdentifier: CategoryCell.cellId, cellType: CategoryCell.self)){ (row, element, cell) in
            Log.warning("category", "..")
        }.disposed(by: rx.disposeBag)
        
    }
    
    
    
    func wireViewModel() {
       
        self.wireBanner()
        self.wireAnalyze()
        self.wireRank()
        self.wireWatched()
        self.wireEpisode()
        self.wireCategory()
        
        
        
        viewModel.fetchBanner()
        viewModel.fetchAnalyze()
        viewModel.fetchRank()
        viewModel.fetchWatched()
        viewModel.fetchNewEpisode()
        viewModel.fetchCategory()
    }
    
    func setNavigation() {
     
        logo.contentMode = .scaleAspectFit
        logo.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo)
        let symbolConf = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        let bellImg = UIImage(systemName: "bell", withConfiguration: symbolConf)
        let profileImg = UIImage(systemName: "person.crop.circle", withConfiguration: symbolConf)
        
        let profile = UIBarButtonItem(image: profileImg, style: .plain, target: self, action: #selector(fnRouteProfile))
        let bell = UIBarButtonItem(image: bellImg, style: .plain, target: self, action: #selector(fnRouteNotice))
        
        profile.tintColor = .white
        bell.tintColor = .white
        navigationItem.rightBarButtonItems = [ profile, bell]
    }
    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
        stackView?.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        bannerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView!)
            make.height.equalTo(500)
            make.leading.trailing.equalTo(bannerCollection)
        }
        bannerCollection.snp.makeConstraints { make in
            make.width.height.leading.top.equalTo(bannerView)
        }
        
        analysticView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView!)
            make.height.equalTo(300)
            make.leading.trailing.equalTo(analysticCollection)
        }
        analysticCollection.snp.makeConstraints { make in
            make.width.height.leading.top.equalTo(analysticView)
        }
        
        rankView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView!)
            make.height.equalTo(200)
        }
        rankStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(rankView)
        }
        rankLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(rankStackView)
        }
        
        
        watchedView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView!)
            make.height.equalTo(200)
        }
        watchStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(watchedView)
        }
        watchLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(watchStackView)
        }
        
        
        newEpisodeView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView!)
            make.height.equalTo(200)
        }
        newEpisodeStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(newEpisodeView)
        }
        newEpisodeLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(newEpisodeStackView)
        }
        
        categoryView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView!)
            make.height.equalTo(150)
        }
        categoryStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(categoryView)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(categoryStackView)
//            make.bottom.equalTo(categoryStackView).offset(10)
        }
        
        footerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView!)
            make.height.equalTo(200)
        }
    }
    func setAttributes() {
        bannerView.backgroundColor = .clear
        analysticView.backgroundColor = .clear
        rankView.backgroundColor = .clear
        watchedView.backgroundColor = .clear
        newEpisodeView.backgroundColor = .clear
        categoryView.backgroundColor = .clear
        footerView.backgroundColor = .clear
        
        
        stackView?.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        stackView?.isLayoutMarginsRelativeArrangement = true
        stackView?.axis = .vertical
        stackView?.spacing = CGFloat(40)
        
        rankLabel.text = "Top 10"
        rankLabel.textColor = .white
        watchLabel.text = "이어보기"
        watchLabel.textColor = .white
        newEpisodeLabel.text = "새로 올라온 에피소드"
        newEpisodeLabel.textColor = .white
        categoryLabel.text = "카테고리별 추천"
        categoryLabel.textColor = .white
        
        rankStackView.spacing = CGFloat(15)
        watchStackView.spacing = CGFloat(15)
        newEpisodeStackView.spacing = CGFloat(15)
        categoryStackView.spacing = CGFloat(15)
        
        
        
        scrollView.bounces = true
    }
    
    func prepareUI() {
        
        bannerView.addSubview(bannerCollection)
        analysticView.addSubview(analysticCollection)
        rankView.addSubview(rankStackView)
        watchedView.addSubview(watchStackView)
        newEpisodeView.addSubview(newEpisodeStackView)
        categoryView.addSubview(categoryStackView)
        
        stackView = UIStackView(arrangedSubviews: [
            bannerView,
            analysticView,
            rankView,
            watchedView,
            newEpisodeView,
            categoryView,
            footerView
        ])

        scrollView.addSubview(stackView!)
        view.addSubview(scrollView)
        
        self.setAttributes()
        self.setConstraints()
    }
    
    //methods
    
    //push, present
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
        UserDefaults.standard.set("Bearer ABC", forKey: Constants.TOKEN.rawValue)
        if let token = UserDefaults.standard.string(forKey: Constants.TOKEN.rawValue)  {
            Log.error("EXIST", token)
        } else {
            Log.error("NON", "")
        }
    }
    func fnTouchMovie ( contentsInfoNo: Int ){
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        #if DEBUG
        
        #endif
    }
}

#if DEBUG
@available(iOS 13, *)
struct HomePreview: PreviewProvider {

    static var previews: some View {
        // view controller using programmatic UI
        MainViewController().toPreview()
    }
}
#endif

