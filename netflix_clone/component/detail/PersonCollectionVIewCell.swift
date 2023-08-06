//
//  personCollectionVIewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/06.
//

import UIKit
import SnapKit

class PersonCollectionViewCell: UICollectionViewCell {
    static let cellId = "Person"
    
    lazy var imageView = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.layer.cornerRadius = 100.0
        return img
    }()
    
    lazy var title = {
        let label = UILabel(frame: .zero)
        label.text = "name"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var subTitle = {
        let label = UILabel(frame: .zero)
        label.text = "name"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var verticalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.title, self.subTitle])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy var horizontalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.imageView, self.verticalStackView])
        stackView.axis = .horizontal
        
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
        self.addSubview(self.horizontalStackView)
        
        self.horizontalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
}
