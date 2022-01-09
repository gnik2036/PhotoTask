//
//  ResponseHandler+Extension.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 08/01/2022.
//

import Foundation
// MARK: Response Handler - parse default

struct ServiceError: Error,Codable {
    let httpStatus: Int
    let message: String
}

extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch  {
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
        
    }
}


