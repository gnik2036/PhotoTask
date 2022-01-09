//
//  PhotosDelegate.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 09/01/2022.

import UIKit

class PhotosDelegate: NSObject, UITableViewDelegate{
    
    let viewModel: PhotosViewModelProtocol
    
    init(viewModel: PhotosViewModelProtocol) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.inputs.fetchMorePhotosIfAvailable(at: indexPath.row)
    }
}
