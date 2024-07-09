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
        baseURL: URL = defaultBaseURL!
            ) -> URLRequest? {
                guard let url = URL(string: path, relativeTo: baseURL) else {
                    return nil
                }
                var request = URLRequest(url: url)
        request.httpMethod = httpMethod
                return request
            }
        }
