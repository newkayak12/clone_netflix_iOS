//
//  SearchPosterCollectionViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/25.
//

import UIKit
import RxSwift

class SearchPosterCollectionViewCell: UICollectionViewCell {
    static let cellId = "SearchPosterCell"
    lazy var  imgView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.layer.cornerRadius = 20.0
        
        return img
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    override func prepareForReuse() {
        imgView.image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large))
    }
    
    
    func drawUI() {
        self.contentView.addSubview(imgView)
        
        self.imgView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self.contentView)
        }
    }
}
