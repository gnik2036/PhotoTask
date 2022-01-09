//
//  PhotoDetailsViewModel.swift
//  iOS Assessment
//
//  Created by Ghalaab on 09/10/2021.
//

import Foundation

protocol ItemDetailsViewModelProtocol: PhotoCellViewModelProtocol {
    var profileUrl: String { get }
}

class ItemDetailsViewModel: ItemDetailsViewModelProtocol {
    
    
    private let photo: PhotoModel
    
    init(photo: PhotoModel) {
        self.photo = photo
    }
    
    var authorName: String { photo.author ?? "" }
    var photoUrl: String { photo.downloadUrl ?? "" }
    var profileUrl: String { photo.url ?? "" }

}
