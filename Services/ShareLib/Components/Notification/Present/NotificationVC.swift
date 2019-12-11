//import UIKit
//import DZNEmptyDataSet
//
//class NotificationVC: UIViewController,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate  {
//    
//    @IBOutlet weak var tblNotification: UITableView!
//    
//    fileprivate var notifications : [NotificationStruct] = []
//    
//    var indexLocation : String = String()
//    var loadMoreStatus : Bool = false
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tblNotification.emptyDataSetSource = self
//        tblNotification.emptyDataSetDelegate = self
//        tblNotification.register(UINib(nibName: "NotificationTVC", bundle: nil), forCellReuseIdentifier: "NotificationTVCIdentity")
//        tblNotification.tableFooterView = UIView()
//        // Do any additional setup after loading the view.
//        
//        getDataResponseServer(index: indexLocation)
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        getDataResponseServer(index: "0")
//        super.viewDidAppear(animated)
//    }
//    
////    // Make request to server for get lasted notification
////    func getDataResponseServer(index : String){
////        NotificationService
////            .sharedInstance
////            .list(i_index: index){ error , indexServer, notification in
////                self.notifications = notification
////                self.indexLocation = indexServer
////                self.tblNotification.reloadData()
////        }
////    }
//    
//    //Load more data when scroll table view
//    func loadMore() {
//        if (!loadMoreStatus ) {
//            self.loadMoreStatus = true
//            if(self.indexLocation == "-1"){
//                return
//            }else{
//                self.getDataResponseServer(index: self.indexLocation)
//            }
//            
//        }
//    }
//    
//    // Get Last index Tableview
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//        let deltaOffset = maximumOffset - currentOffset
//        
//        if deltaOffset <= 0 {
//            loadMore()
//        }
//    }
//    
//    
//    // MARK: - Deal with the empty data set
//    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        let str = "Oooooppss!!"
//        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
//        return NSAttributedString(string: str, attributes: attrs)
//    }
//    
//    //Add description/subtitle on empty dataset
//    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        let str = "Bạn chưa có thông báo nào"
//        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
//        return NSAttributedString(string: str, attributes: attrs)
//    }
//    
//    //Add your image
//    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
//        return UIImage(named: "ic_emptyTable")
//    }
//    
//}
//
//extension NotificationVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notifications.count
//    }
//    
//    // Define data for row
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let notice = notifications[indexPath.row]
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVCIdentity", for: indexPath) as! NotificationTVC
//        cell.lblTitle.text = notice.content
//        cell.lblTime.text = TimeHelper.timeAgoSince(notice.time)
//        cell.imgAvatar.kf.setImage(with: URL(string:notice.imageURL))
//        // Show icon if not
//        if(!notice.icon.isEmpty){
//            cell.imgIcon.image = UIImage(named: "notify-\(notice.icon)")
//        }
//        return cell
//    }
//}
//
//// MARK: - TableViewDelegate
//
//extension NotificationVC: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        
//    }
//    
//}
