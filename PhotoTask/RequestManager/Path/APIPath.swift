//
//  APIPath.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 08/01/2022.
//

import Foundation


#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.production
#endif

let baseURL = environment.baseURL()

struct APIPath {
    var picsumPhotos: String { return "\(baseURL)"}

}


