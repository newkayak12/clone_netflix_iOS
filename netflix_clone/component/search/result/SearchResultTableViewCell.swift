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
    let imgView: UIImageView = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
    lazy var title = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .white
        
        return label;
    }()
    lazy var subTitle = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .gray
        
        return label;
    }()
    lazy var verticalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.title, self.subTitle] );
        stackView.axis = .vertical
        return stackView
    }()
    lazy var horizontalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.imgView, self.verticalStackView] );
        stackView.axis = .horizontal
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
            make.leading.top.trailing.bottom.equalTo(self.contentView)
        }
    }
    
}
