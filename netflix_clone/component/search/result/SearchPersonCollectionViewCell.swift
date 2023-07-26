//
//  SearchPersonCollectionViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/26.
//

import Foundation
import UIKit
import RxSwift

class SearchPersonCollectionViewCell: UICollectionViewCell {
    static let cellId = "SearchPersonCell"
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
    
    lazy var  roleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "role"
        label.textColor = .gray
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        return label
    }()
    
    lazy var  container: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[self.imgView, self.nameLabel, self.roleLabel])
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
    
    func drawUI() {
        self.contentView.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self.contentView)
        }
    }
}

