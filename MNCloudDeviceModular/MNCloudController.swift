//
//  MNCloudController.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit

public class MNCloudController: UIViewController {
    
    var collection: UICollectionView! {
        didSet {
            
            let l = UICollectionViewFlowLayout()
            l.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 308)
            l.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 308)
            l.minimumLineSpacing = 16
            l.scrollDirection = .vertical
            collection.delegate = self
            collection.dataSource = self
            collection.setCollectionViewLayout(l, animated: false)
            collection.register(MNCloudLiveCardCell.self, forCellWithReuseIdentifier: "MNCloudLiveCardCell")
        }
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collection = UICollectionView()
        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        let leading = collection.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let top = collection.topAnchor.constraint(equalTo: view.topAnchor)
        let trailing = collection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leading, top, trailing, bottom])
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
