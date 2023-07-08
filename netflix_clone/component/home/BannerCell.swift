//
//  Banner.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/06.
//

import UIKit
import SnapKit

class BannerCell: UICollectionViewCell{
    static let cellId = "Banner"
    let imgView: UIImageView = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    func setImgSource( data: Data ){
        imgView.image = UIImage(data: data, scale: CGFloat(1.0))
        
    }
    func drawUI() {
        self.addSubview(imgView)
        imgView.contentMode = .scaleAspectFit
        imgView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
        
    }
   
}
