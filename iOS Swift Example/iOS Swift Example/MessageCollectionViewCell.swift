//
//  MessageCollectionViewCell.swift
//  iOS Swift Example
//
//  Created by 蛮牛科技 on 8/6/21.
//

import UIKit
import MNCloudDeviceModular

class MessageCollectionViewCell: UICollectionViewCell {
    
    lazy var layout: UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 120, height: 80)
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = 10
        return l
    }()
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var holderTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collection.setCollectionViewLayout(layout, animated: false)
        collection.register(SingleImageCollectionCell.self, forCellWithReuseIdentifier: "SingleImageCollectionCell")
    }

}
