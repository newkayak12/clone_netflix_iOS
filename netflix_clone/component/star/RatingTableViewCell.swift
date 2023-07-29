//
//  RatingTableViewCell.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/29.
//

import Foundation
import UIKit
import SnapKit

class RatingTableView: UITableViewCell {
    static let cellId = "RatingCell"
    
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

    let rate: Double = 0.0
    lazy var imgView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.contentMode = .scaleAspectFit
        return img
    }()
    lazy var title = {
        let label = UILabel(frame: .zero)
        label.text = "title"
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(self.contentView).multipliedBy(0.3)
        }
        return label;
    }()
    lazy var subTitle = {
        var label = UILabel(frame: .zero)
        label.text = "subTitle"
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(self.contentView).multipliedBy(0.2)
        }
        return label
    }()
    private lazy var starBox = {
        let array = self.calculateStar()
        let btnArray = array.map  {
            let btn = UIButton(frame: .zero)
           
            if $0 >= 1.0 {
                btn.setImage(self.filled, for: .normal)
            } else if $0 >= 0, $0 <= 0.5 {
                btn.setImage(self.half, for: .normal)
            } else {
                btn.setImage(self.empty, for: .normal)
            }
            
            btn.imageView?.tintColor = .yellow
            return btn
        }
        
        let container = UIStackView(arrangedSubviews: btnArray)
        container.axis = .horizontal
        container.snp.makeConstraints { make in
            make.height.equalTo(self.contentView).multipliedBy(0.5)
        }
        
        return container
    }()
    private lazy var verticalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.title, self.subTitle, self.starBox] );
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var horizontalStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.imgView, self.verticalStackView] );
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    
    private func calculateStar () -> [Double] {
        var array = Array([0.0, 0.0, 0.0, 0.0, 0.0])
        var score = rate;
        var count = 0;
        while score <= 0 {
            switch score {
                case ...0.0:
                    break;
                case 0.0...0.5 :
                    score -= 0.5
                    array[count] = 0.5
                    break;
                default:
                    score -= 1.0
                    array[count] = 1.0
                    break;
            }
            count += 1
        }
        
        return array
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawUI() {
        
    }
        
        
}
