//
//  NetworkManagwr.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/19.
//
final class NetworkManager {

    static let shared = NetworkManager()
    
    func checkDuplication(with word: String) async throws -> Bool {
        //MARK: 백엔드 API 확인 후 서버 통신 로직을 추가할 계획임
        if word == "모여락" {
            return false
        } else {
            return true
        }
    }
}
