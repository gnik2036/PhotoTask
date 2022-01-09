//
//  UIImage+MostDominantColor.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 09/01/2022.
//

import UIKit
import SDWebImage

extension UIImageView {
    func downloadUsingURL (url :String)
    {
        let transformer = SDImageResizingTransformer(size: CGSize(width: 250, height: 250), scaleMode: .aspectFit)

        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "place_holder"), options: [.lowPriority,.scaleDownLargeImages], context: [.imageTransformer: transformer])
    }
}
