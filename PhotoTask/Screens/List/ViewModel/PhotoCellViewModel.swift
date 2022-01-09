//
//  PhotoCellViewModel.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation

protocol PhotoCellViewModelProtocol: AnyObject {
    var authorName: String { get }
    var photoUrl: String { get }
}

class PhotoCellViewModel: PhotoCellViewModelProtocol {
    
    private let photo: PhotoModel
    
    init(photo: PhotoModel) {
        self.photo = photo
    }
    
    var authorName: String { photo.author ?? "" }
    var photoUrl: String { photo.downloadUrl ?? "" }
}

