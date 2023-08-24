//
//  CommentsVC.swift
//  CodeChallange
//
//  Created by Niyati Patel on 21/08/23.
//

import UIKit

class CommentsVC: UIViewController {

    //MARK: - Variables
    var objPost: (Post, Int)?
    var arrComments: [Comment] = []
    weak var btnFavTappedDelegate: BtnFavTappedDelegate?
    
    //MARK: - IBOutlet
    @IBOutlet weak var tvComments: UITableView!
    
    
    
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
extension CommentsVC {
    
    /**
     This method is used to make initial configurations to controls.
     */
    func initialConfig() {
        self.title = LocalizableKeys.NavigationTitle.kComments
        
        self.tvComments.delegate = self
        self.tvComments.dataSource = self
        self.tvComments.register(nib: Constant.CellIdentifier.kCommentCell)
        self.tvComments.register(UINib(nibName: Constant.CellIdentifier.kPostHeaderCell, bundle: nil), forHeaderFooterViewReuseIdentifier: Constant.CellIdentifier.kPostHeaderCell)
        
        
        self.setupESInfiniteScrollinWithTableView()
        //Api call
        self.getCommentsApi()
    }
    
    /**
     This method is used to decorate UI controls.
     */
    private func decorateUI() {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    func setupESInfiniteScrollinWithTableView() {
        
        self.tvComments.es.addPullToRefresh {
            [unowned self] in
            self.view.endEditing(true)
            
            self.getCommentsApi()
            
        }
        
    }
}


//MARK: UITableViewDelegate, UITableViewDataSource Methods
extension CommentsVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constant.CellIdentifier.kPostHeaderCell) as? PostHeaderCell else {
            return UITableViewHeaderFooterView()
        }
        
        if let obj = self.objPost {
            
            header.bindPostData(obj: obj.0)
            header.btnFavTappedDelegate = self
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.kCommentCell) as? CommentCell else {
            return UITableViewCell()
        }
        
        let obj = self.arrComments[indexPath.row]
        cell.bindCommentData(obj: obj)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


//MARK: BtnFavTappedDelegate Methods
extension CommentsVC: BtnFavTappedDelegate {
    func postAddedToFav(index: Int) {
        self.objPost?.0.isFavourite = true
        if let index = self.objPost?.1 {
            self.btnFavTappedDelegate?.postAddedToFav(index: index)
        }
        
        
        self.tvComments.reloadSections(IndexSet(integer: 0), with: .automatic)
        //Api call
        self.editPostAsFavOrUnfav(obj: self.objPost?.0)
    }

    func postAddedToUnfav(index: Int) {
        self.objPost?.0.isFavourite = false
        if let index = self.objPost?.1 {
            self.btnFavTappedDelegate?.postAddedToUnfav(index: index)
        }
        
        self.tvComments.reloadSections(IndexSet(integer: 0), with: .automatic)
        //Api call
        self.editPostAsFavOrUnfav(obj: self.objPost?.0)
    }
}


//MARK: API Call
extension CommentsVC {
    
    /**
     Api call to get all Comments on a specifict Post.
     */
    func getCommentsApi() {
        
        guard let postid = self.objPost?.0.postId else {
            self.showAlert(withTitle: "", with: LocalizableKeys.NoDataLabelText.kNoCommentsFound)
            self.tvComments.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
            return
        }
        
        Comment.GetCommentsListOnPost(withPostId: postid) { comments in
            
            self.arrComments = comments
            self.tvComments.reloadData()
            self.tvComments.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        } failure: { error in
            if !error.isEmpty {
                self.showAlert(with: error.debugDescription)
            }
            self.tvComments.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        }
    }
    
    
    /**
     Api call edit post to fav and unfav post.
     */
    func editPostAsFavOrUnfav(obj: Post?) {
        
        guard let obj = obj else {
            return
        }
        Post.editFavUnfavPost(wihtObjPost: obj) { isSuccess in
            print("Successfully EDITED to Fav or Unfav.")
            
        } failure: { error in
            if !error.isEmpty {
                self.showAlert(with: error.debugDescription)
            }
        }

    }
}
