//
//  passwordInput.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/15.
//

import Foundation

import Foundation
import UIKit
import RxSwift
import SnapKit
import RxCocoa


final class PasswordInput: UIView {
    public var validText: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    public var isSecureRaw = true
    public var isSecure: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: true)
    
    
    private lazy var title = {
        let label = UILabel()
        label.text = "비밀번호를 입력해주세요"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.height.equalTo(26)
        }
        return label;
    }()
    private lazy var xButton = {
        let button = UIButton()
        let xImage = UIImage(systemName: "eye")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(xImage, for: .normal)
        button.addTarget(self, action: #selector(self.clear), for: .touchUpInside)
        return button
    }()
    private lazy var input = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.textColor = .white
        field.backgroundColor = .black
        field.tintColor = .white
        field.placeholder = "비밀번호를 입력해주세요."
        field.rightViewMode = .always
        field.rightView = self.xButton
        field.font = UIFont.systemFont(ofSize: 20)
        
        self.isSecure
            .withUnretained(self)
            .bind { this, value in
                field.isSecureTextEntry = value
                switch value {
                    case true:
                        let xImage = UIImage(systemName: "eye")?.withTintColor(.white, renderingMode: .alwaysOriginal)
                        this.xButton.setImage(xImage, for: .normal)
                        this.isSecureRaw = value
                    case false:
                        let xImage = UIImage(systemName: "eye.slash")?.withTintColor(.white, renderingMode: .alwaysOriginal)
                        this.xButton.setImage(xImage, for: .normal)
                        this.isSecureRaw = value
                }
            }
            .disposed(by: rx.disposeBag)
        
        field.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return field
    }()
    private lazy var validation = {
        let label = UILabel();
        self.validText.bind(to: label.rx.text).disposed(by: rx.disposeBag)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .red
        label.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        return label
    }()
    
    
    private lazy var container = {
        let stackView = UIStackView(arrangedSubviews: [self.title, self.input, self.validation])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawUI()
        
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
    
    func invalid( text: String ){
        validText.onNext(text)
    }
    
    func addInputEvent() -> ControlProperty<String?> {
        return self.input.rx.text
    }
    
    @objc
    func clear () {
        self.isSecureRaw = !self.isSecureRaw
        self.isSecure.onNext(self.isSecureRaw)
    }
}
