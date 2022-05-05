//
//  AppDelegate.swift
//  LQGUserCenter_Category
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import LQGBaseAppDelegate
import LQGBaseView
import LQGCTMediator
import LQGUser

typealias BlockType = @convention(block) ([AnyHashable: Any]?) -> Void

@UIApplicationMain
class AppDelegate: LQGBaseAppDelegate {

    override init() {
        super.init()
        
        self.needShowSignVCBlock = {
            return !LQGUserManager.shared.userStatus
        }
        
        self.getSignVCBlock = {
            let vc = CT().performTarget("Sign", action: "getSignRootVC", params: [
                kCTMediatorParamsKeySwiftTargetModuleName: "LQGSign_Category",
                "signInSuccessCompletion": {
                    let block: BlockType = { userInfo in
                        LQGUserManager.shared.signIn(userInfo: userInfo)
                    }
                    return unsafeBitCast(block as BlockType, to: AnyObject.self)
                }()
            ], shouldCacheTarget: false) as? UIViewController
            if vc == nil {
                return nil
            }
            return LQGBaseNavigationController.init(rootViewController: vc!)
        }
        
        self.getMainVCBlock = {
            let vc = CT().performTarget("UserCenter", action: "getRootVC", params: [
                kCTMediatorParamsKeySwiftTargetModuleName: "LQGUserCenter_Category"
            ], shouldCacheTarget: false) as? UIViewController
            if vc == nil {
                return nil
            }
            return LQGBaseNavigationController.init(rootViewController: vc!)
        }
    }
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        let status = super.application(application, didFinishLaunchingWithOptions: launchOptions)
                
        LQGUserManager.shared.rx.observe(Bool.self, "userStatus", options: .new).subscribe { (userStatus) in
            self.lqg_setupRootViewController()
        } onDisposed: {}

        return status
    }

}
