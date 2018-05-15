//
//  CharactersViewController.swift
//  marvel-characters
//
//  Created by Luiza Collado Garofalo on 15/05/18.
//  Copyright © 2018 Luiza Garofalo. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    var charactersGateway: CharactersGateway!
    
    var characters: [Character] = []
    
    var randomData = ["01", "02", "03", "04"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersCollectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharactersCell")
        
        let width = (view.frame.size.width - 10) / 2
        let layout = charactersCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell", for: indexPath) as? CharactersCollectionViewCell else { return UICollectionViewCell() }
        
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = randomData[indexPath.row]
        }
        
        return cell
    }
}
