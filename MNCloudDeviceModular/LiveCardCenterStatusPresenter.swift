//
//  LiveCardCenterStatusPresenter.swift
//  MNCloudDeviceModular
//
//  Created by WUYUEZONG on 2021/8/4.
//

import UIKit

class LiveCardCenterStatusPresenter: NSObject {
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = LiveCardItem.CPBottomClose.rawValue
        button.addTarget(cell, action: #selector(MNCloudLiveCardCell().itemsActions(sender:)), for: .touchUpInside)
        backgroundView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let width = button.widthAnchor.constraint(equalToConstant: 30)
        let height = button.heightAnchor.constraint(equalToConstant: 30)
        let top = button.topAnchor.constraint(equalTo: backgroundView.topAnchor)
        let trailing = button.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        NSLayoutConstraint.activate([width, height, top, trailing])
        return button
    }()
    
    lazy var detailButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.tag = LiveCardItem.CPBottomDetial.rawValue
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        button.setTitle("do something", for: .normal)
        button.addTarget(cell, action: #selector(MNCloudLiveCardCell().itemsActions(sender:)), for: .touchUpInside)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        backgroundStack.addArrangedSubview(button)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "TITLE"
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        backgroundStack.insertArrangedSubview(label, at: 0)
        return label
    }()
    
    lazy var backgroundStack: UIStackView = {
        let stack = UIStackView()
        backgroundView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        let leading = stack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16)
        let trailing = stack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -40)
        let top = stack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10)
        let bottom = stack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
        return stack
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        cell.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false;
        let leading = view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor)
        let trailing = view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
        let bottom = view.bottomAnchor.constraint(equalTo: cell.screenShoot.bottomAnchor)
        let height = view.heightAnchor.constraint(equalToConstant: 48)
        NSLayoutConstraint.activate([leading, trailing, bottom, height])
        return view
    }()
    
    private var cell: MNCloudLiveCardCell!
    
    init(cell: MNCloudLiveCardCell) {
        self.cell = cell
    }
}
