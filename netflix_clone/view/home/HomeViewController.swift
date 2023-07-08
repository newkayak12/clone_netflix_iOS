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
    
    private let logo = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        return imageView
    }()
    
    private lazy var bannerCollection: UICollectionView  = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize.width = view.frame.width
        layout.itemSize.height = 300
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    private lazy var analysticCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    private lazy var watchedCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    private lazy var newEpisodeCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    private let scrollView = UIScrollView(frame: .zero)
    
    
    func wireViewModel() {
        
        
        bannerCollection.dataSource = nil
        bannerCollection.delegate = nil
        
        bannerCollection.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.cellId)
        viewModel.banners.bind(to: bannerCollection.rx.items(cellIdentifier: BannerCell.cellId, cellType: BannerCell.self)){ (row, element, cell) in
            Log.debug("???", "..")
        }.disposed(by: rx.disposeBag)
        viewModel.fetchBanner()
                     
                        
        
    }
    
    func setNavigation() {
        logo.contentMode = .scaleAspectFit
        logo.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        
        
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo)
        let symbolConf = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        let bellImg = UIImage(systemName: "bell", withConfiguration: symbolConf)
        let profileImg = UIImage(systemName: "person.crop.circle", withConfiguration: symbolConf)
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(image: profileImg, style: .plain, target: nil, action: nil), UIBarButtonItem(image: bellImg, style: .plain, target: nil, action: nil)]
    }
    
    func prepareUI() {
        self.setNavigation()
        
        let bannerView = UIView(frame: .zero)
        bannerView.backgroundColor = .white
        let analysticView = UIView(frame: .zero)
        analysticView.backgroundColor = .red
        let watchedView = UIView(frame: .zero)
        watchedView.backgroundColor = .blue
        let newEpisodView = UIView(frame: .zero)
        newEpisodView.backgroundColor = .yellow
        
        let footerView = UIView(frame: .zero)
        footerView.backgroundColor = .cyan
        
        
        bannerView.addSubview(bannerCollection)
        
        
        let stackView: UIStackView = UIStackView(arrangedSubviews: [
           bannerView,
           analysticView,
           watchedView,
           newEpisodView,
           footerView
        ])
        
        
        //, analysticCollection,watchedCollection, newEpisodeCollection
        
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = CGFloat(20)
//        stackView.alignment = .leading
//        stackView.distribution = .fill
        
        
        scrollView.bounces = true
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        
        
       
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        bannerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(300)
            make.leading.trailing.equalTo(bannerCollection)
        }
        bannerCollection.snp.makeConstraints { make in
            make.width.height.leading.top.equalTo(bannerView)
        }
        
        analysticView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(200)
        }
        watchedView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(200)
        }
        newEpisodView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(200)
        }
        footerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(100)
        }
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        #if DEBUG
        #endif
    }


}
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct Preview: PreviewProvider {

    static var previews: some View {
        // view controller using programmatic UI
        MainViewController().toPreview()
    }
}
#endif
