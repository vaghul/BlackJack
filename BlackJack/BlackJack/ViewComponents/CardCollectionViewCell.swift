//
//  CardCollectionViewCell.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-10.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    let imageViewCard: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewSetup()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func viewSetup() {
        
        layer.masksToBounds = true
        
        addSubview(imageViewCard)
        
        imageViewCard.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageViewCard.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageViewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageViewCard.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        imageViewCard.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true

    }
    
    func setCardImage(card: Card) {
        imageViewCard.image = UIImage(named: card.getImageName())
    }
}
