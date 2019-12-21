//
//  NotifVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/2/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NotifVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        // Config XLPagerTabStrip
        settings.style.buttonBarBackgroundColor = #colorLiteral(red: 0.231372549, green: 0.231372549, blue: 0.231372549, alpha: 1)
        settings.style.buttonBarItemBackgroundColor = #colorLiteral(red: 0.231372549, green: 0.231372549, blue: 0.231372549, alpha: 1)
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.231372549, green: 0.231372549, blue: 0.231372549, alpha: 1)
        
        // Set Font
//        settings.style.buttonBarItemFont = UIFont(name: "OpenSans-Light", size: 16)!
        settings.style.selectedBarHeight = 3
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarItemLeftRightMargin = 12
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.font = UIFont(name: "OpenSans-Light", size: 16)/* ?? UIFont.systemFont(ofSize: 16, weight: .light)*/
            oldCell?.label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            newCell?.label.font = UIFont(name: "OpenSans-Bold", size: 18)/* ?? UIFont.systemFont(ofSize: 16, weight: .bold)*/
            newCell?.label.textColor = #colorLiteral(red: 0.3294117647, green: 0.5568627451, blue: 0.7764705882, alpha: 1)
        }
        //
        super.viewDidLoad()
        self.hideKeyboard()
        buttonBarView.selectedBar.cornerRadius = 0
        buttonBarView.selectedBar.backgroundColor = #colorLiteral(red: 0, green: 0.5764705882, blue: 0.8196078431, alpha: 1)
        settings.style.selectedBarHeight = 3

    }
    
    open override func viewDidLayoutSubviews() {
        view.layoutIfNeeded()
        super.viewDidLayoutSubviews()
    }
    
    private var vc1 = DetailNotiVC()
    private var vc2 = NewsVC()
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        vc1.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height)
        vc2.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height)
        return [vc1, vc2]
    }
}

