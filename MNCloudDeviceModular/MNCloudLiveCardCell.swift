//
//  MNCloudLiveCardCell.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit

public class TestModel: NSObject {
    var isOpen = false
    var bb: NSLayoutConstraint!
    var cb: NSLayoutConstraint!
}

public protocol MNCloudLiveCardCellDelegate: NSObjectProtocol {
    func didTapDeviceName(cell: MNCloudLiveCardCell)
    func didTapNetworkImage(cell: MNCloudLiveCardCell)
    func didTapShareButton(cell: MNCloudLiveCardCell)
    func didTapAlarmButton(cell: MNCloudLiveCardCell)
    func didTapCloudStoreButton(cell: MNCloudLiveCardCell)
    func didTapSettingButton(cell: MNCloudLiveCardCell)
}

public class MNCloudLiveCardCell: UICollectionViewCell {
    
    public var model = TestModel() {
        didSet {
            if model.bb == nil {
                model.bb = bb
            }
            if model.cb == nil {
                model.cb = cb
            }
            model.bb.isActive = !model.isOpen
            model.cb.isActive = model.isOpen
            collectionPresenter.collection.isHidden = !model.isOpen
            alarmButton.isSelected = model.isOpen
        }
    }
    
    public weak var delegate: MNCloudLiveCardCellDelegate?
    
    public lazy var topStack: UIStackView = {
        deviceLogo.setContentHuggingPriority(UILayoutPriority(700), for: .horizontal)
        deviceLogo.setContentCompressionResistancePriority(UILayoutPriority(700), for: .horizontal)
        deviceName.setContentHuggingPriority(UILayoutPriority(600), for: .horizontal)
        deviceName.setContentCompressionResistancePriority(UILayoutPriority(600), for: .horizontal)
        networkStatus.setContentHuggingPriority(UILayoutPriority(650), for: .horizontal)
        networkStatus.setContentCompressionResistancePriority(UILayoutPriority(650), for: .horizontal)
        let t = UIStackView(arrangedSubviews: [deviceLogo, deviceName, networkStatus])
        t.axis = .horizontal
        contentView.addSubview(t)
        t.translatesAutoresizingMaskIntoConstraints = false
        let leading = t.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        let top = t.topAnchor.constraint(equalTo: contentView.topAnchor)
        let trailing = t.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10)
        let h = t.heightAnchor.constraint(equalToConstant: 48)
        NSLayoutConstraint.activate([leading, top, trailing, h])
        return t
    }()
    
    public lazy var screenShoot: UIImageView = {
        let s = UIImageView()
        s.contentMode = .scaleAspectFill
        contentView.addSubview(s)
        s.translatesAutoresizingMaskIntoConstraints = false
        let leading = s.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let top = s.topAnchor.constraint(equalTo: topStack.bottomAnchor)
        let trailing = s.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let h = s.heightAnchor.constraint(equalToConstant: 200)
        let w = s.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        NSLayoutConstraint.activate([leading, top, trailing, h, w])
        return s
    }()
    
    public lazy var bottomStack: UIStackView = {
        let b = UIStackView(arrangedSubviews: [shareButton, alarmButton, cloudStoreButton, settingButton])
        b.axis = .horizontal
        b.alignment = .fill
        b.distribution = .fillEqually
        contentView.addSubview(b)
        b.translatesAutoresizingMaskIntoConstraints = false
        let h = b.heightAnchor.constraint(equalToConstant: 60)
        let leading = b.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = b.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let top = b.topAnchor.constraint(equalTo: screenShoot.bottomAnchor)
        bb = b.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([h, leading, trailing, top, bb])
        return b
    }()
    
    var bb: NSLayoutConstraint!
    var cb: NSLayoutConstraint!
    
    public lazy var deviceLogo: UIButton = {
        let d = UIButton(type: .system)
        d.setTitle("0000", for: .normal)
        d.setImage(UIImage(named: "MNCloudDeviceModular.framework/holder"), for: .normal)
        return d
    }()
    public lazy var deviceName: UIButton = {
        let d = UIButton(type: .system)
        d.titleLabel?.font = .systemFont(ofSize: 18)
        d.setTitle("DeviceName", for: .normal)
        return d
    }()
    public lazy var networkStatus: UIButton = {
        let n = UIButton(type: .system)
        n.setImage(UIImage(named: "MNCloudDeviceModular.framework/holder"), for: .normal)
        return n
    }()
    
    public lazy var shareButton: UIButton = {
        let s = UIButton(type: .system)
        s.titleLabel?.font = .systemFont(ofSize: 18)
        s.setTitle("1111", for: .normal)
        s.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        return s
    }()
    public lazy var alarmButton: UIButton = {
        let a = UIButton(type: .system)
        a.titleLabel?.font = .systemFont(ofSize: 18)
        a.setTitle("2222", for: .normal)
        a.addTarget(self, action: #selector(alarmButtonAction(sender:)), for: .touchUpInside)
        return a
    }()
    public lazy var cloudStoreButton: UIButton = {
        let c = UIButton(type: .system)
        c.titleLabel?.font = .systemFont(ofSize: 18)
        c.setTitle("333", for: .normal)
        c.addTarget(self, action: #selector(cloudStoreButtonAction), for: .touchUpInside)
        return c
    }()
    public lazy var settingButton: UIButton = {
        let s = UIButton(type: .custom)
        s.titleLabel?.font = .systemFont(ofSize: 18)
        s.setTitle("4444", for: .normal)
        s.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        return s
    }()
    
    
    
    
    private lazy var collectionPresenter: MNCloudLiveCardCellCollectionPresenter = {
        let p = MNCloudLiveCardCellCollectionPresenter(self)
        let _ = p.collection
        return p
    }()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    func initUI() {
        contentView.backgroundColor = .gray
//        let w = bottomStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
//        NSLayoutConstraint.activate([w])
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.deactivate(self.constraints)
        
        let _ = bottomStack
        let _ = collectionPresenter
        
    }
    
    
    // MARK: - Delegate calls ----------
    
    @objc private func shareButtonAction() {
        delegate?.didTapShareButton(cell: self)
    }
    
    @objc private func alarmButtonAction(sender: UIButton) {
        model.isOpen = !model.isOpen
        delegate?.didTapAlarmButton(cell: self)
    }
    
    @objc private func cloudStoreButtonAction() {
        delegate?.didTapCloudStoreButton(cell: self)
    }
    
    @objc private func settingsButtonAction() {
        delegate?.didTapSettingButton(cell: self)
    }

}
