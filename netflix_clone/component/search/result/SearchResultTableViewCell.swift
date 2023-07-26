//
//  SearchResultTableViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/25.
//

import Foundation
import UIKit
import RxSwift

class SearchResultTableViewCell: UITableViewCell {
    static let cellId = "searchResult"
    lazy var imgView: UIImageView = {
       let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.snp.makeConstraints { make in
            make.width.height.equalTo(self.contentView.frame.height)
        }
        
        return img
    }()
    lazy var title = {
        let label = UILabel(frame: .zero)
        label.text = "title"
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo((self.contentView.frame.height - 10) / 2)
        }
        
        return label;
    }()
    lazy var subTitle = {
        let label = UILabel(frame: .zero)
        label.text = "subtitle"
        label.textColor = .gray
        label.snp.makeConstraints { make in
            make.height.equalTo((self.contentView.frame.height - 10) / 2)
        }
        return label;
    }()
    lazy var verticalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.title, self.subTitle] );
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    lazy var horizontalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.imgView, self.verticalStackView] );
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.title.text = ""
        self.subTitle.text = ""
        imgView.image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large))
    }
    
    
    func drawUI() {
        self.contentView.addSubview(horizontalStackView)
        
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.contentView)
            make.leading.equalTo(self.contentView).offset(20)
            make.trailing.equalTo(self.contentView).offset(-20)
        }
    }
    
}
