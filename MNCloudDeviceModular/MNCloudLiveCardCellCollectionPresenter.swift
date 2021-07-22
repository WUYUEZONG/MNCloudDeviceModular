//
//  MNCloudLiveCardCellCollectionPresenter.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit

class MNCloudLiveCardCellCollectionPresenter: NSObject {
    
    
    private var cell: MNCloudLiveCardCell!
    private lazy var collection: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 120, height: 80)
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = 10
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.dataSource = self
        c.delegate = self
        c.register(UINib(nibName: "SingleImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SingleImageCollectionCell")
        cell.contentView.addSubview(c)
        c.translatesAutoresizingMaskIntoConstraints = false
        let h = c.heightAnchor.constraint(equalToConstant: 80)
        let leading = c.leadingAnchor.constraint(equalTo: cell.leadingAnchor)
        let t = c.trailingAnchor.constraint(equalTo: cell.trailingAnchor)
        let b = c.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
        let top = c.topAnchor.constraint(equalTo: cell.bottomStack.bottomAnchor)
        NSLayoutConstraint.activate([top, h, leading, t, b])
        b.isActive = false
        b.identifier = "collectionBottomToCellBottom"
        c.isHidden = true
        return c
    }()
    
    init(_ collectionCell: MNCloudLiveCardCell) {
        cell = collectionCell
    }

}

extension MNCloudLiveCardCellCollectionPresenter: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleImageCollectionCell", for: indexPath)
        return cell
    }
    
    
}
