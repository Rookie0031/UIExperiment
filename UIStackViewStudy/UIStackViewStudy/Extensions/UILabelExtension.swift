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
