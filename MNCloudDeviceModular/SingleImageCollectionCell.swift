//
//  SingleImageCollectionCell.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit

class SingleImageCollectionCell: UICollectionViewCell {
    
    public lazy var backgroundImage: UIImageView = {
        let bImg = UIImageView()
        bImg.clipsToBounds = true
        bImg.layer.cornerRadius = 4
        bImg.contentMode = .scaleAspectFill
        contentView.addSubview(bImg)
        bImg.translatesAutoresizingMaskIntoConstraints = false
        let leading = bImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let top = bImg.topAnchor.constraint(equalTo: contentView.topAnchor)
        let trailing = bImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let bottom = bImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        NSLayoutConstraint.activate([leading, top, trailing, bottom]);
        
        return bImg
    }()
    public lazy var recordingTime: UILabel = {
        let r = UILabel()
        r.font = .systemFont(ofSize: 10, weight: .medium)
        r.textAlignment = .right
        r.text = "00:00:00"
        contentView.addSubview(r)
        r.translatesAutoresizingMaskIntoConstraints = false
        let trailing = r.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        let bottom = r.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        
        NSLayoutConstraint.activate([trailing, bottom]);
        
        return r
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
