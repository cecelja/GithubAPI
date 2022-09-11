//
//  UILabel+Factory.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/11/22.
//

import Foundation
import UIKit

extension UILabel {
    static func with(text: String, color: UIColor, size: CGFloat, fontStyle: String) -> UILabel {
        let label = UILabel()
        var font = UIFont()
        label.text = text
        label.textColor = color
        label.contentMode = .scaleAspectFit
        
        switch fontStyle {
        case "bold":
            font = UIFont.boldSystemFont(ofSize: size)
        case "italic":
            font = UIFont.italicSystemFont(ofSize: size)
        default:
            font = UIFont.systemFont(ofSize: size)
        }
        label.font = font
        
        return label
    }
}
