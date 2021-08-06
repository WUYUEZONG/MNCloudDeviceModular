//
//  MessageCellDataSource.swift
//  iOS Swift Example
//
//  Created by 蛮牛科技 on 8/6/21.
//

import UIKit
import MNCloudDeviceModular


class MessageCellDataSource: NSObject {
    
    override init() {
        super.init()
        tempData.isChild = true
    }
    
    var dataUpToDate: (([LiveCellModel])->())?
    var controlData: [LiveCellModel]!
    
    private var cachedData: [String: [LiveCellModel]] = [:]
    
    var tempData = LiveCellModel()
    var tempIndexPath: IndexPath?
    
    var datas: [LiveCellModel] = []
    
    var cell: MessageCollectionViewCell? {
        didSet {
            cell?.collection.dataSource = self
            //cell?.collection.isHidden = true
        }
    }
    
    
    
    func loadData(model: LiveCellModel) {
        cell?.holderTextLabel.text = "Loading..."
        cell?.holderTextLabel.isHidden = false
        if let data = cachedData[model.model.sn], !data.isEmpty {
            self.datas = data
            self.setViewsStatusAfterDataLoaded()
            return
        }
        
        DispatchQueue.global().async {
            sleep(2)
            self.datas = [LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel()]
            self.cachedData[model.model.sn] = self.datas
            DispatchQueue.main.async {
                self.setViewsStatusAfterDataLoaded()
            }
        }
    }
    
    func setViewsStatusAfterDataLoaded() {
        self.cell?.holderTextLabel.text = "No More Data"
        self.cell?.collection.isHidden = self.datas.isEmpty
        self.cell?.holderTextLabel.isHidden = !self.datas.isEmpty
        self.cell?.collection.reloadData()
    }
    
    func resetDefaultStatus(collection: UICollectionView) {
        guard let tempIndexPath = tempIndexPath else { return }
        self.collection(collection, deleteAt: tempIndexPath)
    }
    
    
    func showOrHide(collection: UICollectionView, cellAt indexPath: IndexPath, control data: [LiveCellModel]) {
        self.controlData = data
        var insertIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        guard let tempIndexPath = tempIndexPath else {
            return self.collection(collection, insertAtRow: insertIndexPath)
        }
        guard tempIndexPath.row != indexPath.row + 1 else {
            return self.collection(collection, deleteAt: tempIndexPath)
        }
        let row = indexPath.row < tempIndexPath.row ? indexPath.row + 1 : indexPath.row
        insertIndexPath = IndexPath(row: row, section: indexPath.section)
        self.collection(collection, deleteAt: tempIndexPath, withInsert: insertIndexPath)
    }
    
    func collection(_ collection: UICollectionView, deleteAt tempIndexPath: IndexPath, withInsert indexPath: IndexPath? = nil) {
        controlData.remove(at: tempIndexPath.row)
        dataUpToDate!(self.controlData)
        collection.performBatchUpdates {
            collection.deleteItems(at: [tempIndexPath])
        } completion: { f in
            if let indexPath = indexPath {
                self.collection(collection, insertAtRow: indexPath)
            } else {
                self.tempIndexPath = nil
            }
        }
    }
    
    
    func collection(_ collection: UICollectionView, insertAtRow indexPath: IndexPath) {
        
        self.controlData.insert(self.tempData, at: indexPath.row)
        self.dataUpToDate!(self.controlData)
        self.tempIndexPath = indexPath
        collection.performBatchUpdates {
            collection.insertItems(at: [indexPath])
        } completion: { f in
            if let last = collection.visibleCells.last,
               let lastIndexPath = collection.indexPath(for: last),
               lastIndexPath.row <= indexPath.row {
                collection.scrollToItem(at: indexPath, at: .bottom, animated: true)
            }
            self.loadData(model: self.controlData[indexPath.row - 1])
        }
        
    }
    
}


extension MessageCellDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleImageCollectionCell", for: indexPath) as! SingleImageCollectionCell
        cell.backgroundImage.image = datas[indexPath.row].image
        cell.recordingTime.text = datas[indexPath.row].time
        return cell
    }

}
