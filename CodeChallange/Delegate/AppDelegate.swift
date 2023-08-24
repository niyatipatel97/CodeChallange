//
//  AppDelegate.swift
//  CodeChallange
//
//  Created by Niyati Patel on 20/08/23.
//

import UIKit
import SVProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //SVProgressHUD
        self.setSVProgressHUDconfiguration()
        
        //Set Root screen
        self.SetupRootScreen()
        
        return true
    }




}


//MARK: - Private Methods
extension AppDelegate {
    
    //MARK: Custom Methods
    /**
     This method is used to set SVProgressHUD configuration.
     */
    func setSVProgressHUDconfiguration() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom)
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.white)
        let size = DeviceType.IsDeviceIPad ?
        CGSize(width: 100, height: 100) : CGSize(width: 75, height: 75)
        SVProgressHUD.setMinimumSize(size)
    }
    
    //MARK:- App Naviagtion Methods
    
    func SetupRootScreen() {
        if let _ = UserDefaults.standard.object(forKey: kuserId) as? Int {
            
            self.setTabBarHomeAsRootViewController()
        }
        else {
            self.setLoginAsRootViewController()
        }
    }
    
    /**
     Set TabBar As Root ViewController.
     */
    func setTabBarHomeAsRootViewController() {
        
        if appDelegate.window == nil {
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        if let tabbarVC = UIStoryboard(name: Constant.StoryboardIdentifier.kMain, bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.kTabbarVC) as? TabbarVC {
            appDelegate.window?.rootViewController = tabbarVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    /**
     Set Login As Root ViewController.
     */
    func setLoginAsRootViewController() {
        
        if appDelegate.window == nil {
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        if let loginVC = UIStoryboard(name: Constant.StoryboardIdentifier.kMain, bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.kLoginVC) as? LoginVC {
            appDelegate.window?.rootViewController = loginVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}
