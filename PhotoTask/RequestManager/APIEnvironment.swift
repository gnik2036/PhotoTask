//
//  APIEnvironment.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 08/01/2022.
//

//https://picsum.photos/v2/list?page=1&limit=10


import Foundation
enum APIEnvironment {
    case development
    case staging
    case production
    
    func baseURL () -> String {
        return "https://picsum.photos/v2/list"
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return ""
        case .staging:
            return ""
        case .production:
            return ""
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development, .production, .staging:
            return ""
        }
    }
    

}
