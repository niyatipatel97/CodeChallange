//
//  Constant.swift
//  CodeChallange
//
//  Created by Niyati Patel on 21/08/23.
//

import Foundation
import UIKit

typealias FailureBlock = (_ error: String) -> Void


//Error enum
//enum ErrorType {
//    case server
//    case connection
//    case response
//}

//MARK: appDelegate
let appDelegate = UIApplication.shared.delegate as! AppDelegate


//MARK: - Constant
class Constant : NSObject {
    
    // MARK: - Cell Identifier constant
    struct CellIdentifier {
        static let kPostCell        = "PostCell"
        static let kPostHeaderCell  = "PostHeaderCell"
        static let kCommentCell     = "CommentCell"
    }
    
    // MARK: - Storyboard Identifier constant
    struct StoryboardIdentifier {
        static let kMain            = "Main"
        
    }
    
    // MARK: - VC Identifier constant
    struct VCIdentifier {
        static let kCommentsVC      = "CommentsVC"
        static let kTabbarVC        = "TabbarVC"
        static let kLoginVC         = "LoginVC"
        
    }
    
    struct API {
        static let BASE_URL = "http://localhost:3000/"
        
        //Master Data Api
        static let kGetPostsByUser        = BASE_URL + "posts?userId=%d"
        static let kEditPostsById         = BASE_URL + "posts/%d"
        static let kComments              = BASE_URL + "comments?postId=%d"
        static let kUsers                 = BASE_URL + "users?userId=%d"
        static let kGetFavouritePost      = BASE_URL + "posts?userId=%d&isFavourite=%d"
    }
}



// MARK: - Screen size and device type
//iPhone Screensize
struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//iPhone devicetype
struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = ScreenSize.SCREEN_HEIGHT == 812.0
    
    static let IS_IPHONE_XMAX          = ScreenSize.SCREEN_HEIGHT == 896.0
    static let IS_PAD               = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    //IPAD Device Constants
    static let IsDeviceIPad = IS_PAD || IS_IPAD || IS_IPAD_PRO ? true : false
}


//MARK: UIHelper Constants
struct UIHelperConstants {
    //Corner Radius
    static let postCellRadius : CGFloat = DeviceType.IsDeviceIPad ? 6.5 : 6
    static let appButtonRadius : CGFloat = DeviceType.IsDeviceIPad ? 15 : 10
}

// MARK: - Color Constant
extension UIColor {
    struct CustomColor {
        
        static let postCellBorder    = UIColor(named: "cl_postCellBorder") ?? .gray
        static let appColor          = UIColor(named: "cl_appColor") ?? .blue
    }
}
