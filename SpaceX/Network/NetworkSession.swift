//
//  NetworkSession.swift
//  SpaceX
//
//  Created by Dan Mori on 07/08/23.
//

import Foundation
import Combine

protocol HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}

extension URLSession: HTTPClient {
    struct InvalidHTTPResponseError: Error {}
    
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        return dataTaskPublisher(for: request)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw InvalidHTTPResponseError()
                }
                return (result.data, httpResponse)
            })
            .eraseToAnyPublisher()
    }
}
