//
//  viewBets.swift
//  BlackJack
//
//  Created by Vaghula Krishnan on 2020-07-12.
//  Copyright © 2020 Vaghula Krishnan. All rights reserved.
//

import UIKit

protocol viewBetsDelegate:class {
    
    func onClickClose()
    func onClickChip(value:Int)
}

class viewBets: UIView {
    
    let chipValues = [1,5,50,100,500]
    
    weak var delegate:viewBetsDelegate?
    
    var collectionViewWidth:CGFloat {
        let minSpace:CGFloat = 10 * CGFloat(chipValues.count - 1)
        var width = self.frame.size.width - 10.0 - ((minSpace > 0) ? minSpace : 0)
        width /= CGFloat(chipValues.count)
        return width
    }
    
    let viewBackground:UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    
    
    let viewContent:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let labelTitle:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .semiBoldTitle
        view.textColor = .white
        view.textAlignment = .center
        view.text = Constants.shared.PlaceholderChooseBet
        return view
    }()
    
    
    var viewCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(ChipsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.shared.CellReuseChip)
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
        backgroundColor = .clear
        
        addSubview(viewBackground)
        viewBackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        viewBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        viewBackground.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        
        addSubview(viewContent)
        //viewContent.backgroundColor = .borderGreen
        viewContent.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        viewContent.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        viewContent.heightAnchor.constraint(equalToConstant: 120).isActive = true
        viewContent.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        viewContent.addSubview(labelTitle)
        labelTitle.topAnchor.constraint(equalTo: viewContent.topAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        viewContent.addSubview(viewCollection)
        
        viewCollection.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,constant: 8).isActive = true
        viewCollection.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor).isActive = true
        viewCollection.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor).isActive = true
        viewCollection.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor).isActive = true
        viewCollection.contentInsetAdjustmentBehavior = .never
        
        viewBackground.addTarget(self, action: #selector(onClickClose), for: .touchUpInside)
        
        viewCollection.delegate = self
        viewCollection.dataSource = self
        viewCollection.reloadData()
    }
    
    @objc func onClickClose(){
        delegate?.onClickClose()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension viewBets : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chipValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.CellReuseChip, for: indexPath) as! ChipsCollectionViewCell
        cell.setChipValue(value: chipValues[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionViewWidth, height: collectionViewWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onClickChip(value: chipValues[indexPath.item])
    }
    
}

