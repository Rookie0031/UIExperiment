//
//  UILabelExtension.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/18.
//

import UIKit

extension UILabel {
    static func makeBasicLabel(labelText: String, textColor: UIColor ,fontStyle: UIFont.TextStyle, fontWeight: UIFont.Weight, numberOfLines: Int? = nil) -> UILabel {
        lazy var label: UILabel = {
            let label = UILabel()
            label.text = labelText
            label.textColor = textColor
            label.font = .preferredFont(forTextStyle: fontStyle, weight: fontWeight)
            
            if let number = numberOfLines {
                label.numberOfLines = number
            }
            return label
        }()
        return label
    }
}

class BasicLabel: UILabel {
    
    private let contentText: String
    private let fontStyle: UIFont.TextStyle
    private let textColorInfo: UIColor
    
    init(contentText: String, fontStyle: UIFont.TextStyle, textColorInfo: UIColor) {
        self.contentText = contentText
        self.fontStyle = fontStyle
        self.textColorInfo = textColorInfo
        super.init(frame: .zero)
        
        self.text = contentText
//        self.font = UIFont.setFont(fontStyle)
        self.textColor = textColorInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

