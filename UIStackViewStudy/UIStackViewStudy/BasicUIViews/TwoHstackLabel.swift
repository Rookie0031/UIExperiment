//
//  CheckSameUIView.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/19.
//

import UIKit

// 2개의 컴포넌트가 수평으로 붙어있는 케이스를 모아놓는 구조체
struct TwoHstackLabel {
    
    // 텍스트 필드 내 텍스트를 중복 확인 검사하는 경우 하단에 표기되는 레이블
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
    
    // 합주곡(선택) 처럼 폰트가 다른 2개의 레이블이 붙어있는 경우
    
    static func basicClassLabel(firstLabelText: String, inputType: InputType) -> UIStackView {
        let firstLabel = BasicLabel(contentText: firstLabelText, fontStyle: .headline01, textColorInfo: .white)
        let secondLabel = BasicLabel(contentText: inputType.rawValue, fontStyle: .content, textColorInfo: .gray02)
        firstLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        let stackView = UIStackView(arrangedSubviews: [firstLabel, secondLabel])
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        return stackView
    }
    
    static func basicLabel(firstLabelText: String, firstTextColor: UIColor, firstFontStyle: UIFont.TextStyle, firstFontWeight: UIFont.Weight, secondLabelText: String, secondTextColor: UIColor, secondFontStyle: UIFont.TextStyle, secondFontWeight: UIFont.Weight) -> UIStackView {
        
        let firstLabel = UILabel.makeBasicLabel(labelText: firstLabelText, textColor: firstTextColor, fontStyle: firstFontStyle, fontWeight: firstFontWeight)
        
//        let firstLabel = BasicLabel(contentText: firstLabelText, fontStyle: .subTitle, textColorInfo: .white)
        
        // UIStack에 넣는 경우, Stack 내부에 가장 큰 intrinsic Size를 가진 하위뷰의 크기에 맞게 subView들을 stretch 시킨다. 이 경우, 두 레이블을 연속적으로 붙여놓기 위해서 앞쪽 레이블의 contentHuggingPriorty를 높게 설정해 추후 여유 공간이 생길 경우 firstLabel의 공간을 압축(hug) 시키기 위함.
        firstLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        let secondLabel = UILabel.makeBasicLabel(labelText: secondLabelText, textColor: secondTextColor, fontStyle: secondFontStyle, fontWeight: secondFontWeight)
//        let secondLabel = BasicLabel(contentText: secondLabelText, fontStyle: .caption, textColorInfo: .white)
        
        let stackView = UIStackView(arrangedSubviews: [firstLabel, secondLabel])
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        return stackView
    }
}

enum InputType: String {
    case optional = "(선택)"
    case required = "(필수)"
}
