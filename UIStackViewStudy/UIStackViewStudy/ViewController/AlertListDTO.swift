// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let alertData = try? JSONDecoder().decode(AlertData.self, from: jsonData)

import Foundation

// MARK: - AlertData
struct AlertListDTO: Codable {
    let alertList: [AlertList]
}

// MARK: - AlertList
struct AlertList: Codable {
    let alertID: Int
    let isInvitation: Bool
    let alertType, title: JSONNull?
    let content: String
    let isChecked: Bool
    let updatedDate: String
    let bandID, eventID: Int

    enum CodingKeys: String, CodingKey {
        case alertID = "alertId"
        case isInvitation, alertType, title, content, isChecked, updatedDate
        case bandID = "bandId"
        case eventID = "eventId"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
// CI CD
