//
//  ReportVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/2/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import DKImagePickerController

class ReportVC: UIViewController {
    
    
    @IBOutlet weak var clvPhotoSelected: UICollectionView!
    @IBOutlet weak var heightClvPhotoSelected: NSLayoutConstraint!
    @IBOutlet weak var tvContent: UITextView!
    
    @IBAction func btnSend(_ sender: Any) {
    }
    @IBAction func btnAddImage(_ sender: Any) {
        selectPhoto()
    }
    
    
    var photoSelected:[UIImage] = []
    
    
    func configCollectionView(){
        clvPhotoSelected.delegate = self
        clvPhotoSelected.dataSource = self
        self.clvPhotoSelected.register(UINib(nibName: "PhotoSelectedCell", bundle: nil) , forCellWithReuseIdentifier: "PhotoSelectedCell")
    }
    
    func selectPhoto(){
        let pickerController = DKImagePickerController()
        pickerController.maxSelectableCount = 20
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
            print(assets)
            var photoArray = [UIImage]()
            for photo in assets{
                photo.fetchOriginalImage(completeBlock: { (image, info) in
                    if let _ = image{
                        photoArray.append(image!)
                        self.photoSelected = photoArray
                        self.heightClvPhotoSelected.constant = 110
                        //                        self.viewheight.frame.height
                        UIView.animate(withDuration: 0.3) {
                            self.view.layoutIfNeeded()
                        }
                        self.clvPhotoSelected.reloadData()
                    }
                })
            }
        }
        
        self.present(pickerController, animated: true) {}
    }
    
    override var shouldAutorotate: Bool {
        if interfaceOrientation == .landscapeLeft || interfaceOrientation == .landscapeRight {
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configCollectionView()
    }
}
extension ReportVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoSelected.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoSelectedCell", for: indexPath) as! PhotoSelectedCell
        
        cell.imgSelected.image = photoSelected[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 70 , height: 110 )
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let alert = UIAlertController(title: "Thông báo", message: "Bạn muốn xóa ảnh ?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Hủy", style: UIAlertAction.Style.destructive, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Đồng ý", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            
            print("OKOK")
            
            self.photoSelected.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            if self.photoSelected == [] {
                self.heightClvPhotoSelected.constant = 0
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
            self.clvPhotoSelected.reloadData()
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
