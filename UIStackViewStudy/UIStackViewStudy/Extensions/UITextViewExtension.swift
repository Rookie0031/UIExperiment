//
//  UITextViewExtension.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/19.
//

import UIKit

extension UITextView {
    static func makeBasicTextView(placeholder: String, textColor: UIColor, lineSpacing: Int) -> UITextView {
        let textView = UITextView()
        let style = NSMutableParagraphStyle()
        // 행간 세팅
        style.lineSpacing = CGFloat(lineSpacing)
        let attributedString = NSMutableAttributedString(string: placeholder)
        // 자간 세팅
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(0), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: placeholder.count) )
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14, weight: .bold), range: NSRange(location: 0, length: placeholder.count))
        textView.attributedText = attributedString
        
        textView.backgroundColor = .systemGray
        
        return textView
    }
}


