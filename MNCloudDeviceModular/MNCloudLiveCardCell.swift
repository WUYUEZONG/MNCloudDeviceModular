//
//  MNCloudLiveCardCell.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/22/21.
//

import UIKit



public class MNCloudLiveCardCell: UICollectionViewCell {
    
    // MARK: - public func -
    
    public func showCollectionReadyToLoading() {
        collectionPresenter.collectionStatusLabel.text = "正在载入数据..."
    }
    public func setCollectionNoDataIfNeed() {
        guard let dataSource = dataSource, dataSource.subCellCounts == 0  else { return }
        collectionPresenter.collectionStatusLabel.text = "没有任何数据"
    }
    
    public func reloadCellCollection() {
        collectionPresenter.collection.reloadData()
    }
    
    // MARK: - public var -
    
    public weak var delegate: MNCloudLiveCardCellDelegate?
    public weak var dataSource: MNCloudLiveCardCellDataSource? {
        didSet {
            guard let dataSource = dataSource else { return }
            debugPrint("set dataSource counts is ", dataSource.subCellCounts)
            logo.setImage(dataSource.imageFor(self, viewTagItem: .logo), for: .normal)
            name.setTitle(dataSource.titleFor(self, viewTagItem: .name), for: .normal)
            networkStatus.setImage(dataSource.imageFor(self, viewTagItem: .netStatus), for: .normal)
            screenShoot.image = dataSource.imageFor(self, viewTagItem: .videoHolder)
            setTitleImageForButton(shareButton, dataSource: dataSource)
            setTitleImageForButton(alarmButton, dataSource: dataSource)
            setTitleImageForButton(cloudStoreButton, dataSource: dataSource)
            setTitleImageForButton(settingButton, dataSource: dataSource)
            collectionPresenter.collection.isHidden = dataSource.isItemShouldHide(self, viewTagItem: .collection)
            shareButton.isHidden = dataSource.isItemShouldHide(self, viewTagItem: .first)
            collectionPresenter.collectionStatusLabel.isHidden = !dataSource.isBottomViewOpen || dataSource.subCellCounts > 0
            setButtons()
        }
    }
    
    
    private func setTitleImageForButton(_ button: UIButton, dataSource: MNCloudLiveCardCellDataSource) {
        button.setTitle(dataSource.titleFor(self, viewTagItem: LiveCardItem(rawValue: button.tag)!), for: .normal)
        button.setImage(dataSource.imageFor(self, viewTagItem: LiveCardItem(rawValue: button.tag)!), for: .normal)
    }
    
    // MARK: - self.subviews start -
    
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
    
    public lazy var topStack: UIStackView = {
        let t = UIStackView(arrangedSubviews: [logo, name, networkStatus])
        t.axis = .horizontal
        let h = t.heightAnchor.constraint(equalToConstant: 48)
        NSLayoutConstraint.activate([h])
        return t
    }()
    
    public lazy var screenShoot: UIImageView = {
        let s = UIImageView()
        s.tag = LiveCardItem.videoHolder.rawValue
        s.contentMode = .scaleAspectFill
        s.clipsToBounds = true
        let h = s.heightAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([h])
        return s
    }()
    
    public lazy var bottomStack: UIStackView = {
        let b = UIStackView(arrangedSubviews: [shareButton, alarmButton, cloudStoreButton, settingButton])
        b.axis = .horizontal
        b.alignment = .fill
        b.distribution = .fillEqually
        let h = b.heightAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([h])
        return b
    }()
    
    
    public lazy var logo: UIButton = {
        let d = UIButton(type: .custom)
        d.imageView?.contentMode = .scaleAspectFit
        d.tag = LiveCardItem.logo.rawValue
        d.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        d.translatesAutoresizingMaskIntoConstraints = false
        let width = d.widthAnchor.constraint(equalToConstant: 36)
        NSLayoutConstraint.activate([width])
        return d
    }()
    public lazy var name: UIButton = {
        let d = UIButton(type: .system)
        d.tag = LiveCardItem.name.rawValue
        d.titleLabel?.font = .systemFont(ofSize: 18)
        d.titleLabel?.textAlignment = .left
        d.tintColor = .black
        d.contentHorizontalAlignment = .left
        d.addTarget(self, action: #selector(itemsActions(sender:)), for: .touchUpInside)
        return d
    }()
    public lazy var networkStatus: UIButton = {
        let n = UIButton(type: .custom)
        n.tag = LiveCardItem.netStatus.rawValue
        n.imageView?.contentMode = .scaleAspectFit
        n.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        n.addTarget(self, action: #selector(itemsActions(sender:)), for: .touchUpInside)
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
