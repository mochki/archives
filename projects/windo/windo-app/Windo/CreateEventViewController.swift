//
//  CreateEventViewController.swift
//  Windo
//
//  Created by Joey on 3/14/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import CoreData

class CreateEventViewController: UIViewController {
    
    //MARK: Properties
    var createTabBar: CreateTabBarController!
    var createEventView: CreateEventView!
    var members = [String]()
    var initialStates = [CGFloat]()
    var selectedTimes = [NSDate]()
    
    var filteredInvitees = [UserProfile]()
    let userProfile = UserManager.userProfile
    let allFriends = UserManager.friends
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        createTabBar = (tabBarController as! CreateTabBarController)
        createEventView = CreateEventView()
        view = createEventView
        title = "Create Event"
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(CreateEventViewController.handleCalendarGesture(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.handleCalendarGesture(_:)))
        
        createEventView.calendarContainer.dragView.addGestureRecognizer(drag)
        createEventView.calendarContainer.dragView.addGestureRecognizer(tap)
        createEventView.calendarContainer.delegate = self
        
        createEventView.inviteeTableView.delegate = self
        createEventView.inviteeTableView.dataSource = self
        
        createEventView.searchBar.delegate = self
        createEventView.searchBar.dataSource = self
        
        filteredInvitees = allFriends
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        setNavigationButtons()
    }

    //MARK: Methods
    
    func setNavigationButtons() {
        if createEventView.inviteeTableView.hidden == true {
            createTabBar.title = "Create Event"
            
            let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.cancelTapped))
            createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
            
            let doneBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.nextTapped))
            createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
        } else {
            createTabBar.title = "Invite Friends"
            
            let cancelBarButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.doNothing))
            createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
            
            let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreateEventViewController.doneTapped))
            createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
        }
    }
    
    func handleCalendarGesture(gesture: UIGestureRecognizer){
        let days = createEventView.calendarContainer.days
        if initialStates.isEmpty {
            for day in days {
                initialStates.append(day.selectedBackground.alpha)
            }
        }
        
        for (index,day) in days.enumerate() {
            if day.frame.contains(gesture.locationInView(createEventView.calendarContainer)){
                if (day.selectedBackground.alpha == initialStates[index]){
                    day.tapped()
                }
            }
        }
        
        if gesture.state == .Ended {
            initialStates.removeAll()
        }
    }
    
    func nextTapped(){
        let dates = createEventView.calendarContainer.selectedDays
        
        if dates.count > 0 {
            createTabBar.title = "Specify Times"
            createTabBar.selectedIndex = 1
        }
        else {
            noDaysAlert()
        }
    }
    
    func cancelTapped(){
        createTabBar.displayCancelAlert()
    }
    
    func doneTapped() {
        createEventView.inviteeTableView.hidden = true
        setNavigationButtons()
        createEventView.endEditing(true)
    }
    
    func doNothing(){}
    
    func noDaysAlert(){
        let alertController = UIAlertController(title: "Hey!", message: "Select some days on the calendar first!", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Okay", style: .Default) { (action) in}
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

extension CreateEventViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredInvitees.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inviteeCell") as! InviteeCell
        let friend = filteredInvitees[indexPath.row]
        
        cell.profileImageView.setupView(friend, width: 44)
        
        cell.nameLabel.text = friend.fullName
        cell.userHandleLabel.text = "@\(friend.fullName.lowercaseString)"
        cell.userHandleLabel.text = cell.userHandleLabel.text?.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        if createTabBar.invitees.contains(friend){
            cell.checkmarkImageView.alpha = 1.0
            cell.checkmarkImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            cell.infoButton.alpha = 0.0
            cell.infoButton.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        }
        else{
            cell.infoButton.alpha = 1.0
            cell.infoButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            cell.checkmarkImageView.alpha = 0.0
            cell.checkmarkImageView.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
        }
        
        cell.infoGestureRecognizer.addTarget(self, action: #selector(CreateEventViewController.openUserProfile(_:)))
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! InviteeCell
        let friend = filteredInvitees[indexPath.row]
        
        if createTabBar.invitees.contains(friend){
            let index = createTabBar.invitees.indexOf(friend)
            createTabBar.invitees.removeAtIndex(index!)
        } else{
            createTabBar.invitees.append(friend)
        }
        
        cell.animateChange()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        createEventView.searchBar.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("inviteeHeaderCell") as! InviteeHeaderCell
        
        let bgColor = UIColor.darkBlue()
        var label = ""
        switch(section){
        case 0:
            label = "Recently invited"
        case 1:
            label = "All Contacts"
        default:
            label = "Error!"
        }
        header.titleLabel.text = label
        header.contentView.backgroundColor = bgColor
        return header
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func openUserProfile(sender: UITapGestureRecognizer) {
        let profileVC = UserProfileViewController()
        profileVC.user = allFriends[0]
        profileVC.color = ThemeColor.Blue
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension CreateEventViewController: VENTokenFieldDelegate, VENTokenFieldDataSource {
    func numberOfTokensInTokenField(tokenField: VENTokenField) -> UInt {
        return  UInt(createTabBar.invitees.count)
    }
    
    func tokenField(tokenField: VENTokenField, titleForTokenAtIndex index: UInt) -> String {
        return  createTabBar.invitees[Int(index)].fullName
    }
    
    func tokenField(tokenField: VENTokenField, didEnterText text: String) {
        
//        createTabBar.invitees.append(text)
//        createEventView.searchBar.reloadData()
    }
    
    func tokenField(tokenField: VENTokenField, didDeleteTokenAtIndex index: UInt) {
        createTabBar.invitees.removeAtIndex(Int(index))
        createEventView.searchBar.reloadData()
        createEventView.inviteeTableView.reloadData()
    }
    
    func tokenField(tokenField: VENTokenField, didChangeText text: String?) {
        createEventView.inviteeTableView.hidden = false
        createEventView.bringSubviewToFront(createEventView.inviteeTableView)
        setNavigationButtons()
        
        if let searchText = text {
            updateSearchResultsForSearchController(searchText)
        }
    }
    
    func tokenField(tokenField: VENTokenField, didChangeContentHeight height: CGFloat) {
        createEventView.searchBar.addConstraints(
            Constraint.tt.of(createEventView),
            Constraint.llrr.of(createEventView),
            Constraint.h.of(height)
        )
        
        createEventView.layoutIfNeeded()
    }
    
    func tokenFieldCollapsedText(tokenField: VENTokenField) -> String {
        if createTabBar.invitees.count > 1 {
            return "\(createTabBar.invitees.count) people"
        } else {
            return "1 person"
        }
    }
    
    func updateSearchResultsForSearchController(searchString: String) {
        defer {createEventView.inviteeTableView.reloadData()}
        
        if (searchString == "") {
            filteredInvitees = allFriends
            return
        }
        
        filteredInvitees.removeAll(keepCapacity: false)
        filteredInvitees = allFriends.filter() { $0.fullName.containsString(searchString) }
    }
}

extension CreateEventViewController: WindoCalendarDelegate {
    
    func daysSelectedDidChange(dates: [NSDate]) {
        createTabBar.selectedDates = dates
    }
}