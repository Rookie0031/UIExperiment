//
//  DataModel.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/27.
//

import Foundation

struct Position: Hashable {
    let id = UUID()
    let instrumentName: String
    let instrumentImageName: InstrumentImageName
    let isETC: Bool
}


import Foundation

struct BandMember: Hashable {
    let id = UUID()
    let isUser: Bool
    let isLeader: Bool
    let userName: String
    let instrumentImageName: InstrumentImageName
    let instrumentNames: [String]
}
enum InstrumentImageName: String {
    case guitar
    case bass
    case drum
    case vocal
    case etc
}
