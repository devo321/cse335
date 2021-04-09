//
//  GeneralUtilities.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/7/21.
//

import Foundation
import UIKit
import Firebase

class GeneralUtilities{
    
    static func randomString(length:Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let generatedString = String((0..<length).map{ _ in letters.randomElement()! })
        
        return generatedString
    }
    
    static func isUniqueName(name:String, classes:[UserClass]) -> Bool{
        if classes.count > 0 {
            for  userClass in classes{
                if userClass.className == name {
                    return false
                }
            }
        }
        return true //CHANGE LATER
    }
    
    
    static func buildMeetingString(meetingTime:Dictionary<String,String>) -> String? {
        if meetingTime["class_day"]!.isEmpty && meetingTime["class_time"]!.isEmpty {
            return nil
        }
        else if meetingTime["class_day"]!.isEmpty{
            return meetingTime["class_time"]!
        }
        else if meetingTime["class_time"]!.isEmpty{
            return meetingTime["class_day"]!
        }
        else{
            return meetingTime["class_day"]! + " at " + meetingTime["class_time"]!
        }
    }
}







extension UIImage {
    //MARK: - Resize Image with bounds
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
    
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInMb:Int) -> UIImage? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
            if data.count < sizeInBytes {
                needCompress = false
                imgData = data
            } else {
                compressingValue -= 0.1
            }
        }
    }

    if let data = imgData {
        if (data.count < sizeInBytes) {
            return UIImage(data: data)
        }
    }
        return nil
    }
}
