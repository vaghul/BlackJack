//
//  ButtonGame.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-09.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class ButtonGame: UIButton {

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        viewSetup()
    }
    
    func viewSetup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .buttonRed
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.borderGreen.cgColor
        self.setTitleColor(.white, for:  .normal)
        self.setTitleColor(.buttonRed, for: .highlighted)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
