//
//  NetworkSession.swift
//  SpaceX
//
//  Created by Dan Mori on 07/08/23.
//

import Foundation

protocol HTTPClient {
    func request(request: URLRequest) async throws -> (Data, HTTPURLResponse)
}

extension URLSession: HTTPClient {
    struct InvalidHTTPResponseError: Error {}
    
    func request(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw InvalidHTTPResponseError()
        }        
        return (data, httpResponse)
    }

}
