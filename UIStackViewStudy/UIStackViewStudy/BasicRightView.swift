//
//  CheckSameUIView.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/19.
//

import UIKit

class BasicRightView: UIView {
    
    let testButton = DuplicationCheckButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        constraint(.widthAnchor, constant: 100)
        constraint(.heightAnchor, constant: 50)
        
        addSubview(testButton)
        
        testButton.constraint(trailing: self.trailingAnchor, centerY: self.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 7))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DuplicationCheckButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setTitle("중복 확인", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return CGSize(width: baseSize.width + 20,//ex: padding 20
                          height: baseSize.height + 10)
        }
    }
}

class EmptyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        constraint(.widthAnchor, constant: 20)
        constraint(.heightAnchor, constant: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CheckDuplicationLabel {
    
    init(isChecked: Bool) {
        self.isChecked = isChecked
    }
    
    let isChecked: Bool
    
    lazy var text: UIStackView = {
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = isChecked ? UIImage(systemName: "checkmark.circle")! : UIImage(systemName: "x.circle")!
            imageView.tintColor = isChecked ? .systemBlue : .systemRed
            imageView.constraint(.widthAnchor, constant: 20)
            imageView.constraint(.heightAnchor, constant: 20)
            return imageView
        }()
        
        let label = isChecked ? UILabel.makeBasicLabel(labelText: "사용 가능해요", textColor: .systemBlue, fontStyle: .caption1, fontWeight: .regular) : UILabel.makeBasicLabel(labelText: "이미 사용하고 있어요", textColor: .systemRed, fontStyle: .caption1, fontWeight: .regular)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
}
