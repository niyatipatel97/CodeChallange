//
//  AppDelegate.swift
//  CodeChallange
//
//  Created by Niyati Patel on 20/08/23.
//

import UIKit
import Firebase
import SVProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Firebase
        FirebaseApp.configure()
        
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
//        SVProgressHUD.setBackgroundLayerColor(UIColor.CustomColor.appBlackColor.withAlphaComponent(0.2))
        SVProgressHUD.setForegroundColor(UIColor.lightGray)
        SVProgressHUD.setBackgroundColor(UIColor.white)
        let size = DeviceType.IsDeviceIPad ?
        CGSize(width: 100, height: 100) : CGSize(width: 75, height: 75)
        SVProgressHUD.setMinimumSize(size)
    }
    
    //MARK:- App Naviagtion Methods
    
    func SetupRootScreen() {
        if let userid = UserDefaults.standard.object(forKey: kuserId) as? Int {
            
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
        
        if let tabbarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarVC") as? TabbarVC {
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
        
        if let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            appDelegate.window?.rootViewController = loginVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}
