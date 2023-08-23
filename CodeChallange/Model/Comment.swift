//
//  Comment.swift
//  CodeChallange
//
//  Created by Niyati Patel on 22/08/23.
//

import Foundation


let kcommentId = "commentId"
let kcomment = "comment"
let kuser = "user"

class Comment: NSObject {
    
    var commentId: Int
    var comment: String
    var user: User
    
    // MARK: - init
    init(dictionary: [String:Any]) {
        
        self.commentId = dictionary[kcommentId] as? Int ?? 0
        self.comment = dictionary[kcomment] as? String ?? ""
        self.user = User(dictionary: dictionary[kuser] as? [String:Any] ?? [:])
    }
    
    
    
    /**
    This method is used to get comments on given Post.
    - Parameter : postId
    - Returns: array of Comment Model.
    */
    class func GetCommentsListOnPost(withPostId postid: Int, success withResponse: @escaping (_ comments: [Comment]) -> (), failure: @escaping FailureBlock) {
        SVProgressHUD.show()
            
        let requestURL = String(format: Constant.API.kComments, postid)
        
        APIManager.makeRequest(with: requestURL, method: .get, parameter: nil, success: {(response) in
            SVProgressHUD.dismiss()
            
            if let arrDataDict = response as? [[String:Any]] {
                
                let arr = arrDataDict.compactMap({ Comment(dictionary: $0) })
                withResponse(arr)
            }
            else {
                failure(LocalizableKeys.NoDataLabelText.kNoCommentsFound, .response)
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
