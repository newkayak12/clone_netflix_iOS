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
        layout.itemSize.height = 200
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.isScrollEnabled = true
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
        
        let stackView: UIStackView = UIStackView(arrangedSubviews: [
            bannerCollection,
        ])
        
        
        //, analysticCollection,watchedCollection, newEpisodeCollection
        
        
        stackView.axis = .vertical
        stackView.spacing = CGFloat(100)
        
        
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        
        
       
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
            make.height.equalTo(stackView)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        bannerCollection.snp.makeConstraints { make in
            make.leading.trailing.width.equalTo(stackView)
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
