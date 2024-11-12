//
//  InviteView.swift
//  Windo
//
//  Created by Joey on 3/22/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class InviteView: UIView {
    
    //MARK: Properties
    var inviteeTableView = UITableView()
    var searchBar = VENTokenField()
    
    var inviteePlaceholderText = "Select people to invite!"
    
    //MARK: View Configuration
    
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        inviteeTableView.backgroundColor = UIColor.darkBlue()
        inviteeTableView.showsVerticalScrollIndicator = false
        inviteeTableView.separatorColor = UIColor.blue()
        inviteeTableView.registerClass(InviteeCell.self, forCellReuseIdentifier: "inviteeCell")
        inviteeTableView.registerClass(InviteeHeaderCell.self, forHeaderFooterViewReuseIdentifier: "inviteeHeaderCell")
        
        searchBar.delimiters = [",", ";", "--"]
        searchBar.placeholderText = "Invite some friends!"
        searchBar.toLabelText = "Invite:"
        searchBar.backgroundColor = UIColor.whiteColor()
        searchBar.setColorScheme(UIColor.darkBlue())
        searchBar.tintColor = UIColor.lightBlue()
        searchBar.toLabelTextColor = UIColor.blue()
        searchBar.inputTextFieldTextColor = UIColor.darkBlue()
        
        addSubview(inviteeTableView)
        addSubview(searchBar)
    }
    
    func applyConstraints(){
        searchBar.addConstraints(
            Constraint.tt.of(self),
            Constraint.llrr.of(self),
            Constraint.h.of(50)
        )
        
        inviteeTableView.addConstraints(
            Constraint.tb.of(searchBar),
            Constraint.bb.of(self),
            Constraint.llrr.of(self),
            Constraint.w.of(screenWidth)
        )
    }
}