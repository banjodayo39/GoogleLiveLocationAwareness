//
//  String.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 11/10/22.
//

import UIKit

extension String {
    
    func image() -> UIImage? {
      //  let imageSize = CGSize(width: 40, height: 40)
        let nsString = (self as NSString)
        let font = UIFont.systemFont(ofSize: 40) // you can change your font size here
        let stringAttributes = [NSAttributedString.Key.font: font]
        let imageSize = nsString.size(withAttributes: stringAttributes)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0) //  begin image context
        UIColor.clear.set() // clear background
        UIRectFill(CGRect(origin: CGPoint(), size: imageSize)) // set rect size
        nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes) // draw text within rect
        let image = UIGraphicsGetImageFromCurrentImageContext() // create image from context
        UIGraphicsEndImageContext() //  end image context
        
        return image ?? UIImage()
    }
    
}
