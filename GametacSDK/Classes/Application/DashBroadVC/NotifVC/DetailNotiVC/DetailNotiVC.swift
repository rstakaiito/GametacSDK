//
//  DetailNotiVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/2/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DetailNotiVC: UIViewController, IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Sự kiện")
    }
    
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var tbvListNoti: UITableView!
    
    
    func configTableView(){
        tbvListNoti.delegate = self
        tbvListNoti.dataSource = self
//        tbvListReport.emptyDataSetDelegate = self
//        tbvListReport.emptyDataSetSource = self
//        tbvListReport.separatorColor = UIColor.clear
        self.tbvListNoti.register(UINib(nibName: "NotiCell", bundle: nil), forCellReuseIdentifier: "NotiCell")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
    }
}

extension DetailNotiVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotiCell", for: indexPath) as! NotiCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PopupVC()
        //        let popup = PopupDialog(viewController: vc, transitionStyle: .zoomIn)
        //        vc.preferredContentSize = CGSize(656, 336)
        vc.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
