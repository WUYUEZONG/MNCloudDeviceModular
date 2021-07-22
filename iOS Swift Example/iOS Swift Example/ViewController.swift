//
//  ViewController.swift
//  iOS Swift Example
//
//  Created by 蛮牛科技 on 7/21/21.
//

import UIKit
import MNCloudDeviceModular

class ViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            
            let l = UICollectionViewFlowLayout()
            l.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 308)
            l.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 308)
            l.minimumLineSpacing = 16
            l.scrollDirection = .vertical
            collection.setCollectionViewLayout(l, animated: false)
            let p = Bundle.main.path(forResource: "MNCloudDeviceModular", ofType: "framework")
            let b = Bundle(path: p!)
            let n = b?.loadNibNamed("MNCloudLiveCardCell", owner: nil, options: nil)?.first as! UINib
            collection.register(n, forCellWithReuseIdentifier: "MNCloudLiveCardCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MNCloudLiveCardCell", for: indexPath)
        cell.contentView.backgroundColor = .systemTeal
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let c = MNCloudController()
        showDetailViewController(c, sender: nil)
    }
    
    
}

