//
//  NetworkManagwr.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/19.
//
import Foundation

final class NetworkManager {

    static let shared = NetworkManager()
    
    func checkBandNameDuplication(with word: String) async throws -> Bool {
        var result = false
        
        let baseURL = "http://43.201.55.66:8080/member/validate"
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
    
    //MARK: UI 작업 마무리 이후 다시 진행
    func checkUserNameDuplication() {
        
    }
}

