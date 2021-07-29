//
//  MNCloudLiveCardCell.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit



public class MNCloudLiveCardCell: UICollectionViewCell {
    
    
    public weak var delegate: MNCloudLiveCardCellDelegate?
    public weak var dataSource: MNCloudLiveCardCellDataSource? {
        didSet {
            guard let dataSource = dataSource else { return }
            deviceLogo.setImage(dataSource.logo, for: .normal)
            deviceName.setTitle(dataSource.name, for: .normal)
            networkStatus.setImage(dataSource.networkStatus, for: .normal)
            screenShoot.image = dataSource.videoHoler
            shareButton.setImage(dataSource.bottomFirstImage, for: .normal)
            shareButton.setTitle(dataSource.bottomFirstTitle, for: .normal)
            alarmButton.setImage(dataSource.bottomSecondImage, for: .normal)
            alarmButton.setTitle(dataSource.bottomSecondTitle, for: .normal)
            cloudStoreButton.setImage(dataSource.bottomThirdImage, for: .normal)
            cloudStoreButton.setTitle(dataSource.bottomThirdTitle, for: .normal)
            settingButton.setImage(dataSource.bottomFourthImage, for: .normal)
            settingButton.setTitle(dataSource.bottomFourthTitle, for: .normal)
            collectionPresenter.collection.isHidden = !dataSource.isBottomViewOpen
            setButtons()
        }
    }
    
    public lazy var topStack: UIStackView = {
        let t = UIStackView(arrangedSubviews: [deviceLogo, deviceName, networkStatus])
        t.axis = .horizontal
        contentView.addSubview(t)
        t.translatesAutoresizingMaskIntoConstraints = false
        let leading = t.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        let top = t.topAnchor.constraint(equalTo: contentView.topAnchor)
        let trailing = t.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        let h = t.heightAnchor.constraint(equalToConstant: 48)
        NSLayoutConstraint.activate([leading, top, trailing, h])
        return t
    }()
    
    public lazy var screenShoot: UIImageView = {
        let s = UIImageView()
        s.contentMode = .scaleAspectFill
        s.clipsToBounds = true
        contentView.addSubview(s)
        s.translatesAutoresizingMaskIntoConstraints = false
        let leading = s.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let top = s.topAnchor.constraint(equalTo: topStack.bottomAnchor)
        let trailing = s.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let h = s.heightAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([leading, top, trailing, h])
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
        NSLayoutConstraint.activate([h, leading, trailing, top])
        return b
    }()
    
    
    public lazy var deviceLogo: UIButton = {
        let d = UIButton(type: .custom)
        d.imageView?.contentMode = .scaleAspectFit
        d.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        d.translatesAutoresizingMaskIntoConstraints = false
        let width = d.widthAnchor.constraint(equalToConstant: 36)
        NSLayoutConstraint.activate([width])
        return d
    }()
    public lazy var deviceName: UIButton = {
        let d = UIButton(type: .system)
        d.titleLabel?.font = .systemFont(ofSize: 18)
        d.titleLabel?.textAlignment = .left
        d.tintColor = .black
        d.contentHorizontalAlignment = .left
        d.setTitle("DeviceName", for: .normal)
        return d
    }()
    public lazy var networkStatus: UIButton = {
        let n = UIButton(type: .custom)
        n.imageView?.contentMode = .scaleAspectFit
        n.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        n.translatesAutoresizingMaskIntoConstraints = false
        let width = n.widthAnchor.constraint(equalToConstant: 36)
        NSLayoutConstraint.activate([width])
        return n
    }()
    
    public lazy var shareButton: UIButton = {
        return defaultFootButton(with: "Share", itemTag: .first)
    }()
    public lazy var alarmButton: UIButton = {
        return defaultFootButton(with: "Message", itemTag: .second)
    }()
    public lazy var cloudStoreButton: UIButton = {
        return defaultFootButton(with: "Cloud", itemTag: .third)
    }()
    public lazy var settingButton: UIButton = {
        return defaultFootButton(with: "Settings", itemTag: .fourth)
    }()
    
    private lazy var collectionPresenter: MNCloudLiveCardCellCollectionPresenter = {
        let p = MNCloudLiveCardCellCollectionPresenter(self)
        p.collection.delegate = self
        return p
    }()
    
    private func defaultFootButton(with title: String, imageName: String = "sun", fontSize: CGFloat = 12, itemTag: LiveCardItem) -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = .systemFont(ofSize: fontSize)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setTitle(title, for: .normal)
        button.tag = itemTag.rawValue
        button.addTarget(self, action: #selector(itemsActions(sender:)), for: .touchUpInside)
        return button
    }
    
    private func setButtonPosition(btn: UIButton) {
        guard let imageView = btn.imageView, let titleLabel = btn.titleLabel else {
            return
        }
        
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: titleLabel.frame.height, right: -titleLabel.frame.width)
        btn.titleEdgeInsets = UIEdgeInsets(top: imageView.frame.height, left: -imageView.frame.width, bottom: 0, right: 0)
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    func initUI() {
        contentView.backgroundColor = .lightGray
        let _ = bottomStack
        let _ = collectionPresenter
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        setButtons()
    }
    
    func setButtons() {
        setButtonPosition(btn: shareButton)
        setButtonPosition(btn: alarmButton)
        setButtonPosition(btn: cloudStoreButton)
        setButtonPosition(btn: settingButton)
    }
    
    
    // MARK: - Delegate calls ----------
    
    @objc private func itemsActions(sender: UIButton) {
        let item = LiveCardItem(rawValue: sender.tag)!
        delegate?.didSelect(cell: self, at: item)
    }
    

}


extension MNCloudLiveCardCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(collectionView: collectionView, at: indexPath)
    }
}
