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
        let transformer = SDImageResizingTransformer(size: CGSize(width: 500, height: 500), scaleMode: .aspectFill)

        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "place_holder"), options: [.lowPriority,.scaleDownLargeImages], context: [.imageTransformer: transformer])
    }
}
extension UIImageView {
    var mostDominantColor: UIColor? {
        guard let myImage = self.image else {return nil }
        guard let inputImage = CIImage(image: myImage) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    func makeDominantColor()
    {
        self.backgroundColor = mostDominantColor
    }
}
