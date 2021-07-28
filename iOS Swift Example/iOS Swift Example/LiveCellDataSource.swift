//
//  LiveCellDataSource.swift
//  iOS Swift Example
//
//  Created by 蛮牛科技 on 7/28/21.
//

import UIKit
import MNCloudDeviceModular

struct TestModel {
    var is4G = false
    var isOpen = false
}

class LiveCellModel: NSObject {
    var model = TestModel()
    convenience init(model: TestModel) {
        self.init()
        self.model = model
    }
}

extension LiveCellModel: MNCloudLiveCardCellDataSource {    
    
    var logo: UIImage? {
        UIImage(named: "sun")
    }
    
    var name: String {
        return "Fisrt Devixxe"
    }
    
    var networkStatus: UIImage? {
        UIImage(named: "sun")
    }
    
    var videoHoler: UIImage? {
        UIImage(named: "1")
    }
    
    var bottomFirstImage: UIImage? {
        UIImage(named: "sun")
    }
    
    var bottomFirstTitle: String {
        "Share"
    }
    
    var bottomSecondImage: UIImage? {
        UIImage(named: "sun")
    }
    
    var bottomSecondTitle: String {
        "Message"
    }
    
    var bottomThirdImage: UIImage? {
        UIImage(named: "sun")
    }
    
    var bottomThirdTitle: String {
        return model.is4G ? "4G" : "Cloud"
    }
    
    var bottomFourthImage: UIImage? {
        UIImage(named: "sun")
    }
    
    var bottomFourthTitle: String {
        "settings"
    }
    
    var isBottomViewOpen: Bool {
        model.isOpen
    }
    
    
}
