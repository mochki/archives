//
//  HomeViewController.swift
//  Windo
//
//  Created by Joey on 2/16/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: CenterViewController{
    
    //MARK: Properties
    
    var homeView = HomeView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view = homeView
        title = "Events"
                
        let sideMenuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        sideMenuButton.setImage(UIImage(named: "HamburgerIcon"), forState: .Normal)
        sideMenuButton.addTarget(self, action: #selector(HomeViewController.toggleOpen), forControlEvents: .TouchUpInside)
        let sideMenuBarButton = UIBarButtonItem(customView: sideMenuButton)
        self.navigationItem.setLeftBarButtonItem(sideMenuBarButton, animated: true)
        
        let addEventButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        addEventButton.setImage(UIImage(named: "AddEventButton"), forState: .Normal)
        addEventButton.addTarget(self, action: #selector(HomeViewController.createNewEvent), forControlEvents: .TouchUpInside)
        let addEventBarButton = UIBarButtonItem(customView: addEventButton)
        self.navigationItem.setRightBarButtonItem(addEventBarButton, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightTeal()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.mikeBlue()]
    }
    
    override func viewDidLayoutSubviews() {
        showSplashScreen(homeView)
        homeView.sendSubviewToBack(homeView.eventTableView)
    }
    
    func toggleOpen(){
        delegate?.toggleLeftPanel?()
    }
    
    func createNewEvent() {
        let createTabVC = CreateTabBarController()
        let vc1 = CreateEventViewController()
        let vc2 = TimeSelectViewController()
        let controllers = [vc1, vc2]
        
        vc1.tabBarItem = UITabBarItem(
            title: "Create",
            image: UIImage(named: "HomeIcon"),
            tag: 1)
        
        vc2.tabBarItem = UITabBarItem(
            title: "WindoSelect",
            image: UIImage(named: "HomeIcon"),
            tag: 2)
        
        createTabVC.viewControllers = controllers
        createTabVC.selectedIndex = 0
        navigationController?.pushViewController(createTabVC, animated: true)
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView(){
        homeView.eventTableView.delegate = self
        homeView.eventTableView.dataSource = self
    }
    
    //MARK: Cell
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell") as! EventCell
        cell.backgroundColor = UIColor.teal()
        cell.titleLabel.text = "Michael's Party"
        cell.locationLabel.text = "The Yellow Door House"
        cell.eventStatus.text = "You need to respond!"
        cell.eventStatus.textColor = UIColor.whiteColor()
        cell.selectionStyle = .None
        cell.notificationDot.hidden = true

        switch(indexPath.section){
        case 0:
            cell.backgroundColor = UIColor.lightTeal()
            cell.titleLabel.text = "BFA Dinner"
            cell.eventStatus.text = "April 17, 2016 4:00pm"
        case 1:
            cell.backgroundColor = UIColor.teal()
            cell.titleLabel.text = "St. George Trip"
            cell.notificationDot.hidden = false
        case 2:
            cell.backgroundColor = UIColor.darkTeal()
            cell.eventStatus.text = "February 4, 2016 8:00pm"
            cell.eventStatus.textColor = UIColor.mikeBlue()
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailsVC = DetailsTabBarController()
        let vc1 = EventMessagesViewController()
        let vc2 = EventDetailsViewController()
        let vc3 = EventResultsViewController()
        let controllers = [vc1, vc2, vc3]
        
        vc1.tabBarItem = UITabBarItem(
            title: "Messages",
            image: UIImage(named: "MessageIcon"),
            tag: 1)
        
        vc2.tabBarItem = UITabBarItem(
            title: "Event Info",
            image: UIImage(named: "HomeIcon"),
            tag: 2)
        
        vc3.tabBarItem = UITabBarItem(
            title: "Results",
            image: UIImage(named: "ResultsIcon"),
            tag: 3)
        
        detailsVC.viewControllers = controllers
        detailsVC.selectedIndex = 1
        navigationController?.pushViewController(detailsVC, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: Header
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 129.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("eventHeaderCell") as! EventHeaderCell
        
        var bgColor = UIColor()
        var label = ""
        switch(section){
        case 0:
            label = "Upcoming"
            bgColor = UIColor.lightTeal()
        case 1:
            label = "Pending"
            bgColor = UIColor.teal()
        case 2:
            label = "Past"
            bgColor = UIColor.darkTeal()
        default:
            label = "Error!"
        }
        header.titleLabel.text = label
        header.contentView.backgroundColor = bgColor
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
}