//
//  Constants.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/2/21.
//

import Foundation
import UIKit

struct Constants{
    
    struct Storyboard{
        
        static let homeViewController = "HomeView"
    }
}
extension UIImage {
    func resizeImageWithBounds(bounds: CGSize) -> UIImage {
        let horizontalRatio = bounds.width/size.width
        let verticalRatio = bounds.height/size.height
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


