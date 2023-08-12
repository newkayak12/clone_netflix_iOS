//
//  ContentsTableViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/10.
//

import UIKit

class ContentsTableViewCell: UITableViewCell {
    static let cellId = "Contents"
   
    lazy var preview = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.contentMode = .scaleAspectFit
        return img
    }()
    lazy var playButton = {
        let img = UIImageView(image: UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.tintColor = .white
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var previewContainer = {
        let view = UIView(frame: .zero)
        return view;
    }()
    
    lazy var titleLabel = {
        let label = UILabel(frame: .zero)
        label.text = "회차 이름"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    lazy var durationLabel = {
        let label = UILabel(frame: .zero)
        label.text = "-분"
        label.textColor = .gray
        
        return label
    }()
    
    lazy var verticalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.durationLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var horizontalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.previewContainer, self.verticalStackView])
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func drawUI(){
        previewContainer.addSubview(self.preview)
        previewContainer.addSubview(self.playButton)
        previewContainer.bringSubviewToFront(playButton)
        
        
        self.contentView.addSubview(self.horizontalStackView)
        
        self.preview.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self.previewContainer)
            make.width.equalTo(120)
        }
        
        self.playButton.snp.makeConstraints { make in
            make.width.height.equalTo(self.preview).multipliedBy(0.3)
            make.center.equalTo(self.preview)
        }
        
        self.horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self.contentView)
        }
    }
}
