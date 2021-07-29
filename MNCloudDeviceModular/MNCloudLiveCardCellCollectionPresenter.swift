//
//  MNCloudLiveCardCellCollectionPresenter.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit

public class MNCloudLiveCardCellCollectionPresenter: NSObject {
    
    private var cell: MNCloudLiveCardCell!
    public lazy var collection: UICollectionView = {
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
    
    lazy var collectionStatusLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "数据载入中..."
        label.textColor = .blue
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let x = label.centerXAnchor.constraint(equalTo: collection.centerXAnchor)
        let y = label.centerYAnchor.constraint(equalTo: collection.centerYAnchor)
        NSLayoutConstraint.activate([x, y])
        return label
    }()
    
    
    
    init(_ cell: MNCloudLiveCardCell) {
        self.cell = cell
    }
    
    public func showCollectionStatusWithReady() {
        collectionStatusLabel.text = "数据载入中..."
    }
    public func setCollectionStatusWithNoData() {
        collectionStatusLabel.text = "没有更多数据了"
    }

}

extension MNCloudLiveCardCellCollectionPresenter: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = self.cell.dataSource else {
            return 0
        }
        return dataSource.subCellCounts
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleImageCollectionCell", for: indexPath) as! SingleImageCollectionCell
        cell.backgroundImage.image = self.cell.dataSource?.subImage(collectionView, forCellAt: indexPath)
        cell.recordingTime.text = self.cell.dataSource?.subTime(collectionView, forCellAt: indexPath)
        return cell
    }
    
    
}
