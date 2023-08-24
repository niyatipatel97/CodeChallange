//
//  Extension.swift
//  CodeChallange
//
//  Created by Niyati Patel on 21/08/23.
//

import Foundation
import UIKit



// MARK: - String Extension
extension String {
    /**
     This method is used to validate UserId field.
     - Returns: Return boolen value to indicate UserId is valid or not
     */
    func isValidUserID() -> Bool {
        let regEx = "^[0-9]{1,4}$"
        let userIdTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return userIdTest.evaluate(with: self)
    }
    
}

//MARK:- UIView extension
extension UIView {
    
    /**
     This methos is used to set corner radius to view (including width and color)
     */
    func setCornerRadius(withBorder borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.CustomColor.postCellBorder, cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
    }
    
    /**
    This methos is used to set shadow to view
    */
    func setShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
}


//MARK:- UITableView extension
extension UITableView {
    
    /**
     This method is used to make image of specific color.
     - Parameters:
     - nib: Name of nib file that need to register
     - identifier: Cell reuse identifer
     */
    func register(nib: String, with identifier: String = "") {
        let cellIdentifier = identifier.isEmpty ? nib : identifier
        self.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
}

//MARK: UIViewController
extension UIViewController {
    
    /**
     This methd is used to open Alert with two action buttons.
     */
    func showAlert(withTitle title: String = "", with message: String, firstButton: String = LocalizableKeys.Buttons.kOK, firstHandler: ((UIAlertAction) -> Void)? = nil, secondButton: String? = nil, secondHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: firstButton, style: .default, handler: firstHandler))
        if secondButton != nil {
            alert.addAction(UIAlertAction(title: secondButton!, style: .default, handler: secondHandler))
        }
        
        present(alert, animated: true)
    }
}
