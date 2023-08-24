//
//  ViewController.swift
//  CodeChallange
//
//  Created by Niyati Patel on 20/08/23.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtUserId: UITextField!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var vwContainer: UIView!
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.initialConfig()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.decorateUI()
    }
}



//MARK: UI Helpers
extension LoginVC {
    
    /**
     This method is used to make initial configurations to controls.
     */
    func initialConfig() {
        self.lblTitle.text = LocalizableKeys.Labels.kLogin
        self.lblUserId.text = LocalizableKeys.Labels.kUserID
        self.lblError.text = LocalizableKeys.Labels.kErrorUserId
        self.btnLogIn.setTitle(LocalizableKeys.Labels.kLogin, for: .normal)
        
        self.setDoneOnKeyboard()
    }
    
    /**
     This method is used to decorate UI controls.
     */
    private func decorateUI() {
        
        self.btnLogIn.backgroundColor = UIColor.CustomColor.appColor
        self.txtUserId.setCornerRadius(withBorder: 1.5, borderColor: UIColor.CustomColor.appColor, cornerRadius: UIHelperConstants.appButtonRadius)
        self.btnLogIn.setCornerRadius(cornerRadius: UIHelperConstants.appButtonRadius)
        self.vwContainer.setCornerRadius(withBorder: 1, borderColor: UIColor.lightText, cornerRadius: UIHelperConstants.appButtonRadius)
        self.vwContainer.setShadow()
    }
    
    /**
     This method is used to validate user input.
     - Returns: Return boolean value to indicate input data is valid or not.
     */
    func isValidUserInput(input: String?) -> Bool {
        
        
        if let userid = input, userid.isEmpty || !userid.isValidUserID() {
            return false
        }
        return true
    }
    
    /**
     This method is used to fetch User Id From the TextField.
     - Returns: Return String value of userid.
     */
    func fetchUserIdFromtheTextField() -> String? {
        
        
        return self.txtUserId.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func setDoneOnKeyboard() {
        
        //Tap anywhere on the screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //On top of the Keyboard Done button
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.txtUserId.inputAccessoryView = keyboardToolbar
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
       
        self.lblError.isHidden = self.isValidUserInput(input: self.fetchUserIdFromtheTextField())
    }

}



// MARK: - IBAction Mthonthd
fileprivate extension LoginVC
{
    
    @IBAction func btnSignin_Clicked(_ sender: Any) {
        self.view.endEditing(true)
        guard self.isValidUserInput(input: self.fetchUserIdFromtheTextField()) else {
            self.lblError.isHidden = false
            return
        }
        
        if let useridStr = self.txtUserId.text?.trimmingCharacters(in: .whitespacesAndNewlines), let userid = Int(useridStr) {
            self.LoginApiCall(userId: userid)
        }
    }
}



//MARK: API Call
extension LoginVC {
    
    /**
     Api call for Login using userid.
     */
    func LoginApiCall(userId: Int) {
        User.LoginApi(withUserId: userId) { user in
            
            self.lblError.isHidden = true
            UserDefaults.standard.set(user.userId, forKey: kuserId)
            appDelegate.SetupRootScreen()
        } failure: { error in
            if !error.isEmpty {
                self.showAlert(with: error)
            }
        }
    }
}


