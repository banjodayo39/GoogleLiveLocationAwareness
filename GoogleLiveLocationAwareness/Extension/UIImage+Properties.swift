//
//  UIImage+Properties.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 11/7/22.
//

import UIKit

extension UIImage {
    
    func imageWith(newSize: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return image.withRenderingMode(renderingMode)
    }
        
}
