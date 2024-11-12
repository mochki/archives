////
////  InviteViewController.swift
////  Windo
////
////  Created by Joey on 3/22/16.
////  Copyright © 2016 NelsonJE. All rights reserved.
////
//
//import UIKit
//
//enum InviteState{
//    case FirstInvite
//    case AddingInvites
//}
//
//class InviteViewController: UIViewController {
//    
//    //MARK: Properties
//    
//    var state: InviteState = .FirstInvite
//    var createTabBar: CreateTabBarController!
//    var inviteView = InviteView()
//    var filteredInvitees = [UserProfile]()
//    let userProfile = UserManager.userProfile
//    let allFriends = UserManager.friends
//    
//    //MARK: Lifecycle Methods
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        createTabBar = (tabBarController as! CreateTabBarController)
//        view = inviteView
//        
//        inviteView.inviteeTableView.delegate = self
//        inviteView.inviteeTableView.dataSource = self
//        
//        inviteView.searchBar.delegate = self
//        inviteView.searchBar.dataSource = self
//    
//        filteredInvitees = allFriends
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(true)
//        
//        createTabBar.title = "Create Event"
//        
//        if state == .FirstInvite {
//            let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InviteViewController.cancelTapped))
//            createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
//        }
//        else {
//            let cancelBarButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InviteViewController.doNothing))
//            createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
//        }
//        
//        
//        let doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InviteViewController.doneTapped))
//        createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
//    }
//    
//    func doneTapped(){
//        createTabBar.selectedIndex = 1
//    }
//    
//    func cancelTapped(){
//        navigationController?.popViewControllerAnimated(true)
//    }
//    
//    func doNothing(){
//        
//    }
//    
//    func updateInvitees(){
//
//    }
//}
//
//extension InviteViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredInvitees.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("inviteeCell") as! InviteeCell
//        let friend = filteredInvitees[indexPath.row]
//        
//        cell.profileImageView.setupView(friend, width: 44)
//        
//        cell.nameLabel.text = friend.fullName
//        cell.userHandleLabel.text = "@\(friend.fullName.lowercaseString)"
//        cell.userHandleLabel.text = cell.userHandleLabel.text?.stringByReplacingOccurrencesOfString(" ", withString: "-")
//        
//        if createTabBar.invitees.contains(friend.fullName){
//            cell.checkmarkImageView.alpha = 1.0
//            cell.checkmarkImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
//            
//            cell.infoButton.alpha = 0.0
//            cell.infoButton.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
//        }
//        else{
//            cell.infoButton.alpha = 1.0
//            cell.infoButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
//            
//            cell.checkmarkImageView.alpha = 0.0
//            cell.checkmarkImageView.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
//        }
//        
//        cell.infoGestureRecognizer.addTarget(self, action: #selector(InviteViewController.openUserProfile(_:)))
//        
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 65
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! InviteeCell
//        let friend = filteredInvitees[indexPath.row]
//        
//        if createTabBar.invitees.contains(friend.fullName){
//            let index = createTabBar.invitees.indexOf(friend.fullName)
//            createTabBar.invitees.removeAtIndex(index!)
//        } else{
//            createTabBar.invitees.append(cell.nameLabel.text!)
//        }
//
//        cell.animateChange()
//        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        updateInvitees()
//        
//        inviteView.searchBar.reloadData()
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("inviteeHeaderCell") as! InviteeHeaderCell
//        
//        let bgColor = UIColor.darkBlue()
//        var label = ""
//        switch(section){
//        case 0:
//            label = "Recently invited"
//        case 1:
//            label = "All Contacts"
//        default:
//            label = "Error!"
//        }
//        header.titleLabel.text = label
//        header.contentView.backgroundColor = bgColor
//        return header
//    }
//    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        view.endEditing(true)
//    }
//    
//    func openUserProfile(sender: UITapGestureRecognizer) {
//        let profileVC = UserProfileViewController()
//        profileVC.user = allFriends[0]
//        profileVC.color = ThemeColor.Blue
//        navigationController?.pushViewController(profileVC, animated: true)
//    }
//}
//
//extension InviteViewController: VENTokenFieldDelegate, VENTokenFieldDataSource {
//    func numberOfTokensInTokenField(tokenField: VENTokenField) -> UInt {
//        return  UInt(createTabBar.invitees.count)
//    }
//    
//    func tokenField(tokenField: VENTokenField, titleForTokenAtIndex index: UInt) -> String {
//        return  createTabBar.invitees[Int(index)]
//    }
//    
//    func tokenField(tokenField: VENTokenField, didEnterText text: String) {
//        createTabBar.invitees.append(text)
//        inviteView.searchBar.reloadData()
//    }
//    
//    func tokenField(tokenField: VENTokenField, didDeleteTokenAtIndex index: UInt) {
//        createTabBar.invitees.removeAtIndex(Int(index))
//        inviteView.searchBar.reloadData()
//    }
//    
//    func tokenField(tokenField: VENTokenField, didChangeText text: String?) {
//        if let searchText = text {
//            updateSearchResultsForSearchController(searchText)
//        }
//    }
//    
//    func tokenField(tokenField: VENTokenField, didChangeContentHeight height: CGFloat) {
//        inviteView.searchBar.addConstraints(
//            Constraint.tt.of(inviteView),
//            Constraint.llrr.of(inviteView),
//            Constraint.h.of(height)
//        )
//        
//        self.inviteView.layoutIfNeeded()
//    }
//    
//    func tokenFieldCollapsedText(tokenField: VENTokenField) -> String {
//        if createTabBar.invitees.count > 1 {
//            return "\(createTabBar.invitees.count) people"
//        } else {
//            return "1 person"
//        }
//    }
//    
//    func updateSearchResultsForSearchController(searchString: String) {
//        defer {inviteView.inviteeTableView.reloadData()}
//        
//        if (searchString == "") {
//            filteredInvitees = allFriends
//            return
//        }
//        
//        filteredInvitees.removeAll(keepCapacity: false)
//        filteredInvitees = allFriends.filter() { $0.fullName.containsString(searchString) }
//    }
//}