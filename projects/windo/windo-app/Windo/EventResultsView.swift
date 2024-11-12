//
//  EventResultsView.swift
//  Windo
//
//  Created by Joey on 4/11/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class EventResultsView: UIView {
    
    //MARK: Properties
    var helpLabel = UILabel()
    var filter = ResultsFilterView()
    var resultsTableView = UITableView()
    
    var members = [String]()
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        backgroundColor = UIColor.lightPurple()
        
        helpLabel.text = "Here are the times that might work.\nTap users to filter results."
        helpLabel.numberOfLines = 2
        helpLabel.textColor = UIColor.whiteColor()
        helpLabel.font = UIFont.graphikRegular(15)
        helpLabel.textAlignment = .Center
        
        resultsTableView.showsVerticalScrollIndicator = false
        resultsTableView.registerClass(EventResultsCell.self, forCellReuseIdentifier: "resultsCell")
        resultsTableView.allowsSelection = false
        resultsTableView.separatorColor = UIColor.darkPurple()
        resultsTableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        resultsTableView.backgroundColor = UIColor.lightPurple()
        
        filter.members = members
        
        addSubview(resultsTableView)
        addSubview(helpLabel)
        addSubview(filter)
    }
    
    func applyConstraints(){
        helpLabel.addConstraints(
            Constraint.tt.of(self, offset: 15),
            Constraint.cxcx.of(self)
        )
        
        filter.addConstraints(
            Constraint.tt.of(self, offset: 55),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60)
        )
        
        resultsTableView.addConstraints(
            Constraint.tt.of(self),
            Constraint.cxcx.of(self),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight - 114)
        )
    }
}