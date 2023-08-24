//
//  LocalizationIdentifierConstants.swift
//  CodeChallange
//
//  Created by Niyati Patel on 21/08/23.
//

import Foundation

//MARK: - Localization Keys
struct LocalizableKeys {
    
    
    //MARK: - Localizable Label Keys
    struct Labels {
        
        //Authentication
        static let kLogin                           = "LOGIN"
        static let kUserID                          = "User ID"
        static let kErrorUserId                     = "Please enter valid User ID"
        
        //Dashboard
    }
    
    
    //MARK: - No Data Label Text
    struct NoDataLabelText {
        static let kNoUserFound                     = "No user found."
        static let kNoPostsFound                    = "No Posts available for this user."
        static let kNoFavouritesFound               = "No Favourites available."
        static let kNoCommentsFound                 = "No Comments available."
        static let kNotAddedToFavourite             = "Not able to add post to favourite."
    }
    
    //MARK: NavigationTitle Names
    struct NavigationTitle {
        static let kMyPosts                         = "My Posts"
        static let kComments                        = "Comments"
        static let kFavourites                      = "Favourites"
    }
    
    
    //MARK: - Button
    struct Buttons {
        
        //Alert Buttons
        static let kOK                              = "OK"
        static let kCANCEL                          = "CANCEL"
     }
    
    //MARK: - ValidationMessages
    struct ValidationMessages {
        
        //Authentication
        static let kInvalidUserId                   = "Please enter valid userId."
    }
    
    //MARK: - Alert Title Keys
    struct AlertTitles {
        static let kRemoveFavourite                 = "Remove Favourite"
    }
    
    //MARK: - Alert Messages Keys
    struct AlertMessages {
        static let kRemoveFavourite                 = "Are you sure you want to remove this post from favourite?"
    }
    
    //MARK: - Error Messages Keys
    struct ErrorMessages {
        static let kNoInternetConnection            = "Please check your internet connection"
        static let kCommanErrorMessage              = "Something went wrong. Please try again later."
        static let kFailToLogin                     = "Fail to login"
        static let kSessionExpired                  = "Session expired. Please login again."
        
    }
}
