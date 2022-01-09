//
//  PhotoTableViewCell.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 09/01/2022.

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
        
    // MARK: - Overrided methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Configuration methods
    
    func configure(with viewModel: PhotoCellViewModelProtocol){
        self.authorNameLabel.text = viewModel.outputs.authorName
        self.photoImageView.downloadUsingURL(url: viewModel.outputs.photoUrl)
    }
}
