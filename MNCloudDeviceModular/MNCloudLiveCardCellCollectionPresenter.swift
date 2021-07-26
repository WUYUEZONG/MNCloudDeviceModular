//
//  MNCloudLiveCardCellCollectionPresenter.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit

class MNCloudLiveCardCellCollectionPresenter: NSObject {
    
    private var cell: MNCloudLiveCardCell!
    lazy var collection: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 120, height: 80)
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = 10
        l.minimumInteritemSpacing = 10
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.dataSource = self
        c.delegate = self
        c.backgroundColor = .white
        c.register(SingleImageCollectionCell.self, forCellWithReuseIdentifier: "SingleImageCollectionCell")
        cell.contentView.addSubview(c)
        c.translatesAutoresizingMaskIntoConstraints = false
        let h = c.heightAnchor.constraint(equalToConstant: 80)
        let leading = c.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor)
        let trailing = c.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
        let top = c.topAnchor.constraint(equalTo: cell.bottomStack.bottomAnchor)
        NSLayoutConstraint.activate([top, h, leading, trailing])

        c.isHidden = true
        return c
    }()
    
    init(_ cell: MNCloudLiveCardCell) {
        self.cell = cell
    }

}

extension MNCloudLiveCardCellCollectionPresenter: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleImageCollectionCell", for: indexPath) as! SingleImageCollectionCell
        cell.backgroundImage.image = UIImage(named: "holder")
        return cell
    }
    
    
}
