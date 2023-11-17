//
//  Helpers+TextField.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 17/11/23.
//

import UIKit

extension UITextField {
    func setBorderAndColor(with color: Colors = .primaryColor) {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: color.rawValue)?.cgColor
    }
    
    func setPlaceHolder(with color: Colors = .placeholder, textPlaceHolder: String) {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor(named: Colors.placeholder.rawValue)]
        self.attributedPlaceholder = NSAttributedString(string: textPlaceHolder, attributes: attributes as [NSAttributedString.Key : Any])
    }
    
    func addPadding(with size: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
