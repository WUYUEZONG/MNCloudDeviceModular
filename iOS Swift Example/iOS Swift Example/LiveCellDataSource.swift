//
//  LiveCellDataSource.swift
//  iOS Swift Example
//
//  Created by 蛮牛科技 on 7/28/21.
//

import UIKit
import MNCloudDeviceModular

struct TestModel {
    var name = "this is a device name"
    var is4G = false
}

class LiveCellModel: NSObject {
    
    var model = TestModel()
    
    var loadingHoldText = "data is loading..."
    var isOpen = false
    var dataCount = 0
    
    var isChild = false
    
    var image = UIImage(named: "1")
    var time = "00:00:00"
    
    convenience init(model: TestModel) {
        self.init()
        self.model = model
    }
}

extension LiveCellModel: MNCloudLiveCardCellDataSource {
    
    func isHide(at cell: MNCloudLiveCardCell, forTaged item: LiveCardItem) -> Bool {
        switch item {
        case .collection:
            return isOpen ? dataCount == 0 : true
        default:
            return false
        }
    }
    
    
    func title(for cell: MNCloudLiveCardCell, forTaged item: LiveCardItem) -> String? {
        switch item {
        case .name:
            return model.name
        case .collectionDataLoadingHolder:
            return loadingHoldText
        case .first:
            return "share"
        case .second:
            return "message"
        case .third:
            return model.is4G ? "4G" : "cloud"
        case .fourth:
            return "settings"
        case .CPBottomTitle:
            return "Up To Date"
        case .CPBottomDetial:
            return "Upgrade"
        default:
            return nil
        }
    }
    
    func image(for cell: MNCloudLiveCardCell, forTaged item:  LiveCardItem) -> UIImage? {
        switch item {
        case .videoHolder:
            return UIImage(named: "1")
        default:
            return UIImage(named: "sun")
        }
    }
    
    
    var isBottomViewOpen: Bool {
        isOpen
    }
    
    // MARK: - sub datas -
    
    func numOfcollectionCell() -> Int {
        dataCount
    }
    
    func time(for collectionView: UICollectionView, cellAt indexPath: IndexPath) -> String {
        "00:00:00"
    }
    
    func image(for collectionView: UICollectionView, cellAt indexPath: IndexPath) -> UIImage? {
        UIImage(named: "1")
    }
}
