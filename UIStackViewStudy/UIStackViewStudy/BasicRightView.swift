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

struct TwoHstackLabel {
    
    static var checkLabel: UIStackView = {
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "checkmark.circle")!
            imageView.tintColor = .systemBlue
            imageView.constraint(.widthAnchor, constant: 20)
            imageView.constraint(.heightAnchor, constant: 20)
            return imageView
        }()
        
        let label = UILabel.makeBasicLabel(labelText: "사용 가능해요", textColor: .systemBlue, fontStyle: .caption1, fontWeight: .regular)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    static func basicLabel(firstLabelText: String, firstTextColor: UIColor, firstFontStyle: UIFont.TextStyle, firstFontWeight: UIFont.Weight, secondLabelText: String, secondTextColor: UIColor, secondFontStyle: UIFont.TextStyle, secondFontWeight: UIFont.Weight) -> UIStackView {
        
        let firstLabel = UILabel.makeBasicLabel(labelText: firstLabelText, textColor: firstTextColor, fontStyle: firstFontStyle, fontWeight: firstFontWeight)
        // 두 레이블을 연속적으로 붙여놓기 위해서 앞쪽 레이블의 contentHuggingPriorty를 높게 설정해 추후 여유 공간이 생길 경우 firstLabel의 공간을 압축(hug) 시킴.
        firstLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        let secondLabel = UILabel.makeBasicLabel(labelText: secondLabelText, textColor: secondTextColor, fontStyle: secondFontStyle, fontWeight: secondFontWeight)
        
        let stackView = UIStackView(arrangedSubviews: [firstLabel, secondLabel])
        stackView.axis = .horizontal
        stackView.spacing = 2
        
        return stackView
    }
}
