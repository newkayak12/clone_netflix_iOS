//
//  PostTitleSubCollectionViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/01.
//

import UIKit


class PostTitleSubCollectionViewCell: UICollectionViewCell {
    static let watchedCellId = "Watched"
    static let favoriteCellId = "Favorite"
    lazy var  imgView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.layer.cornerRadius = 100.0
        return img
    }()
    lazy var  nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "name"
        label.textColor = .white
        label.textAlignment = .center
        label .snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        return label
    }()
    lazy var  descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "description"
        label.textColor = .gray
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        return label
    }()
    lazy var  container: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[self.imgView, self.nameLabel, self.descriptionLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func drawUI() {
        self.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
}
