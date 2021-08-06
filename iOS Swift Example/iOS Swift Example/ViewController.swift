//
//  ViewController.swift
//  iOS Swift Example
//
//  Created by 蛮牛科技 on 7/21/21.
//

import UIKit
import MNCloudDeviceModular

class ViewController: UIViewController {

    lazy var data: [[LiveCellModel]] = {
        
        return [[LiveCellModel()], [LiveCellModel()], [LiveCellModel()], [LiveCellModel()]/*, LiveCellModel(model: TestModel(name: "ZHji999999999ZHji999999999ZHji999999999", is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true))*/]
    }()
    
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            
            let l = UICollectionViewFlowLayout()
            l.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 308)
            l.minimumLineSpacing = 4
            l.scrollDirection = .vertical
            l.sectionInset.bottom = 10
            collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
            collection.backgroundColor = .systemBlue
            collection.setCollectionViewLayout(l, animated: false)
            collection.register(MNCloudLiveCardCell.self, forCellWithReuseIdentifier: "MNCloudLiveCardCell")
            collection.register(UINib(nibName: "MessageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MessageCollectionViewCell")
            collection.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:))))
            
        }
    }
    
    var messageDataSource = MessageCellDataSource()
    
    
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
        data[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.section][indexPath.row]
        if model.isChild {
            //MessageCollectionViewCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageCollectionViewCell", for: indexPath) as! MessageCollectionViewCell
            messageDataSource.cell = cell
            print("has reload child")
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MNCloudLiveCardCell", for: indexPath) as! MNCloudLiveCardCell
        cell.delegate = self
        cell.dataSource = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        debugPrint("sub count is \(data[indexPath.row].dataCount)")
    }
    
}
// MARK: - cell sorts -
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return proposedIndexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceData = data[sourceIndexPath.section]
        data.remove(at: sourceIndexPath.section)
        data.insert(sourceData, at: destinationIndexPath.section)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = data[indexPath.section][indexPath.row]
        if model.isChild {
            return CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
        }
        return model.liveCardSize(width: UIScreen.main.bounds.width - 20)
    }
}


extension ViewController: MNCloudLiveCardCellDelegate {
    
    func didSelect(collectionView: UICollectionView, at indexPath: IndexPath) {
        debugPrint("did select collection at: \(indexPath.row)")
    }
    
    
    func didSelect(cell: MNCloudLiveCardCell, at item: LiveCardItem?, with tag: Int) {
        switch item {
        case .second:
            
            guard let i = collection.indexPath(for: cell) else { return }
//            messageDataSource.controlData = data
            messageDataSource.showOrHide(collection: collection, cellAt: i, control: &data)
            

                
        default:
            debugPrint("\(String(describing: item))")
        }
    }
    
    
    
    
}

