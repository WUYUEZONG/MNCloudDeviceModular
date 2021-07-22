//
//  MNCloudController.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit

public class MNCloudController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            
            let l = UICollectionViewFlowLayout()
            l.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 308)
            l.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 308)
            l.minimumLineSpacing = 16
            l.scrollDirection = .vertical
            collection.setCollectionViewLayout(l, animated: false)
            collection.register(UINib(nibName: "MNCloudDeviceModular.framework/MNCloudLiveCardCell", bundle: nil), forCellWithReuseIdentifier: "MNCloudLiveCardCell")
        }
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

}


extension MNCloudController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MNCloudLiveCardCell", for: indexPath)
//        cell.contentView.backgroundColor = .systemTeal
        return cell
    }
    
    
    
}
