//
//  PostCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/09.
//

import Foundation
import UIKit
class PosterCell: UICollectionViewCell {
    var type: PosterTypeId?
    
    let imgView: UIImageView = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
    let infoView: UIView = {
       let view = UIView(frame: .zero)
       let img = UIImageView(image: UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        
        img.contentMode = .scaleAspectFit
        view.addSubview(img)
        img.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.width.height.equalTo(20)
        }
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawUI()
    }
    
    func drawUI() {
        self.addSubview(imgView)
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .white
        imgView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
    
    func drawInfoLine() {
        self.addSubview(infoView)
        self.bringSubviewToFront(infoView)
        
        infoView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self).offset(-15)
            make.height.equalTo(30)
        }
        infoView.backgroundColor = .systemGray
    }
}

enum PosterTypeId: String {
    case WATCHED = "WATCHED"
    case EPISODE = "EPISODE"
}
