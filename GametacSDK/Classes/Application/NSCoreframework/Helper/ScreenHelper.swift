//
//  ScreenHelper.swift
//  MobiCaro
//
//  Created by Duong Viet Cuong on 11/30/18.
//  Copyright © 2018 Kien Nguyen Duc. All rights reserved.
//

import UIKit

class ScreenHelper: NSObject {
    static func getScreenSize() -> CGRect {
        let screenSize: CGRect = UIScreen.main.bounds
        return screenSize
    }
}
