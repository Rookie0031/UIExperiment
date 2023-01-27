//
//  NSObject+Extension.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/27.
//

import Foundation

extension NSObject {
    static var classIdentifier: String {
        return String(describing: self)
    }
}
