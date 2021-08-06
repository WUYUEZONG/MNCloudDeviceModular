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
        let itemSpace: CGFloat = 10
        l.itemSize = CGSize(width: 120, height: cell.collectionHeight - (itemSpace * 2))
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = itemSpace
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.dataSource = self
        c.tag = LiveCardItem.collection.rawValue
        c.backgroundColor = .white
        c.contentInset = UIEdgeInsets(top: itemSpace, left: itemSpace, bottom: itemSpace, right: itemSpace)
        c.register(SingleImageCollectionCell.self, forCellWithReuseIdentifier: "SingleImageCollectionCell")
        cell.contentStack.addArrangedSubview(c)
        let h = c.heightAnchor.constraint(equalToConstant: cell.collectionHeight)
        NSLayoutConstraint.activate([h])

        c.isHidden = true
        return c
        
        
    }()
    
    lazy var collectionStatusLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        //label.text = "数据载入中..."
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
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
    

}

extension MNCloudLiveCardCellCollectionPresenter: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = cell.dataSource else {
            return 0
        }
//        debugPrint("collection count is \(dataSource.numOfcollectionCell())")
        return 0//dataSource.numOfcollectionCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleImageCollectionCell", for: indexPath) as! SingleImageCollectionCell
//        cell.backgroundImage.image = self.cell.dataSource?.image(for: collectionView, cellAt: indexPath)
//        cell.recordingTime.text = self.cell.dataSource?.time(for: collectionView, cellAt: indexPath)
        return cell
    }
    
    
}
