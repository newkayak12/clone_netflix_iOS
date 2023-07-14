//
//  IdInput.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/14.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import RxCocoa


final class IdInput: UIView {
   public lazy var value: String = ""
    
    
   private lazy var title = {
        let label = UILabel()
        label.text = "아이디를 입력해주세요"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label;
    }()
   private lazy var xButton = {
       let button = UIButton()
       let xImage = UIImage(systemName: "x.circle.fill")
        xImage?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        button.setImage(xImage, for: .normal)
        button.addTarget(self, action: #selector(self.clear), for: .touchUpInside)
        return button
    }()
   private lazy var input = {
       let field = UITextField()
       field.borderStyle = .roundedRect
       field.addSubview(self.xButton)
       self.xButton.snp.makeConstraints { make in
           make.centerY.equalTo(field)
           make.trailing.equalTo(field).offset(-20)
       }
       
        return field
    }()
   private lazy var container = {
        let stackView = UIStackView(arrangedSubviews: [self.title, self.input])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addInputEvent()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    
    func drawUI () {
        self.addSubview(self.container)
        self.container.snp.makeConstraints { make in
            make.width.height.leading.top.trailing.bottom.equalTo(self)
        }
    }
    
    func addInputEvent() {
        self.input.rx.text
            .withUnretained(self)
            .bind{
                if let text = $1 {
                    $0.value = text
                }
            }.disposed(by: rx.disposeBag)
    }
    
    @objc
    func clear () {
        self.value = ""
    }
}
