//
//  UITextViewExtension.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/19.
//

import UIKit

extension UITextView {
    static func makeBasicTextView(_ text: String, textColor: UIColor, lineSpacing: Int) -> UITextView {
        let textView = UITextView()
        let style = NSMutableParagraphStyle()
        // 행간 세팅
        style.lineSpacing = CGFloat(lineSpacing)
        let attributedString = NSMutableAttributedString(string: text)
        // 자간 세팅
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(0), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: text.count) )
        textView.attributedText = attributedString
        
        textView.backgroundColor = .systemGray
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.orange.cgColor
        
        return textView
    }
}


//private let introductionTextView = UITextView().then {
//    $0.setUITextViewAttributes("저는 송도에 거주하며 인천대에 재학중입니다. 송도와 영종도 부근을 많이 찍어봤고 주로 커플 스냅을 많이 찍습니다.편하게 연락주세요!종도 부근을 많이 찍어봤고 하며 인천대에 재학중입니다. 송도와", color: .black.withAlphaComponent(0.7), lineSpacing: 5)
//    $0.isScrollEnabled = false
//    $0.font = .preferredFont(forTextStyle: .headline, weight: .medium)
//    $0.isUserInteractionEnabled = false
//    $0.skeletonCornerRadius = 20
//}
