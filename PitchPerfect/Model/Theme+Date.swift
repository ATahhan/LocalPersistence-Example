//
//  Theme.swift
//  PitchPerfect
//
//  Created by Ammar AlTahhan on 27/12/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation
import UIKit

enum ThemeStyle: String {
    case light, dark
}

extension UIViewController {
    
    // TODO : - Create a themeStyle computed variable to return the current saved value in UserDefaults
    
    func setTheme(_ themeStyle: ThemeStyle) {
        if themeStyle == .dark {
            view.backgroundColor = .darkGray
            for subview in view.subviews {
                if subview is UILabel {
                    (subview as! UILabel).textColor = .white
                }
            }
            
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = UIColor(white: 0.15, alpha: 1)
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            navigationController?.navigationBar.barStyle = .black

        } else if themeStyle == .light {
            view.backgroundColor = .white
            for subview in view.subviews {
                if subview is UILabel {
                    (subview as! UILabel).textColor = .black
                }
            }
            
            navigationController?.navigationBar.tintColor = nil
            navigationController?.navigationBar.barTintColor = nil
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.titleTextAttributes = nil
            navigationController?.navigationBar.barStyle = .default
        }
    }
}

extension Date {
    var asName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy_HH:mm:ss"
        return formatter.string(from: self)
    }
}


extension UIImage {
    static var darkIcon: UIImage {
        return #imageLiteral(resourceName: "sun").resizeImage(targetSize: CGSize(width: 23, height: 23))
    }
    static var lightIcon: UIImage {
        return #imageLiteral(resourceName: "night").resizeImage(targetSize: CGSize(width: 23, height: 23))
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
