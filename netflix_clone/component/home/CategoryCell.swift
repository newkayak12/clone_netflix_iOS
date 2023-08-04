//
//  CategoryCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/09.
//
import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let cellId = "Category"
    let imgView: UIImageView = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
    lazy var categoryLabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.text = "CATEGORY"
        label.font = UIFont(name: "", size: CGFloat(16))
        return label
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    func drawUI() {
        imgView.image = UIImage(named: "Patterns\(Int.random(in: 1 ... 9))")
        self.addSubview(categoryLabel)
        self.addSubview(imgView)
        self.bringSubviewToFront(categoryLabel)
        categoryLabel.backgroundColor = .systemGray2
        imgView.contentMode = .scaleAspectFill
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(30)
            make.leading.equalTo(self).offset(5)
        }
        imgView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
        
    }
}
