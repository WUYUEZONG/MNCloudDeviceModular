//
//  ViewController.swift
//  iOS Swift Example
//
//  Created by 蛮牛科技 on 7/21/21.
//

import UIKit
import MNCloudDeviceModular

class ViewController: UIViewController {

    lazy var data: [LiveCardModel] = {
        
        return [LiveCardModel(), LiveCardModel(), LiveCardModel(), LiveCardModel(), LiveCardModel(), LiveCardModel(), LiveCardModel(), LiveCardModel(), LiveCardModel(), LiveCardModel()]
    }()
    
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            
            let l = UICollectionViewFlowLayout()
//            l.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            l.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 308)
            l.minimumLineSpacing = 16
            l.scrollDirection = .vertical
            collection.setCollectionViewLayout(l, animated: false)
            collection.register(MNCloudLiveCardCell.self, forCellWithReuseIdentifier: "MNCloudLiveCardCell")
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MNCloudLiveCardCell", for: indexPath) as! MNCloudLiveCardCell
        cell.model = data[indexPath.row]
//        cell.deviceLogo.setImage(UIImage(named: "holder"), for: .normal)
//        cell.networkStatus.setImage(UIImage(systemName: "logo.xbox"), for: .normal)
        cell.screenShoot.image = UIImage(named: "holder")
//        cell.shareButton.setImage(UIImage(systemName: "logo.xbox"), for: .normal)
//        cell.alarmButton.setImage(UIImage(systemName: "logo.xbox"), for: .normal)
//        cell.cloudStoreButton.setImage(UIImage(systemName: "logo.xbox"), for: .normal)
//        cell.settingButton.setImage(UIImage(systemName: "logo.xbox"), for: .normal)
        cell.delegate = self
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let c = MNCloudController()
//        showDetailViewController(c, sender: nil)
    }
    
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return data[indexPath.row].liveCardSize
    }
}


extension ViewController: MNCloudLiveCardCellDelegate {
    func didTapDeviceName(cell: MNCloudLiveCardCell) {
        
    }
    
    func didTapNetworkImage(cell: MNCloudLiveCardCell) {
        
    }
    
    func didTapShareButton(cell: MNCloudLiveCardCell) {
        
    }
    
    func didTapAlarmButton(cell: MNCloudLiveCardCell) {
        if let i = collection.indexPath(for: cell) {
            
            collection.reloadItems(at: [i])
//            collection.reloadData()
        }
    }
    
    func didTapCloudStoreButton(cell: MNCloudLiveCardCell) {
        
    }
    
    func didTapSettingButton(cell: MNCloudLiveCardCell) {
        
    }
    
    
}
