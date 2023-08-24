//
//  FavouritePostVC.swift
//  CodeChallange
//
//  Created by Niyati Patel on 21/08/23.
//

import UIKit

class FavouritePostVC: UIViewController {
    
    //MARK: - Variables
    var arrFavPosts: [Post] = []
    
    //MARK: - IBOutlet
    @IBOutlet weak var tvFavPosts: UITableView!
    
    
    
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
extension FavouritePostVC {
    
    /**
     This method is used to make initial configurations to controls.
     */
    func initialConfig() {
        self.title = LocalizableKeys.NavigationTitle.kFavourites
        
        self.tvFavPosts.delegate = self
        self.tvFavPosts.dataSource = self
        self.tvFavPosts.register(nib: Constant.CellIdentifier.kPostCell)
        
        self.setupESInfiniteScrollinWithTableView()
        self.getFavPostsApi()
    }
    
    /**
     This method is used to decorate UI controls.
     */
    private func decorateUI() {
        
        
    }
    
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    func setupESInfiniteScrollinWithTableView() {
        
        self.tvFavPosts.es.addPullToRefresh {
            [unowned self] in
            self.view.endEditing(true)
            
            self.getFavPostsApi()
            
        }
        
    }
}



//MARK: UITableViewDelegate, UITableViewDataSource Methods
extension FavouritePostVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFavPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.kPostCell) as? PostCell else {
            return UITableViewCell()
        }
        let obj = self.arrFavPosts[indexPath.row]
        cell.btnFav.tag = indexPath.row
        cell.bindPostData(obj: obj)
        cell.btnFavTappedDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: BtnFavTappedDelegate Methods
extension FavouritePostVC: BtnFavTappedDelegate {
    func postAddedToFav(index: Int) {
    }
    
    func postAddedToUnfav(index: Int) {
        
        if index <= (self.arrFavPosts.count-1) {
            
            self.arrFavPosts[index].isFavourite = false
            
            //Remove star book mark from MyPost screen Manually
            if let vc = self.tabBarController?.viewControllers?.first as? UINavigationController {
                if let vc2 = vc.viewControllers.first as? MyPostVC {
                    if vc2.arrPosts.contains(where: { $0.postId == self.arrFavPosts[index].postId }), let indexOfMyPostscreen = vc2.arrPosts.firstIndex(where: { $0.postId == self.arrFavPosts[index].postId }) {
                        
                        vc2.arrPosts[indexOfMyPostscreen].isFavourite = self.arrFavPosts[index].isFavourite
                        if vc2.tvMyPosts != nil {
                            vc2.tvMyPosts.reloadData()
                        }
                    }
                }
            }
            
            //Api call
            self.editPostAsFavOrUnfav(obj: self.arrFavPosts[index], index: index)

        }
    }
}



//MARK: API Call
extension FavouritePostVC {
    
    /**
     Api call to get all Favourite Posts of loggedin User.
     */
    func getFavPostsApi() {
        Post.GetFavPostList { posts in
            
            self.arrFavPosts = posts
            self.tvFavPosts.reloadData()
            self.tvFavPosts.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        } failure: { error in
            if !error.isEmpty {
                self.showAlert(with: error.debugDescription)
            }
            self.tvFavPosts.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        }

    }
    
    /**
     Api call edit post to fav and unfav post.
     */
    func editPostAsFavOrUnfav(obj: Post, index: Int) {
        Post.editFavUnfavPost(wihtObjPost: obj) { isSuccess in
            print("Successfully EDITED to Fav or Unfav.")
            self.arrFavPosts.remove(at: index)
            
            
            self.tvFavPosts.reloadData()
        } failure: { error in
            if !error.isEmpty {
                self.showAlert(with: error.debugDescription)
            }
        }

    }
}
