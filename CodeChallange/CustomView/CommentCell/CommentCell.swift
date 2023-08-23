//
//  CommentCell.swift
//  CodeChallange
//
//  Created by Niyati Patel on 21/08/23.
//

import UIKit

class CommentCell: UITableViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    

    //MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initConfig()
    }
    
    /**
     This method is used to make initial configurations to controls.
     */
    func initConfig() {
        self.vwContainer.setCornerRadius(cornerRadius: UIHelperConstants.postCellRadius)
        self.vwContainer.setShadow()
    }
    
    /**
     This method is used to bind Comment object Data.
     */
    func bindCommentData(obj: Comment) {
        self.lblComment.text = obj.comment
        self.lblUserName.text = obj.user.username
    }
    
}
