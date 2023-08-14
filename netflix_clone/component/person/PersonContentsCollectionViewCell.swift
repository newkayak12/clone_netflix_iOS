//
//  PersonCollectionViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/14.
//

import UIKit
import SnapKit

class PersonContentsCollectionViewCell: UICollectionViewCell {
    static var cellId = "PersonContents"
    
    lazy var posterView = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.layer.cornerRadius = 50
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        return img
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
        self.contentView.addSubview(self.posterView)
        self.posterView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self.contentView)
        }
    }
    
}
