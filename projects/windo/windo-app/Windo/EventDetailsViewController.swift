//
//  EventDetailsViewController.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit


class EventDetailsViewController: UIViewController {
    
    //MARK: Properties
    
    var detailsView: EventDetailsView!
    var members = [String]()
    var responseNeeded = false
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        detailsView = EventDetailsView()
        view.backgroundColor = UIColor.purple()
        view = detailsView
        detailsView.memberTableView.delegate = self
        detailsView.memberTableView.dataSource = self
        
        members = ["Ray Elder", "Sarah Kay Miller", "Yuki Dorff", "Joey Nelson", "John Jackson", "Blake Hopkin", "Paul Turner", "Vladi Falk"]
        detailsView.addMemberButton.addTarget(self, action: #selector(EventDetailsViewController.addMemberTapped), forControlEvents: .TouchUpInside)
        detailsView.anytimeWorks.addTarget(self, action: #selector(EventDetailsViewController.dismissResponseNeeded), forControlEvents: .TouchUpInside)
        
        if responseNeeded{
            showResponseOptions()
        } else {
            hideResponseOptions()
        }

    }
    
    func addMemberTapped(){
        let response5 = ResponseCircleView()
        response5.initials.text = "TT"
        members.append("Tucker Turner")
        detailsView.memberTableView.reloadData()
        
        detailsView.respondedStackView.addArrangedSubview(response5)
        detailsView.respondedStackView.addConstraints(
            Constraint.tt.of(detailsView, offset: 18),
            Constraint.cxcx.of(detailsView),
            Constraint.w.of(CGFloat(44 * 5)),
            Constraint.h.of(40)
        )
        detailsView.respondedStackView.spacing = 5
    }
    
    func dismissResponseNeeded() {
        hideResponseOptions()
    }
    
    func showResponseOptions(){
        tabBarController?.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        detailsView.backgroundColor = UIColor.whiteColor()
        
        detailsView.separatingLine.hidden = true
        detailsView.locationTitleLabel.hidden = true
        detailsView.locationLabel.hidden = true
        detailsView.dateTimeTitleLabel.hidden = true
        detailsView.dateTimeLabel.hidden = true
        
        detailsView.anytimeWorks.hidden = false
        detailsView.submitTimes.hidden = false
        detailsView.responseLabel.hidden = false
        
        detailsView.blurView.hidden = false
        
        tabBarController?.tabBar.hidden = true
    }
    
    func hideResponseOptions(){
        tabBarController?.navigationController?.navigationBar.barTintColor = UIColor.purple()
        detailsView.backgroundColor = UIColor.lightPurple()
        
        detailsView.separatingLine.hidden = false
        detailsView.locationTitleLabel.hidden = false
        detailsView.locationLabel.hidden = false
        detailsView.dateTimeTitleLabel.hidden = false
        detailsView.dateTimeLabel.hidden = false
        
        detailsView.anytimeWorks.hidden = true
        detailsView.submitTimes.hidden = true
        detailsView.responseLabel.hidden = true
        
        detailsView.blurView.hidden = true
        
        tabBarController?.tabBar.hidden = false
    }
}

extension EventDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memberCell") as! GroupMemberCell
        
        cell.nameLabel.text = members[indexPath.row]
        cell.initialsLabel.text = getInitials(members[indexPath.row])
        cell.infoGestureRecognizer.addTarget(self, action: #selector(EventDetailsViewController.openUserProfile(_:)))
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func getInitials(name: String) -> String{
        let firstInitial = "\(name[name.startIndex.advancedBy(0)])"
        
        guard let index = name.characters.indexOf(" ") else {
            return firstInitial.uppercaseString
        }
        
        let secondInitial = "\(name[name.startIndex.advancedBy(name.startIndex.distanceTo(index) + 1)])"
        
        let initials = "\(firstInitial)\(secondInitial)"
        
        return initials.uppercaseString
    }
    
    func openUserProfile(sender: UITapGestureRecognizer) {
        let profileVC = UserProfileViewController()
        profileVC.color = ThemeColor.Purple
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
