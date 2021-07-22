//
//  SingleImageCollectionCell.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit

class SingleImageCollectionCell: UICollectionViewCell {
    
    lazy var backgroundImage: UIImageView = {
        let bImg = UIImageView()
        bImg.contentMode = .scaleAspectFill
        addSubview(bImg)
        bImg.translatesAutoresizingMaskIntoConstraints = false
        let leading = bImg.leadingAnchor.constraint(equalTo: leadingAnchor)
        let top = bImg.topAnchor.constraint(equalTo: topAnchor)
        let trailing = bImg.trailingAnchor.constraint(equalTo: trailingAnchor)
        let bottom = bImg.bottomAnchor.constraint(equalTo: bottomAnchor)
        return bImg
    }()
    lazy var recordingTime: UILabel = {
        let r = UILabel()
        r.font = .systemFont(ofSize: 12, weight: .medium)
        r.textAlignment = .right
        addSubview(r)
        r.translatesAutoresizingMaskIntoConstraints = false
        let trailing = r.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        let bottom = r.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        return r
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
