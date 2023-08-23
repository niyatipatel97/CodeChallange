//
//  User.swift
//  CodeChallange
//
//  Created by Niyati Patel on 22/08/23.
//

import Foundation


let kuserId = "userId"
let kusername = "username"
//let karrFavPost = "arrFavPost"

class User: NSObject {
    
    var userId: Int
    var username: String
    
    // MARK: - init
    init(dictionary: [String:Any]) {
        
        self.userId = dictionary[kuserId] as? Int ?? 0
        self.username = dictionary[kusername] as? String ?? ""
    }
    
    
    
    /**
    This method is used to get login by UserId.
    - Parameter : userID
    - Returns: flag True or False.
    */
    class func LoginApi(withUserId userId: String, success withResponse: @escaping (_ user: User) -> (), failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        
        let requestURL = String(format: Constant.API.kUsers, userId)
        
        APIManager.makeRequest(with: requestURL, method: .get, parameter: nil, success: {(response) in
            SVProgressHUD.dismiss()
            
            if let arrDataDict = response as? [[String:Any]], let obj = arrDataDict.compactMap({ User(dictionary: $0) }).first {
                
                
                withResponse(obj)
            }
            else {
                failure(LocalizableKeys.NoDataLabelText.kNoUserFound, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure(error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure(connectionError, .connection)
        })
    }
}
