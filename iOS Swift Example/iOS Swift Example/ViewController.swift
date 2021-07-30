//
//  ViewController.swift
//  iOS Swift Example
//
//  Created by 蛮牛科技 on 7/21/21.
//

import UIKit
import MNCloudDeviceModular

class ViewController: UIViewController {

    lazy var data: [LiveCellModel] = {
        
        return [LiveCellModel(model: TestModel(name: "1", is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(name: "ZHji999999999ZHji999999999ZHji999999999", is4G: true))/*, LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true))*/]
    }()
    
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            
            let l = UICollectionViewFlowLayout()
            l.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 308)
            l.minimumLineSpacing = 12
            l.scrollDirection = .vertical
            collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            collection.backgroundColor = .systemBlue
            collection.setCollectionViewLayout(l, animated: false)
            collection.register(MNCloudLiveCardCell.self, forCellWithReuseIdentifier: "MNCloudLiveCardCell")
            collection.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:))))
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }
    
    @objc func longPressAction(_ press: UILongPressGestureRecognizer) {
        // 获取长按点
        let point = press.location(in: press.view)
        
        if #available(iOS 9, *) {
            switch press.state {
            case .began:
                // 根据长按点，获取对应cell的IndexPath
                guard let indexPath = collection.indexPathForItem(at: point) else {
                    return
                }
                collection.beginInteractiveMovementForItem(at: indexPath)
            case .changed:
                collection.updateInteractiveMovementTargetPosition(point)
            case .ended:
                collection.endInteractiveMovement()
            default:
                collection.cancelInteractiveMovement()
            }
        }
    }


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MNCloudLiveCardCell", for: indexPath) as! MNCloudLiveCardCell
        cell.delegate = self
        cell.dataSource = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("sub count is \(data[indexPath.row].model.dataCount)")
    }
    
}
// MARK - cell sorts
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return proposedIndexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        data.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return data[indexPath.row].liveCardSize(width: UIScreen.main.bounds.width - 20)
    }
}


extension ViewController: MNCloudLiveCardCellDelegate {
    
    func didSelect(collectionView: UICollectionView, at indexPath: IndexPath) {
        
    }
    
    
    func didSelect(cell: MNCloudLiveCardCell, at item: LiveCardItem) {
        switch item {
        case .second:
            if let i = collection.indexPath(for: cell) {
                
                data[i.row].model.isOpen = !data[i.row].model.isOpen
//                cell.showCollectionReadyToLoading()
                debugPrint("1 realoding cell at \(i.row)")
                collection.reloadItems(at: [i])
                if data[i.row].model.isOpen && data[i.row].model.dataCount == 0 {
                    
                    DispatchQueue.global().async {
                        sleep(1)
                        DispatchQueue.main.async {
                            
                            self.data[i.row].model.dataCount = 50
                            cell.setCollectionNoDataIfNeed()
                            debugPrint("2 realoding cell at \(i.row)")
                            cell.reloadCellCollection()
                            self.collection.reloadItems(at: [i])
                        }
                    }
                }
                
                
            }
        default:
            debugPrint("\(item)")
        }
    }
    
    
    
}

