//
//  PostHeaderCell.swift
//  CodeChallange
//
//  Created by Niyati Patel on 21/08/23.
//

import UIKit

class PostHeaderCell: UITableViewHeaderFooterView {

    
    //MARK: - IBOutlet
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    
    weak var btnFavTappedDelegate: BtnFavTappedDelegate?
    
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
    
    
    func bindPostData(obj: Post) {
        self.lblTitle.text = obj.title
        self.lblBody.text = obj.body
        self.btnFav.isSelected = obj.isFavourite
    }
}


// MARK: - IBAction Mthonthd
fileprivate extension PostHeaderCell
{
    @IBAction func btnFav_Clicked(_ sender: UIButton) {
        self.endEditing(true)
        
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.btnFavTappedDelegate?.postAddedToFav(index: sender.tag)
        } else {
            self.btnFavTappedDelegate?.postAddedToUnfav(index: sender.tag)
        }
        
        
    }
}
