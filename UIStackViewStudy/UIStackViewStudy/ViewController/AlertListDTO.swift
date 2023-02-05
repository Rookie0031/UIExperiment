//
//  AlertListDataModel.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/02/05.
import Foundation

// MARK: - AlertData
struct AlertListDTO {
    let alertList: [AlertData]
}

// MARK: - AlertList
struct AlertData {
    let alertID: Int
    let isInvitation: Bool
    let alertType, title: NSNull
    let content: String
    let isChecked: Bool
    let updatedDate: String
    let bandID, eventID: Int
}
