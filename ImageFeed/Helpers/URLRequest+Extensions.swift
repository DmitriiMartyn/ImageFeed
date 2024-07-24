//
//  URLRequest+Extensions.swift
//  ImageFeed
//
//  Created by Дмитрий Мартынцов on 07.07.2024.
//
import Foundation

extension URLRequest {
    
    static func makeHTTPRequest(
        path: String,
        httpMethod: String,
        queryItems: [URLQueryItem]? = nil,
        baseURL: String
    ) -> URLRequest? {
        
        guard
            let url = URL(string: String(describing: baseURL)),
            var baseUrl = URL(string: path, relativeTo: url)
        else { return nil }
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = httpMethod
        
        if let token = OAuth2TokenStorage.shared.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
