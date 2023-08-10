//
//  reviewTableViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/06.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    static let cellId = "Review"
    
    lazy var profileView = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.layer.cornerRadius = 50
        img.clipsToBounds = true
        
        return img
    }()
    
    lazy var nicknameView = {
        let nick = UILabel(frame: .zero)
        nick.text = "NICK"
        nick.textColor = .white
        
        nick.font = UIFont.boldSystemFont(ofSize: 20)
        return nick
    }()
    
    
    private lazy var empty: UIImage? = {
        let image = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
        return image
    }()
    
    private lazy var filled: UIImage? = {
        return UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
    }()
    
    private lazy var half: UIImage? = {
        return  UIImage(systemName: "star.leadinghalf.filled", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
    }()
    
    private lazy var first = {
        var first = UIImageView()
        first.image = self.empty
        first.tintColor = .yellow
        return first
    }()
    
    private lazy var second = {
        var second = UIImageView()
        second.image = self.empty
        second.tintColor = .yellow
        return second
    }()
    
    private lazy var third = {
        var third = UIImageView()
        third.image = self.empty
        third.tintColor = .yellow
        return third
    }()
    
    private lazy var fourth = {
        var fourth = UIImageView()
        fourth.image = self.empty
        fourth.tintColor = .yellow
        return fourth
    }()
    
    private lazy var fifth = {
        var fifth = UIImageView()
        fifth.image = self.empty
        fifth.tintColor = .yellow
        return fifth
    }()
    
    
    lazy var starView = {
        let starContainer = UIStackView(arrangedSubviews: [self.first, self.second, self.third, self.fourth, self.fifth])
        starContainer.distribution = .fillEqually
        return starContainer
    }()
    
    lazy var comment = {
        let label = UILabel(frame: .zero)
        label.text = "COMMNET \n comment"
        label.textColor = .gray
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var nickStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nicknameView, self.starView])
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    lazy var verticalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nickStackView, self.comment])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var horizontalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.profileView, self.verticalStackView])
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
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
    
    func drawUI () {
        self.addSubview(self.horizontalStackView)
        self.profileView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        
        self.comment.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        self.first.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        self.second.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        self.third.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        self.fourth.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        self.fifth.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        self.horizontalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
}
