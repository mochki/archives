//
//  ResultsFilterCell.swift
//  Windo
//
//  Created by Joey on 4/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class ResultsFilterView: UIView {
    
    //MARK: Properties
    var filterCollectionView: UICollectionView!
    var collectionViewAdded = false
    
    var members = [String]()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.lightPurple()
        
        configureCollectionView()
    }
    
    func applyConstraints(){
        filterCollectionView.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60)
        )
    }
}

extension ResultsFilterView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView(){
        if collectionViewAdded {
            return
        }
        collectionViewAdded = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: 40, height: 40)
        filterCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.registerClass(ResponseCell.self, forCellWithReuseIdentifier: "responseCell")
        filterCollectionView.showsVerticalScrollIndicator = false
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.backgroundColor = UIColor.clearColor()
        addSubview(filterCollectionView)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCellWithReuseIdentifier("responseCell", forIndexPath: indexPath) as! ResponseCell
        cell.alpha = 0.5
        cell.layer.cornerRadius = 20
        cell.initials.text = members[indexPath.row].getInitials()
        
        if members[indexPath.row] == "John Jackson" {
            cell.imageView.image = UIImage(named: "John Profile")
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ResponseCell!
        
        if cell.alpha == 0.5 {
            UIView.animateWithDuration(0.2, animations: {
                cell.alpha = 1.0
            })
        }
        else {
            UIView.animateWithDuration(0.2, animations: {
                cell.alpha = 0.5
            })
        }
        
    }
}