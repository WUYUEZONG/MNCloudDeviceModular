//
//  MNLiveCardCellDataSource.swift
//  MNCloudDeviceModular
//
//  Created by 蛮牛科技 on 7/28/21.
//

import UIKit

public protocol MNCloudLiveCardCellDelegate: NSObjectProtocol {
    func didSelect(cell: MNCloudLiveCardCell, at item: LiveCardItem)
}

public protocol MNCloudLiveCardCellDataSource: NSObjectProtocol {
   
    var logo: UIImage? { get }
    var name: String { get }
    var networkStatus: UIImage? { get }
    var videoHoler: UIImage? { get }
    var bottomFirstImage: UIImage? { get }
    var bottomFirstTitle: String { get }
    var bottomSecondImage: UIImage? { get }
    var bottomSecondTitle: String { get }
    var bottomThirdImage: UIImage? { get }
    var bottomThirdTitle: String { get }
    var bottomFourthImage: UIImage? { get }
    var bottomFourthTitle: String { get }
    
    var isBottomViewOpen: Bool { get }
    
    func liveCardSize(width: CGFloat) -> CGSize
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
}
