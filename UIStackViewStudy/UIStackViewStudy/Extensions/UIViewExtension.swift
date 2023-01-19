//
//  UIViewExtension.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/19.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
      for view in views {
        self.addSubview(view)
      }
    }
}
