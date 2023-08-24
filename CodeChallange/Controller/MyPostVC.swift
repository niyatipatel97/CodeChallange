//
//  HomeVC.swift
//  CodeChallange
//
//  Created by Niyati Patel on 21/08/23.
//

import UIKit

class MyPostVC: UIViewController {

    //MARK: - Variables
    var arrPosts: [Post] = []
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var tvMyPosts: UITableView!
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialConfig()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.decorateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

}


//MARK: UI Helpers
extension MyPostVC {
    
    /**
     This method is used to make initial configurations to controls.
     */
    func initialConfig() {
        self.title = LocalizableKeys.NavigationTitle.kMyPosts
        
        self.tvMyPosts.delegate = self
        self.tvMyPosts.dataSource = self
        self.tvMyPosts.register(nib: Constant.CellIdentifier.kPostCell)
        
        self.setupESInfiniteScrollinWithTableView()
        self.getMyPostsApi()
        
        // Add Logout button.
        let logout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logOutUser))
        self.navigationItem.rightBarButtonItem = logout
    }
    
    /**
     This method is used to decorate UI controls.
     */
    private func decorateUI() {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    /**
     This method is used to  setup ESInfiniteScrollin With TableView
     */
    func setupESInfiniteScrollinWithTableView() {
        
        self.tvMyPosts.es.addPullToRefresh {
            [unowned self] in
            self.view.endEditing(true)
            
            self.getMyPostsApi()
            
        }
        
    }
    
    /**
     This method is used as selector method of logout button.
     */
    @objc func logOutUser() {
        UserDefaults.standard.removeObject(forKey: kuserId)
        appDelegate.SetupRootScreen()
    }
}



//MARK: UITableViewDelegate, UITableViewDataSource Methods
extension MyPostVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPosts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.kPostCell) as? PostCell else {
            return UITableViewCell()
        }
        let obj = self.arrPosts[indexPath.row]
        cell.btnFav.tag = indexPath.row
        cell.bindPostData(obj: obj)
        cell.btnFavTappedDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.kCommentsVC) as? CommentsVC {
            VC.objPost = (self.arrPosts[indexPath.row], indexPath.row)
            VC.btnFavTappedDelegate = self
            self.navigationController?.pushViewController(VC, animated: true)
        }
            
    }
}



//MARK: BtnFavTappedDelegate Methods
extension MyPostVC: BtnFavTappedDelegate {
    func postAddedToFav(index: Int) {
        if index <= (self.arrPosts.count-1) {
            
            self.arrPosts[index].isFavourite = true
            let indexPath = IndexPath(row: index, section: 0)
            self.tvMyPosts.reloadRows(at: [indexPath], with: .automatic)
            
            //Add object to FavouritePosts screen
            if let vc = self.tabBarController?.viewControllers?.last as? UINavigationController {
                if let vc2 = vc.viewControllers.first as? FavouritePostVC {
                    vc2.arrFavPosts.append(self.arrPosts[index])
                    if vc2.tvFavPosts != nil {
                        vc2.tvFavPosts.reloadData()
                    }
                }
            }
            
            
            //Api call
            self.editPostAsFavOrUnfav(obj: self.arrPosts[index])
            
            
        }
    }
    
    func postAddedToUnfav(index: Int) {
        if index <= (self.arrPosts.count-1) {
            self.arrPosts[index].isFavourite = false
            let indexPath = IndexPath(row: index, section: 0)
            self.tvMyPosts.reloadRows(at: [indexPath], with: .automatic)
            
            //Remove Object from FavouritePosts screen Manually
            if let vc = self.tabBarController?.viewControllers?.last as? UINavigationController {
                if let vc2 = vc.viewControllers.first as? FavouritePostVC {
                    if vc2.arrFavPosts.contains(where: { $0.postId == self.arrPosts[index].postId }) {
                        vc2.arrFavPosts.removeAll(where: { $0.postId == self.arrPosts[index].postId })
                        if vc2.tvFavPosts != nil {
                            vc2.tvFavPosts.reloadData()
                        }
                    }
                }
            }
            
            //Api call
            self.editPostAsFavOrUnfav(obj: self.arrPosts[index])
            
        }
    }
}



//MARK: API Call
extension MyPostVC {
    
    /**
     Api call to get all My Post data of loggedin User.
     */
    func getMyPostsApi() {
        Post.GetPostList { posts in
            
            self.arrPosts = posts
            self.tvMyPosts.reloadData()
            self.tvMyPosts.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        } failure: { error, customError in
            if !error.isEmpty {
                self.showAlert(withTitle: customError.rawValue, with: error)
            }
            self.tvMyPosts.es.stopPullToRefresh(ignoreDate: false, ignoreFooter: false)
        }

    }
    
    /**
     Api call edit post to fav and unfav post.
     */
    func editPostAsFavOrUnfav(obj: Post) {
        Post.editFavUnfavPost(wihtObjPost: obj) { isSuccess in
            print("Successfully EDITED to Fav or Unfav.")
        } failure: { error, customError in
            if !error.isEmpty {
                self.showAlert(withTitle: customError.rawValue, with: error)
            }
        }

    }
    
}
