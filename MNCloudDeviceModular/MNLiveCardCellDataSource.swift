//
//  MNLiveCardCellDataSource.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/28/21.
//

import UIKit

public protocol MNCloudLiveCardCellDelegate: NSObjectProtocol {
    func didSelect(cell: MNCloudLiveCardCell, at item: LiveCardItem)
    func didSelect(collectionView: UICollectionView, at indexPath: IndexPath)
}

public protocol MNCloudLiveCardCellDataSource: NSObjectProtocol {
   

    var isBottomViewOpen: Bool { get }
    
    func liveCardSize(width: CGFloat) -> CGSize
    
    var subCellCounts: Int { get }
    
    func isItemShouldHide(_ cell: MNCloudLiveCardCell, viewTagItem: LiveCardItem) -> Bool
    func titleFor(_ cell: MNCloudLiveCardCell, viewTagItem: LiveCardItem) -> String?
    func imageFor(_ cell: MNCloudLiveCardCell, viewTagItem: LiveCardItem) -> UIImage?
    func subTime(_ collectionView: UICollectionView, forCellAt indexPath: IndexPath) -> String
    func subImage(_ collectionView: UICollectionView, forCellAt indexPath: IndexPath) -> UIImage?
}

extension MNCloudLiveCardCellDataSource {
    public func liveCardSize(width: CGFloat) -> CGSize {
        return isBottomViewOpen ? CGSize(width: width, height: 388) : CGSize(width: width, height: 308)
    }
}

public enum LiveCardItem: Int {
    case logo = 100
    case name = 101
    case netStatus = 102
    case first = 103
    case second = 104
    case third = 105
    case fourth = 106
    case videoHolder = 107
    case collection = 108
}
