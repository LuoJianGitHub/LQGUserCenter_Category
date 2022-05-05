//
//  Target_UserCenter.swift
//  LQGUserCenter_Category
//
//  Created by 罗建
//  Copyright (c) 2021 罗建. All rights reserved.
//

import Foundation
import LQGUserCenter

@objcMembers public class Target_UserCenter: NSObject {
    
    public func Action_getRootVC(_ params: NSDictionary?) -> UIViewController {
        return LQGUserCenterController.init()
    }
    
}
