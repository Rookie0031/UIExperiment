//
//  MemberDataDTO.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/02/16.
//
import Foundation

struct MemberDataDTO: Identifiable, Codable {
    var id: String = UUID().uuidString
    let memberList: [MemberList]
}

struct MemberList: Codable {
    let memberId: Int
    let name, memberState: String
    let instrumentList: [InstrumentList]
}

struct InstrumentList: Codable {
    let instrumentId: Int
    let isMain: Bool
    let name: String
}

enum MemberState {

}

#if DEBUG
extension MemberDataDTO {
    static var testDataSet = [
        MemberDataDTO(memberList: [
            MemberList(memberId: 0,
                       name: "루키",
                       memberState: "NONE",
                       instrumentList: [InstrumentList(instrumentId: 0, isMain: true, name: "drum"), InstrumentList(instrumentId: 0, isMain: false, name: "guitar")]),
            MemberList(memberId: 0,
                       name: "구엘",
                       memberState: "NONE",
                       instrumentList: [InstrumentList(instrumentId: 0, isMain: true, name: "bass")]),
            MemberList(memberId: 0,
                       name: "노엘",
                       memberState: "NONE",
                       instrumentList: [InstrumentList(instrumentId: 0, isMain: true, name: "vocal")]),
            MemberList(memberId: 0,
                       name: "알로라",
                       memberState: "MEMBER",
                       instrumentList: [InstrumentList(instrumentId: 0, isMain: true, name: "bass"), InstrumentList(instrumentId: 0, isMain: false, name: "drum")]),
            MemberList(memberId: 0,
                       name: "데이크",
                       memberState: "MEMBER",
                       instrumentList: [InstrumentList(instrumentId: 0, isMain: true, name: "bass")]),
            MemberList(memberId: 0,
                       name: "쏘시지불나방전기뱀장어",
                       memberState: "NONE",
                       instrumentList: [InstrumentList(instrumentId: 0, isMain: true, name: "vocal")]),])
    ]
}
#endif

//extension CellInformation {
//    static var data = [
//        CellInformation(nickName: "구엘", instrument: "드럼"),
//        CellInformation(nickName: "루키", instrument: "베이스"),
//        CellInformation(nickName: "노엘", instrument: "기타"),
//        CellInformation(nickName: "데이크", instrument: "보컬"),
//        CellInformation(nickName: "알로라", instrument: "신디사이저"),
//        CellInformation(nickName: "가즈윌", instrument: "바이올린"),
//        CellInformation(nickName: "쏘시지불나방전기뱀장어", instrument: "바이올린")
//    ]
//}

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

