//
//  NetworkError.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/19.
//
import UIKit

enum NetworkError: Error, LocalizedError {
    case badURL
    case badResponse
    case failedRequest(status: Int)
    case badJSON(error: Error)
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case.badURL:
            return "Something related to URL has a problem."
        case .badResponse:
            return "The server returned an unrecognized response."
        case .failedRequest(let status):
            return "The request failed with status code: \(status)"
        case .badJSON(let error):
            return "An error occurred while decoding JSON: \(error)"
        case .unknown:
            return "Unknwon error occured"
        }
    }
}
