//
//  ApiRequester.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation
import RxSwift

enum ApiRequesterError: LocalizedError {
    case noInternetConnection
    case failedToBuildRequest
    case unknown
    case requestFailed(String?)
    case invalidStatusCode(String?, Int)
    case failedToDecodeResponse
    case invalidUrl(String)
    case selfIsNil

    var localizedDescription: String {
        switch self {
        case .noInternetConnection:
            return "No internet connection"
        case .failedToBuildRequest:
            return "Failed to build request"
        case .unknown:
            return "Unknown error occured"
        case let .requestFailed(stringUrl):
            return "Request failed : \(stringUrl ?? "nil")"
        case let .invalidStatusCode(stringUrl, statusCode):
            return "Invalid status code (\(statusCode)) for request : \(stringUrl ?? "nil")"
        case .failedToDecodeResponse:
            return "Failed to decode response"
        case let .invalidUrl(stringUrl):
            return "Invalid url : \(stringUrl)"
        case .selfIsNil:
            return "Self value is nil"
        }
    }
}

public final class ApiRequester {
    
    // MARK: - Properties
    private let urlSession: URLSession
    private let reachability: Reachability?

    // MARK: - Lifecycle
    public init(urlSession: URLSession = .shared, reachability: Reachability? = try? Reachability()) {
        self.urlSession = urlSession
        self.reachability = reachability
    }

    // MARK: - Methods
    public func fetch<T: ApiEndpoint>(_ endpoint: T, with parameters: T.RequestDataType) -> Single<T.ResponseDataType> {
        if reachability?.connection == Reachability.Connection.unavailable {
            return Single.error(ApiRequesterError.noInternetConnection)
        }

        guard let urlRequest = try? endpoint.buildRequest(parameters: parameters).urlRequest else {
            return Single.error(ApiRequesterError.failedToBuildRequest)
        }

        return Single.create { [weak self] single in
            guard let self = self else {
                single(.error(ApiRequesterError.selfIsNil))
                return Disposables.create()
            }

            let task = self.urlSession.dataTask(with: urlRequest) { data, response, error in
                guard
                    let response = response,
                    let data = data
                else { return single(.error(error ?? ApiRequesterError.unknown)) }

                guard let urlResponse = response as? HTTPURLResponse else {
                    return single(.error(ApiRequesterError.requestFailed(urlRequest.url?.absoluteString)))
                }

                guard 200 ..< 300 ~= urlResponse.statusCode else {
                    return single(.error(ApiRequesterError.invalidStatusCode(urlRequest.url?.absoluteString,
                                                                             urlResponse.statusCode)))
                }

                guard let parsedResponse = try? endpoint.parseResponse(data: data) else {
                    return single(.error(ApiRequesterError.failedToDecodeResponse))
                }

                return single(.success(parsedResponse))
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
