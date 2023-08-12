//
//  personCollectionVIewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/06.
//

import UIKit
import SnapKit

class PersonCollectionViewCell: UICollectionViewCell {
    static let cellId = "PersonId"
    
    lazy var imageView = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.layer.cornerRadius = 100
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
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
        stackView.distribution = .fillEqually
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
        Log.debug("INIT COLLECTION")
        super.init(frame: frame)
        drawUI()
    }
    
    func drawUI() {
        self.contentView.addSubview(self.horizontalStackView)
        self.imageView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        self.horizontalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.contentView)
        }
    }
}
