//
//  PhotosAPI.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 08/01/2022.
//

import Foundation

struct PhotosAPI: APIHandler {
    
    
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString =  APIPath().picsumPhotos
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> PhotoModel {
        return try defaultParseResponse(data: data,response: response)
    }
}
