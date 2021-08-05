//
//  MNLiveCardCellDataSource.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/28/21.
//

import UIKit

public protocol MNCloudLiveCardCellDelegate: NSObjectProtocol {

    /// the method will call when you did tap at any button of cell.
    /// If you want custom add an item, please use the tag.
    /// Once you custom a view, set tag at least from 111.
    ///
    /// - Parameters:
    ///     - cell: `MNCloudLiveCardCell`
    ///     - item: a kind of `LiveCardItem`
    ///     - tag: the button tag, or your custom tag.
    ///
    func didSelect(cell: MNCloudLiveCardCell, at item: LiveCardItem?, with tag: Int)
    func didSelect(collectionView: UICollectionView, at indexPath: IndexPath)
}

public protocol MNCloudLiveCardCellDataSource: NSObjectProtocol {
   

    var isBottomViewOpen: Bool { get }
    
    func liveCardSize(width: CGFloat) -> CGSize
    
    /// number of cell for bottom collection
    func numOfcollectionCell() -> Int
    /**
     Hidden control of `LiveCardItem`
     - Parameters:
        - cell: `MNCloudLiveCardCell`
        - item: view of `MNCloudLiveCardCell` taged by `LiveCardItem`
     */
    func isHide(at cell: MNCloudLiveCardCell, forTaged item: LiveCardItem) -> Bool
    /**
     title of `LiveCardItem`
     - Parameters:
        - cell: `MNCloudLiveCardCell`
        - item: view of `MNCloudLiveCardCell` taged by `LiveCardItem`
     */
    func title(for cell: MNCloudLiveCardCell, forTaged item: LiveCardItem) -> String?
    /**
     image of `LiveCardItem`
     - Parameters:
        - cell: `MNCloudLiveCardCell`
        - item: view of `MNCloudLiveCardCell` taged by `LiveCardItem`
     */
    func image(for cell: MNCloudLiveCardCell, forTaged item: LiveCardItem) -> UIImage?
    func time(for collectionView: UICollectionView, cellAt indexPath: IndexPath) -> String
    func image(for collectionView: UICollectionView, cellAt indexPath: IndexPath) -> UIImage?
}

extension MNCloudLiveCardCellDataSource {
    public func liveCardSize(width: CGFloat) -> CGSize {
        return isBottomViewOpen ? CGSize(width: width, height: 388) : CGSize(width: width, height: 308)
    }
}

public enum LiveCardItem: Int {
    /// LiveCardCell's top-left icon
    case logo = 100
    /// LiveCardCell's top-middle icon
    case name = 101
    /// LiveCardCell's top-right last icon
    case netStatus = 102
    /// LiveCardCell's bottom-first icon
    case first = 103
    /// LiveCardCell's bottom-second icon
    case second = 104
    /// LiveCardCell's bottom-third icon
    case third = 105
    /// LiveCardCell's bottom-fourth icon
    case fourth = 106
    /// LiveCardCell's center image
    case videoHolder = 107
    /// LiveCardCell's bottom-collection icon
    case collection = 108
    /// LiveCardCell's bottom-collection loadingHolder icon
    case collectionDataLoadingHolder = 109
    /// LiveCardCell's top-right second icon
    case lockStatus = 110
    /// LiveCardCell's Center Presenter second icon
    case CPBottomTitle = 111
    case CPBottomDetial = 112
    case CPBottomClose = 113
}
