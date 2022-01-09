//
//  PhotoCellViewModel.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 09/01/2022.

import Foundation

import Foundation

protocol PhotoCellViewModelInputs {
}

protocol PhotoCellViewModelOutputs {
    var authorName: String { get }
    var photoUrl: String { get }
}

protocol PhotoCellViewModelProtocol: AnyObject {
    var inputs: PhotoCellViewModelInputs { get }
    var outputs: PhotoCellViewModelOutputs { get set }
}

class PhotoCellViewModel: PhotoCellViewModelInputs, PhotoCellViewModelOutputs, PhotoCellViewModelProtocol {
    
    var inputs: PhotoCellViewModelInputs { self }
    var outputs: PhotoCellViewModelOutputs {
        get { self }
        set { }
    }
    
    private let photo: PhotoModel
    
    init(photo: PhotoModel) {
        self.photo = photo
    }
    
    var authorName: String { photo.author ?? "" }
    var photoUrl: String { photo.downloadUrl ?? "" }
    
}
