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
    var isOpen = false
    var dataCount = 0
}

class LiveCellModel: NSObject {
    
    var model = TestModel()
    convenience init(model: TestModel) {
        self.init()
        self.model = model
    }
}

extension LiveCellModel: MNCloudLiveCardCellDataSource {
    
    
    func titleFor(_ cell: MNCloudLiveCardCell, viewTagItem: LiveCardItem) -> String? {
        switch viewTagItem {
        case .name:
            return model.name
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
        model.isOpen
    }
    /// sub datas
    var subCellCounts: Int {
        model.dataCount
    }
    
    func subTime(_ collectionView: UICollectionView, forCellAt indexPath: IndexPath) -> String {
        "00:00:00"
    }
    
    func subImage(_ collectionView: UICollectionView, forCellAt indexPath: IndexPath) -> UIImage? {
        UIImage(named: "1")
    }
    
}
