//
//  EventResultsCell.swift
//  Windo
//
//  Created by Joey on 4/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventResultsCell: UITableViewCell {
    
    //MARK: Properties
    var date = NSDate()
    var dayOfTheWeekLabel = UILabel()
    var dateLabel = UILabel()
    var timeLabel = UILabel()
    var responseCollectionView: UICollectionView!
    var responseLabel = UILabel()
    
    var members = [String]()
    var collectionViewAdded = false
    
    //MARK: Inits
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        responseCollectionView.contentOffset.x = 0
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.purple()
        
        dayOfTheWeekLabel.text = date.abbrevDayOfWeek()
        dayOfTheWeekLabel.textColor = UIColor.whiteColor()
        dayOfTheWeekLabel.font = UIFont.graphikMedium(14)
        
        dateLabel.text = "\(date.monthAbbrevCap()) \(date.day())"
        dateLabel.textColor = UIColor.whiteColor()
        dateLabel.font = UIFont.graphikRegular(14)
        
        if date.hour() < 12 {
            timeLabel.text = "\(date.pmHour()) AM"
        }
        else {
            timeLabel.text = "\(date.pmHour()) PM"
        }
        
        timeLabel.textColor = UIColor.darkPurple()
        timeLabel.font = UIFont.graphikRegular(12)
        
        responseLabel.text = "4/6 can make it"
        responseLabel.textColor = UIColor.darkPurple()
        responseLabel.font = UIFont.graphikRegular(12)
        
        configureCollectionView()
        
        addSubviews(dayOfTheWeekLabel, dateLabel, timeLabel, responseLabel)
    }
    
    func applyConstraints(){
        dayOfTheWeekLabel.addConstraints(
            Constraint.tt.of(self, offset: 22),
            Constraint.ll.of(self, offset: 22)
        )
        
        dateLabel.addConstraints(
            Constraint.tt.of(dayOfTheWeekLabel),
            Constraint.lr.of(dayOfTheWeekLabel, offset: 2)
        )
        
        timeLabel.addConstraints(
            Constraint.tb.of(dayOfTheWeekLabel, offset: 1),
            Constraint.ll.of(dayOfTheWeekLabel)
        )
        
        responseCollectionView.addConstraints(
            Constraint.tb.of(timeLabel, offset: 10),
            Constraint.ll.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(34)
        )
        
        responseLabel.addConstraints(
            Constraint.tb.of(responseCollectionView, offset: 10),
            Constraint.ll.of(dayOfTheWeekLabel)
        )
    }
}

extension EventResultsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView(){
        if collectionViewAdded {
            return
        }
        collectionViewAdded = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: 34, height: 34)
        responseCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        responseCollectionView.delegate = self
        responseCollectionView.dataSource = self
        responseCollectionView.registerClass(ResponseCell.self, forCellWithReuseIdentifier: "responseCell")
        responseCollectionView.showsVerticalScrollIndicator = false
        responseCollectionView.showsHorizontalScrollIndicator = false
        responseCollectionView.backgroundColor = UIColor.clearColor()
        addSubview(responseCollectionView)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = responseCollectionView.dequeueReusableCellWithReuseIdentifier("responseCell", forIndexPath: indexPath) as! ResponseCell
        cell.layer.cornerRadius = 17
        cell.initials.text = members[indexPath.row].getInitials()
        cell.whSize = 34
        
        if indexPath.row > 3 {
            cell.alpha = 0.5
        }
        else {
            cell.alpha = 1.0
        }
        
        if members[indexPath.row] == "John Jackson" {
            cell.imageView.image = UIImage(named: "John Profile")
        }
        
        return cell
    }
}

