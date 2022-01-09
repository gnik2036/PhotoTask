//
//  PhotoModel.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 08/01/2022.
//

import Foundation

struct PhotoModel: Codable {
    let id: String
    let author: String?
    let downloadUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case downloadUrl = "download_url"
    }
}
