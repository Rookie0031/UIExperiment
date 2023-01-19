//
//  UIFontExtension.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/18.
//

import UIKit

extension UIFont {

    static func preferredFont(forTextStyle: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: forTextStyle)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: forTextStyle)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
