//
//  NoticeDetailViewContorller.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/27.
//

import RxCocoa
import UIKit
import Kingfisher

class NoticeDetailViewController: BaseViewController, ViewModelBindable  {
    var viewModel: NoticeDetailViewModel!
    
    
    
    func setNavigation() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let backButton = UIButton(frame: .zero)
        backButton.addTarget(self, action: #selector(fnBackBtn), for: .touchUpInside)
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(18), weight: .bold)), for: .normal)
        let label = UILabel(frame: .zero)
        label.text = self.viewModel.title
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton), UIBarButtonItem(customView: label)]
        
        
        
    }
    
    func wireViewModel() {
    }
    
    func prepareUI() {
        guard let notice = self.viewModel.notice else  { return }
        let date = notice.regDate
        let content = notice.content
        
        let dateLabel = UILabel(frame: .zero)
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        dateLabel.text = dateFormat.string(from: date)
        dateLabel.textColor = .gray
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize.width = 100
        layout.itemSize.height = 100
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(NoticeDetailImageCollectionViewCell.self, forCellWithReuseIdentifier: NoticeDetailImageCollectionViewCell.cellId)
        if viewModel.notice?.images.count == 0 {
            collectionView.isHidden = true
        }
        
        let textView = UITextView(frame: .zero)
        textView.text = content
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 20)
        
        let stackView = UIStackView(arrangedSubviews: [dateLabel, textView, collectionView])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.bottom.equalTo(view.layoutMarginsGuide).offset(10)
        }
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    @objc
    func fnBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension NoticeDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.notice?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoticeDetailImageCollectionViewCell.cellId, for: indexPath) as? NoticeDetailImageCollectionViewCell else {return UICollectionViewCell()}
        if let image = viewModel.notice?.images[indexPath.item] {
            cell.imageView.kf.setImage(with: ImageApi.imgUrl(url: "/"+image.storedFileName))
        }
        
        return cell
    }
    
}
