//
//  ChipsCollectionViewCell.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-12.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

class ChipsCollectionViewCell: UICollectionViewCell {
    
    let viewChip: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .buttonRed
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let labelChipValue:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .semiBoldChip
        view.textColor = .white
        view.textAlignment = .center
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
        
        addSubview(viewChip)
        
        viewChip.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewChip.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewChip.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        viewChip.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        viewChip.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        viewChip.layer.cornerRadius = self.frame.height/2
        viewChip.layer.masksToBounds = true
        
        viewChip.addSubview(labelChipValue)
        
        labelChipValue.centerYAnchor.constraint(equalTo: viewChip.centerYAnchor).isActive = true
        labelChipValue.centerXAnchor.constraint(equalTo: viewChip.centerXAnchor).isActive = true
        
    }
    
    func setChipValue(value:Int) {
        labelChipValue.text = "$\(value)"
    }
}

