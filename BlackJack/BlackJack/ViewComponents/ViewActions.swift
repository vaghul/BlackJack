//
//  ViewActions.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-10.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

protocol ViewActionsDelegate:class {
    func onClickStand()
    func onClickHit()
}


class ViewActions:UIView {
    
    weak var delegate:ViewActionsDelegate?
    
    let buttonStand:ButtonGame = {
        let view = ButtonGame()
        view.tag = 0
        view.setTitle("Stand", for: .normal)
        return view
    }()
    
    let buttonHit:ButtonGame = {
        let view = ButtonGame()
        view.tag = 1
        view.setTitle("Hit", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        viewSetup()
    }
    
    func setActionValue(isnewGame:Bool) {
        if isnewGame {
            buttonStand.setTitle("Play Min Bet", for: .normal)
            buttonHit.setTitle("Play Custom Bet", for: .normal)
        }else{
            buttonStand.setTitle("Stand", for: .normal)
            buttonHit.setTitle("Hit", for: .normal)
        }
    }
    
    fileprivate func viewSetup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let menuStack = UIStackView(arrangedSubviews: [buttonStand,buttonHit])
        menuStack.translatesAutoresizingMaskIntoConstraints = false
        menuStack.alignment = .center
        menuStack.distribution = .fillEqually
        menuStack.spacing = 20
        menuStack.axis = .horizontal
        
        buttonStand.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonHit.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(menuStack)
        menuStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        buttonStand.addTarget(self, action: #selector(onClickAction(_:)), for: .touchUpInside)
        buttonHit.addTarget(self, action: #selector(onClickAction(_:)), for: .touchUpInside)
    }
    
    @objc func  onClickAction(_ sender:UIButton) {
        if sender.tag == 0 {
            delegate?.onClickStand()
        }else if sender.tag == 1{
            delegate?.onClickHit()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
