//
//  PersonViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/14.
//

import UIKit
import RxCocoa

class PersonViewController:  BaseViewController, ViewModelBindable {
    var viewModel: PersonViewModel!
    
    lazy var contentsCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let size = floor((view.frame.width - 40) / 3)
        flowLayout.itemSize.width = size
        flowLayout.itemSize.height = 100
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(PersonContentsCollectionViewCell.self, forCellWithReuseIdentifier: PersonContentsCollectionViewCell.cellId)
        
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    
    
    func setNavigation() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        navigationItem.title = self.viewModel.title
        navigationItem.titleView = UILabel(frame: .zero)
        
        let backButton = UIButton(frame: .zero)
        backButton.addTarget(self, action: #selector(fnBackBtn), for: .touchUpInside)
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(18), weight: .bold)), for: .normal)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton)]
        
    }
    
    func wireViewModel() {
        self.viewModel.contentsSubject.bind(to: self.contentsCollectionView.rx.items(cellIdentifier: PersonContentsCollectionViewCell.cellId, cellType: PersonContentsCollectionViewCell.self)) {
            (row, element, cell) in
            Log.debug("COLLECTIONVIEW", "CELL")
        }.disposed(by: rx.disposeBag)
        
    }
    
    func prepareUI() {
        view.addSubview(contentsCollectionView)
        
        
        contentsCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.layoutMarginsGuide)
            make.leading.trailing.equalTo(view)
        }
    }
    
    @objc
    func fnBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
}
