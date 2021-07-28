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
        
        return [LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true)), LiveCellModel(), LiveCellModel(), LiveCellModel(model: TestModel(is4G: true))]
    }()
    
    @IBOutlet weak var collection: UICollectionView! {
        didSet {
            
            let l = UICollectionViewFlowLayout()
            l.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 308)
            l.minimumLineSpacing = 12
            l.scrollDirection = .vertical
            collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            collection.setCollectionViewLayout(l, animated: false)
            collection.register(MNCloudLiveCardCell.self, forCellWithReuseIdentifier: "MNCloudLiveCardCell")
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
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

    }
    
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return data[indexPath.row].liveCardSize(width: UIScreen.main.bounds.width - 20)
    }
}


extension ViewController: MNCloudLiveCardCellDelegate {
    
    func didSelect(cell: MNCloudLiveCardCell, at item: LiveCardItem) {
        switch item {
        case .second:
            if let i = collection.indexPath(for: cell) {
                data[i.row].model.isOpen = !data[i.row].model.isOpen
                collection.reloadItems(at: [i])
            }
        default:
            debugPrint("\(item)")
        }
    }
    
}

