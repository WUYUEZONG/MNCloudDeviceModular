//
//  MNCloudLiveCardCell.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit



public class MNCloudLiveCardCell: UICollectionViewCell {
    
    // MARK: - public func -
    
    
    // MARK: - public var -
    
    public weak var delegate: MNCloudLiveCardCellDelegate?
    public weak var dataSource: MNCloudLiveCardCellDataSource? {
        didSet {
            guard let dataSource = dataSource else { return }
            logo.setImage(dataSource.image(for: self, forTaged: .logo), for: .normal)
            name.setTitle(dataSource.title(for: self, forTaged: .name), for: .normal)
            networkStatus.setImage(dataSource.image(for: self, forTaged: .netStatus), for: .normal)
            screenShoot.image = dataSource.image(for: self, forTaged: .videoHolder)
            setTitleImageFor(shareButton, with: dataSource)
            setTitleImageFor(alarmButton, with: dataSource)
            setTitleImageFor(cloudStoreButton, with: dataSource)
            setTitleImageFor(settingButton, with: dataSource)
            let collectionIsHiden = dataSource.isHide(at: self, forTaged: .collection)
            collectionPresenter.collection.isHidden = collectionIsHiden
            collectionPresenter.collection.alpha = 0
            if !collectionIsHiden {
                // 添加动画使得显示更加自然
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                    UIView.animate(withDuration: 1.2) {
                        self.collectionPresenter.collection.alpha = 1
                    }
                }
            }
            shareButton.isHidden = dataSource.isHide(at: self, forTaged: .first)
            collectionPresenter.collectionStatusLabel.isHidden = !dataSource.isBottomViewOpen || dataSource.numOfcollectionCell() > 0
            collectionPresenter.collectionStatusLabel.text = dataSource.title(for: self, forTaged: .collectionDataLoadingHolder)
            collectionPresenter.collection.reloadData()
            setButtons()
        }
    }
    
    
    private func setTitleImageFor(_ button: UIButton, with dataSource: MNCloudLiveCardCellDataSource) {
        button.setTitle(dataSource.title(for: self, forTaged: LiveCardItem(rawValue: button.tag)!), for: .normal)
        button.setImage(dataSource.image(for: self, forTaged: LiveCardItem(rawValue: button.tag)!), for: .normal)
    }
    
    // MARK: - self.subviews start -
    
    let topStackHeight: CGFloat = 48
    let screenShootHeight: CGFloat = 200
    let bottomStackHeight: CGFloat = 60
    let collectionHeight: CGFloat = 80
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topStack, screenShoot, bottomStack])
        stack.axis = .vertical
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        let leading = stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let top = stack.topAnchor.constraint(equalTo: contentView.topAnchor)
        let trailing = stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        NSLayoutConstraint.activate([leading, top, trailing])
        return stack
    }()
    
    lazy var topStack: UIStackView = {
        let t = UIStackView(arrangedSubviews: [logo, name, networkStatus])
        t.axis = .horizontal
        let h = t.heightAnchor.constraint(equalToConstant: topStackHeight)
        NSLayoutConstraint.activate([h])
        return t
    }()
    
    lazy var screenShoot: UIImageView = {
        let s = UIImageView()
        s.tag = LiveCardItem.videoHolder.rawValue
        s.contentMode = .scaleAspectFill
        s.clipsToBounds = true
        let h = s.heightAnchor.constraint(equalToConstant: screenShootHeight)
        NSLayoutConstraint.activate([h])
        return s
    }()
    
    lazy var bottomStack: UIStackView = {
        let b = UIStackView(arrangedSubviews: [shareButton, alarmButton, cloudStoreButton, settingButton])
        b.axis = .horizontal
        b.alignment = .fill
        b.distribution = .fillEqually
        let h = b.heightAnchor.constraint(equalToConstant: bottomStackHeight)
        NSLayoutConstraint.activate([h])
        return b
    }()
    
    
    lazy var logo: UIButton = {
        let d = UIButton(type: .custom)
        d.imageView?.contentMode = .scaleAspectFit
        d.tag = LiveCardItem.logo.rawValue
        d.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        d.translatesAutoresizingMaskIntoConstraints = false
        let width = d.widthAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([width])
        return d
    }()
    lazy var name: UIButton = {
        let d = UIButton(type: .system)
        d.tag = LiveCardItem.name.rawValue
        d.titleLabel?.text = "name"
        d.titleLabel?.font = .systemFont(ofSize: 18)
        d.titleLabel?.textAlignment = .left
        d.tintColor = .black
        d.contentHorizontalAlignment = .left
        d.addTarget(self, action: #selector(itemsActions(sender:)), for: .touchUpInside)
        return d
    }()
    lazy var lockStatus: UIButton = {
        let n = UIButton(type: .custom)
        n.tag = LiveCardItem.lockStatus.rawValue
        n.imageView?.contentMode = .scaleAspectFit
        n.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        n.addTarget(self, action: #selector(itemsActions(sender:)), for: .touchUpInside)
        n.translatesAutoresizingMaskIntoConstraints = false
        let width = n.widthAnchor.constraint(equalToConstant: 36)
        NSLayoutConstraint.activate([width])
        return n
    }()
    lazy var networkStatus: UIButton = {
        return topStackRightItem(.netStatus)
    }()
    
    func topStackRightItem(_ tag: LiveCardItem) -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = tag.rawValue
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        button.addTarget(self, action: #selector(itemsActions(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        let width = button.widthAnchor.constraint(equalToConstant: 36)
        NSLayoutConstraint.activate([width])
        return button
    }
    
    lazy var shareButton: UIButton = {
        return defaultFootButton(with: "Share", itemTag: .first)
    }()
    lazy var alarmButton: UIButton = {
        return defaultFootButton(with: "Message", itemTag: .second)
    }()
    lazy var cloudStoreButton: UIButton = {
        return defaultFootButton(with: "Cloud", itemTag: .third)
    }()
    lazy var settingButton: UIButton = {
        return defaultFootButton(with: "Settings", itemTag: .fourth)
    }()
    
    lazy var collectionPresenter: MNCloudLiveCardCellCollectionPresenter = {
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
    
    // MARK: - self.subviews end : init views -
    
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
        let _ = contentStack
        let _ = collectionPresenter
        logo.backgroundColor = contentView.backgroundColor
        name.backgroundColor = contentView.backgroundColor
        networkStatus.backgroundColor = contentView.backgroundColor
        shareButton.backgroundColor = contentView.backgroundColor
        alarmButton.backgroundColor = contentView.backgroundColor
        cloudStoreButton.backgroundColor = contentView.backgroundColor
        settingButton.backgroundColor = contentView.backgroundColor
        contentView.layer.cornerRadius = 8
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
    
    private func setButtonPosition(btn: UIButton) {
        guard let imageView = btn.imageView, let titleLabel = btn.titleLabel else {
            return
        }
        
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: titleLabel.frame.height, right: -titleLabel.frame.width)
        btn.titleEdgeInsets = UIEdgeInsets(top: imageView.frame.height, left: -imageView.frame.width, bottom: 0, right: 0)
    }
    
    
    // MARK: - Delegate calls -
    
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
