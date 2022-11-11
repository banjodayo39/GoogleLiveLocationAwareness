//
//  UIView+Properties.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 10/29/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
}
