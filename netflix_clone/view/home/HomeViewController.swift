//
//  MainViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/01.
//

import UIKit
import SwiftUI
import SnapKit

class HomeViewController: BaseViewController, ViewModelBindable {
    var viewModel: HomeViewModel!
    
    private let logo = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        return imageView
    }()
    private let bannerCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    private let analysticCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    private let watchedCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    private let newEpisodeCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    private let container = UIScrollView(frame: .zero)
   
   
    
    
    func wireViewModel() {
        
        
    }
    
    
    func prepareUI() {
        logo.contentMode = .scaleAspectFit
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo)
        let symbolConf = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        let bellImg = UIImage(systemName: "bell", withConfiguration: symbolConf)
        let profileImg = UIImage(systemName: "person.crop.circle", withConfiguration: symbolConf)
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(image: profileImg, style: .plain, target: nil, action: nil), UIBarButtonItem(image: bellImg, style: .plain, target: nil, action: nil)]
       
        let innerContainer: UIStackView = UIStackView(arrangedSubviews: [bannerCollection, analysticCollection,watchedCollection, newEpisodeCollection])
        innerContainer.axis = .vertical
        innerContainer.spacing = CGFloat(10)
        
        
        container.addSubview(innerContainer)
        view.addSubview(container)
        
        
        logo.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        view.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(container)
        }
        innerContainer.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bannerCollection)
            make.leading.trailing.equalTo(analysticCollection)
            make.leading.trailing.equalTo(watchedCollection)
            make.leading.trailing.equalTo(newEpisodeCollection)
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        #if DEBUG
        prepareUI()
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
