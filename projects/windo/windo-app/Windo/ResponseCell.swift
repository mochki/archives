//
//  ResponseCell.swift
//  Windo
//
//  Created by Joey on 4/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class ResponseCell: UICollectionViewCell {
    
    //MARK: Properties
    var initials = UILabel()
    var imageView = UIImageView()
    var whSize:CGFloat = 40
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.darkPurple(0.46)
        
        initials.textColor = UIColor.whiteColor()
        initials.font = UIFont.graphikRegular(15)
        initials.textAlignment = .Center
        
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = whSize/2
        
        addSubview(initials)
        addSubview(imageView)
    }
    
    func applyConstraints(){
        initials.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self)
        )
        
        imageView.addConstraints(
            Constraint.cxcx.of(self),
            Constraint.cycy.of(self),
            Constraint.wh.of(whSize)
        )
    }
}