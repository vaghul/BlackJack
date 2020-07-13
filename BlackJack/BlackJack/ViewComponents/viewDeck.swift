//
//  viewDeck.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-09.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class viewDeck: UIView {

    private var playerHand:Player?
    
    let labelTitle:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .semiBoldTitle
        view.textColor = .white
        view.textAlignment = .left
        return view
    }()
    
    let labelPointValue:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .semiBoldTitle
        view.textColor = .white
        view.textAlignment = .right
        return view
    }()
    var viewCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: Constants.shared.CellReuseCard)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
  
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        viewSetup()
    }
    
    fileprivate func viewSetup() {
      
        self.translatesAutoresizingMaskIntoConstraints = false

        viewCollection.delegate = self
        viewCollection.dataSource = self
        
        let labelStack = UIStackView(arrangedSubviews: [labelTitle,labelPointValue])
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.alignment = .center
        labelStack.axis = .horizontal
        labelStack.distribution = .equalSpacing
        labelStack.spacing = 2
        
        addSubview(labelStack)
        labelStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        labelStack.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        addSubview(viewCollection)
        
        viewCollection.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,constant: 8).isActive = true
        viewCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        viewCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        viewCollection.contentInsetAdjustmentBehavior = .never
    }
        
    func setPlayer(object:Player) {
        playerHand = object
        labelTitle.text = playerHand?.name
        if playerHand?.deckOfCards != nil {
            viewCollection.reloadData()
        }
    }
    
    func resetPlayersHand() {
        playerHand = nil
        labelTitle.text = nil
        labelPointValue.text = nil
        viewCollection.reloadData()
    }
    
    func addCard(dealtCard:Card?) {
        if let cardValue = dealtCard {
            playerHand?.addCard(card: cardValue)
            if let count = playerHand?.deckOfCards?.count {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.viewCollection.insertItems(at: [IndexPath(item: count - 1, section: 0)])
                }, completion: nil)
                
                labelPointValue.text = playerHand!.getHandValue()
            }
        }
    }
    
    func isPlayerBlackJacked() -> Bool {
        guard playerHand != nil else { return  false}
        
        return playerHand!.isBlackJack()
    }

    func getPlayerObj() -> Player? {
        return playerHand
    }
    
    func getDealerObj() -> Dealer? {
        return playerHand as? Dealer
    }
    
    func isPlayerBust() -> Bool {
        guard playerHand != nil else { return  false}
        
        return playerHand!.isBust()

    }
    func unHideCard() {
        if let count = playerHand?.deckOfCards?.count, count >= 1, let dealer = self.getDealerObj() {
            dealer.unHideCard()
            viewCollection.reloadItems(at: [IndexPath(item: 0, section: 0)])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension viewDeck : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerHand?.deckOfCards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.CellReuseCard, for: indexPath) as! CardCollectionViewCell
        if let cardvalue = playerHand?.deckOfCards?[indexPath.item] {
            cell.setCardImage(card: cardvalue)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return .init(width: 80, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    
}
