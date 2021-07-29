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
        l.itemSize = CGSize(width: 120, height: 60)
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = 10
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.dataSource = self
        c.backgroundColor = .white
        c.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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

extension MNCloudLiveCardCellCollectionPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = self.cell.dataSource else {
            return 0
        }
        return dataSource.subCellCounts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleImageCollectionCell", for: indexPath) as! SingleImageCollectionCell
        cell.backgroundImage.image = self.cell.dataSource?.subImage(collectionView, forCellAt: indexPath)
        cell.recordingTime.text = self.cell.dataSource?.subTime(collectionView, forCellAt: indexPath)
        return cell
    }
    
    
}
