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
    
    var tempData = LiveCellModel()
    var tempIndexPath: IndexPath?
    
    var datas: [LiveCellModel] = []
    
    var cell: MessageCollectionViewCell? {
        didSet {
            cell?.collection.dataSource = self
            cell?.collection.isHidden = true
        }
    }
    
    
    func loadData(complete:@escaping ()->()) {
        cell?.holderTextLabel.text = "Loading..."
        cell?.holderTextLabel.isHidden = false
        
        DispatchQueue.global().async {
            sleep(2)
            self.datas = [LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel()]
            DispatchQueue.main.async {
                complete()
                self.cell?.holderTextLabel.text = "No More Data"
                self.cell?.collection.isHidden = self.datas.isEmpty
                self.cell?.holderTextLabel.isHidden = !self.datas.isEmpty
                self.cell?.collection.reloadData()
            }
        }
    }
    
    
    func showOrHide(collection: UICollectionView, cellAt indexPath: IndexPath, control data: inout [[LiveCellModel]]) {
        
        let insertIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        guard let tempIndexPath = tempIndexPath else {
            return self.collection(collection, control: &data, insertAtRow: insertIndexPath)
        }
        guard tempIndexPath.section != indexPath.section else {
            return self.collection(collection, control: &data, deleteAt: tempIndexPath)
        }
        self.collection(collection, control: &data, deleteAt: tempIndexPath, withInsert: indexPath)
    }
    
    func collection(_ collection: UICollectionView, control data: inout [[LiveCellModel]], deleteAt tempIndexPath: IndexPath, withInsert indexPath: IndexPath? = nil) {
        collection.performBatchUpdates {
            data[tempIndexPath.section].removeLast()
            collection.deleteItems(at: [tempIndexPath])
        } completion: { f in
            if let indexPath = indexPath {
                self.collection(collection, control: &data, insertAtRow: indexPath)
            } else {
                self.tempIndexPath = nil
            }
        }
    }
    
    
    func collection(_ collection: UICollectionView, control data: inout [[LiveCellModel]], insertAtRow indexPath: IndexPath) {
        
        collection.performBatchUpdates {
            var sectionData = data[indexPath.section]
            sectionData.append(self.tempData)
            data[indexPath.section] = sectionData
            self.tempIndexPath = indexPath
            collection.insertItems(at: [indexPath])
        } completion: { f in
            collection.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            self.loadData {
            }
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
