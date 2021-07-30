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
    
    var dataLoadingHolder = "data is loading..."
    var isOpen = false
    var dataCount = 0
    
    convenience init(model: TestModel) {
        self.init()
        self.model = model
    }
}

extension LiveCellModel: MNCloudLiveCardCellDataSource {
    
    func isItemShouldHide(_ cell: MNCloudLiveCardCell, viewTagItem: LiveCardItem) -> Bool {
        switch viewTagItem {
        case .collection:
            return isOpen ? dataCount == 0 : true
        default:
            return false
        }
        
        
    }
    
    
    
    func titleFor(_ cell: MNCloudLiveCardCell, viewTagItem: LiveCardItem) -> String? {
        switch viewTagItem {
        case .name:
            return model.name
        case .collectionDataLoadingHolder:
            return dataLoadingHolder
        case .first:
            return "share"
        case .second:
            return "message"
        case .third:
            return "cloud"
        case .fourth:
            return "settings"
        default:
            return nil
        }
    }
    
    func imageFor(_ cell: MNCloudLiveCardCell, viewTagItem:  LiveCardItem) -> UIImage? {
        switch viewTagItem {
        case .videoHolder:
            return UIImage(named: "1")
        default:
            return UIImage(named: "sun")
        }
    }
    
    
    var isBottomViewOpen: Bool {
        isOpen
    }
    /// sub datas
    var subCellCounts: Int {
        dataCount
    }
    
    func subTime(_ collectionView: UICollectionView, forCellAt indexPath: IndexPath) -> String {
        "00:00:00"
    }
    
    func subImage(_ collectionView: UICollectionView, forCellAt indexPath: IndexPath) -> UIImage? {
        UIImage(named: "1")
    }
    
}
