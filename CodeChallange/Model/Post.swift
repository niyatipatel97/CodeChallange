//
//  Post.swift
//  CodeChallange
//
//  Created by Niyati Patel on 22/08/23.
//

import Foundation


let kId = "id"
let kpostId = "postId"
let ktitle = "title"
let kbody = "body"
let kisFavourite = "isFavourite"

class Post: NSObject {
    
    var postId: Int
    var title: String
    var body: String
    var isFavourite : Bool
    var userId : Int
    
    // MARK: - init
    init(dictionary: [String:Any]) {
        
        self.postId = dictionary[kId] as? Int ?? 0
        self.title = dictionary[ktitle] as? String ?? ""
        self.body = dictionary[kbody] as? String ?? ""
        self.isFavourite = dictionary[kisFavourite] as? Bool ?? false
        self.userId = dictionary[kuserId] as? Int ?? 0
    }
    
    
    /**
    This method is used to get login User Posts.
    - Parameter : userID
    - Returns: array of Post Model.
    */
    class func GetPostList(success withResponse: @escaping (_ posts: [Post]) -> (), failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        let userId = UserDefaults.standard.integer(forKey: kuserId)
        let requestURL = String(format: Constant.API.kGetPostsByUser, userId)
        APIManager.makeRequest(with: requestURL, method: .get, parameter: nil, success: {(response) in
            SVProgressHUD.dismiss()
            
            if let arrDataDict = response as? [[String:Any]] {
                
                let arr = arrDataDict.compactMap({ Post(dictionary: $0) })
                withResponse(arr)
            }
            else {
                failure(LocalizableKeys.NoDataLabelText.kNoPostsFound, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure(error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure(connectionError, .connection)
        })
    }
    
    
    /**
    This method is used to Edit post for Favourite and Unfavourite .
    - Parameter : postid
    - Returns: Falg : True / false.
    */
    class func editFavUnfavPost(wihtObjPost objPost: Post ,success withResponse: @escaping (_ isSuccess: Bool) -> (), failure: @escaping FailureBlock) {
        SVProgressHUD.show()

        let requestURL = String(format: Constant.API.kEditPostsById, objPost.postId)
        let param: [String : Any] = [kId: objPost.postId,
                                      ktitle: objPost.title,
                                       kbody: objPost.body,
                                     kuserId: objPost.userId,
                            kisFavourite: objPost.isFavourite ? 1 : 0]
        APIManager.makeRequest(with: requestURL, method: .put, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()

            if let _ = response as? [String:Any] {

                withResponse(true)
            }
            else {
                failure(LocalizableKeys.NoDataLabelText.kNotAddedToFavourite, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure(error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure(connectionError, .connection)
        })
    }
    
    
    /**
    This method is used to get Favourite Posts.
    - Parameter : userID, isFavourite
    - Returns: array of Post Model.
    */
    class func GetFavPostList(success withResponse: @escaping (_ posts: [Post]) -> (), failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        let userId = UserDefaults.standard.integer(forKey: kuserId)
        let requestURL = String(format: Constant.API.kGetFavouritePost, userId, 1)
        APIManager.makeRequest(with: requestURL, method: .get, parameter: nil, success: {(response) in
            SVProgressHUD.dismiss()
            
            if let arrDataDict = response as? [[String:Any]] {
                
                let arr = arrDataDict.compactMap({ Post(dictionary: $0) })
                withResponse(arr)
            }
            else {
                failure(LocalizableKeys.NoDataLabelText.kNoPostsFound, .response)
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

