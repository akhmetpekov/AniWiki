//
//  UILabel + ext.swift
//  AniWiki
//
//  Created by Erik on 29.05.2024.
//

import UIKit

extension UILabel {
    func labelChange(For givenText: String, color: UIColor, from locationNumber: Int, to length: Int) {
        let myMutableString = NSMutableAttributedString(string: givenText)
        
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: locationNumber, length: length))
        
        if let currentFont = self.font {
            myMutableString.addAttribute(NSAttributedString.Key.font, value: currentFont, range: NSRange(location: 0, length: givenText.count))
        }
        
        self.attributedText = myMutableString
    }
}

