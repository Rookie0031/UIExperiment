//
//  NetworkManagwr.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/19.
//
import Foundation

final class DuplicationCheckRequest {
    
    //MARK: Authorization 추가 후 header 추가해서 request 필요
    static func checkDuplication(checkCase: CheckDuplicationCase, word: String) async throws -> Bool {
        var result = false
        var baseURL = ""
        switch checkCase {
        case .userNickName: baseURL = "http://43.201.55.66:8080/member/validate"
        case .bandName: baseURL = "http://43.201.55.66:8080/band/validate"
        }
        
        var queryURLComponent = URLComponents(string: baseURL)
        let nameQuery = URLQueryItem(name: "name", value: word)
        queryURLComponent?.queryItems = [nameQuery]
        guard let url = queryURLComponent?.url else { throw NetworkError.badURL }
        
        do {
            let (_, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as! HTTPURLResponse
            
            if (200..<300).contains(httpResponse.statusCode) { result = true }
            print(httpResponse)
            
        } catch {
            print(error)
        }
        
        return result
    }
}

