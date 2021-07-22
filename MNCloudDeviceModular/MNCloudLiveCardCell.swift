//
//  MNCloudLiveCardCell.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit

protocol MNCloudLiveCardCellDelegate: NSObjectProtocol {
    func didTapDeviceName(cell: MNCloudLiveCardCell)
    func didTapNetworkImage(cell: MNCloudLiveCardCell)
    func didTapShareButton(cell: MNCloudLiveCardCell)
    func didTapAlarmButton(cell: MNCloudLiveCardCell)
    func didTapCloudStoreButton(cell: MNCloudLiveCardCell)
    func didTapSettingButton(cell: MNCloudLiveCardCell)
}

public class MNCloudLiveCardCell: UICollectionViewCell {
    
    weak var delegate: MNCloudLiveCardCellDelegate?
    
    @IBOutlet weak var deviceLogo: UIImageView!
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var networkStatus: UIImageView!
    @IBOutlet weak var screenShoot: UIImageView!
    @IBOutlet weak var shareButton: UIButton! {
        didSet {
            shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var alarmButton: UIButton! {
        didSet {
            alarmButton.addTarget(self, action: #selector(alarmButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var cloudStoreButton: UIButton! {
        didSet {
            cloudStoreButton.addTarget(self, action: #selector(cloudStoreButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var settingButton: UIButton! {
        didSet {
            settingButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var bottomStack: UIStackView!
    
    @IBOutlet weak var bStackToBottomConstraint: NSLayoutConstraint!
    
    private var bCollectionToBottomConstraint: NSLayoutConstraint {
        return self.constraints.first { c in
            c.identifier == "collectionBottomToCellBottom"
        }!
    }
    
    private lazy var collectionPresenter: MNCloudLiveCardCellCollectionPresenter = {
        let p = MNCloudLiveCardCellCollectionPresenter(self)
        return p
    }()
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Delegate calls ----------
    
    @objc private func shareButtonAction() {
        delegate?.didTapShareButton(cell: self)
    }
    
    @objc private func alarmButtonAction() {
        bStackToBottomConstraint.isActive = !bStackToBottomConstraint.isActive
        bCollectionToBottomConstraint.isActive = !bCollectionToBottomConstraint.isActive
        delegate?.didTapAlarmButton(cell: self)
    }
    
    @objc private func cloudStoreButtonAction() {
        delegate?.didTapCloudStoreButton(cell: self)
    }
    
    @objc private func settingsButtonAction() {
        delegate?.didTapSettingButton(cell: self)
    }

}
