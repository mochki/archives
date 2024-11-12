//
//  TimeSelectViewController.swift
//  Windo
//
//  Created by Joey on 4/5/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class TimeSelectViewController: UIViewController {
    
    //MARK: Properties
    var createTabBar: CreateTabBarController!
    var timeSelectView = TimeSelectView()
    var timeCollectionView: UICollectionView!
    var scrubber: UICollectionView!
    
    var timesScrolling = false
    var scrubberScrolling = false
    var hasLaidOutViews = false
    var scrubberSelectedIndex = 1
    
    var red:CGFloat = 0
    var green:CGFloat = 0
    var blue:CGFloat = 0
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        view = timeSelectView
        createTabBar = (tabBarController as! CreateTabBarController)
        configureScrubber()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasLaidOutViews {
            hasLaidOutViews = true
            timeCollectionView.collectionViewLayout.collectionViewContentSize()
            scrubber.collectionViewLayout.collectionViewContentSize()
            
            let timePoint = CGPoint(x: screenWidth, y: timeCollectionView.contentOffset.y)
            let scrubPoint = CGPoint(x: screenWidth/5, y: scrubber.contentOffset.y)
            timeCollectionView.setContentOffset(timePoint, animated: false)
            scrubber.setContentOffset(scrubPoint, animated: false)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        createTabBar.title = "Specify Times"
        
        let cancelBarButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TimeSelectViewController.backTapped))
        createTabBar.navigationItem.setLeftBarButtonItem(cancelBarButton, animated: true)
        
        let doneBarButton = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TimeSelectViewController.doneTapped))
        createTabBar.navigationItem.setRightBarButtonItem(doneBarButton, animated: true)
        
        timeCollectionView.reloadData()
        scrubber.reloadData()
    }
    
    func backTapped(){
        createTabBar.selectedIndex = 0
    }
    
    func doneTapped(){
        let alertController = UIAlertController(title: "Hey!", message: "Ready to send out the invites?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Not yet!", style: .Default) { (action) in}
        alertController.addAction(cancelAction)
        
        let sendAction = UIAlertAction(title: "Send!", style: .Default) { (action) in
            self.createTabBar.finalizeEvent()
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(sendAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

extension TimeSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight - 64)
        timeCollectionView = UICollectionView(frame: timeSelectView.frame, collectionViewLayout: layout)
        timeCollectionView.tag = 0
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.registerClass(TimeSelectCollectionViewCell.self, forCellWithReuseIdentifier: "timeSelectCell")
        timeCollectionView.backgroundColor = UIColor.blue()
        timeCollectionView.showsVerticalScrollIndicator = false
        timeCollectionView.showsHorizontalScrollIndicator = false
        timeCollectionView.pagingEnabled = true
        timeCollectionView.backgroundColor = UIColor.blue()
        timeSelectView.addSubview(timeCollectionView)
        
        timeCollectionView.addConstraints(
            Constraint.tb.of(scrubber),
            Constraint.cxcx.of(timeSelectView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(screenHeight - 124)
        )
        
        timeSelectView.bringSubviewToFront(timeCollectionView)
    }
    
    func configureScrubber(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: screenWidth/2 - screenWidth/10, bottom: 0, right: screenWidth/2 - screenWidth/10)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: screenWidth / 5, height: 50)
        scrubber = UICollectionView(frame: timeSelectView.frame, collectionViewLayout: layout)
        scrubber.tag = 1
        scrubber.pagingEnabled = false
        scrubber.delegate = self
        scrubber.dataSource = self
        scrubber.registerClass(ScrubberCell.self, forCellWithReuseIdentifier: "scrubberCell")
        scrubber.backgroundColor = UIColor.clearColor()
        scrubber.showsVerticalScrollIndicator = false
        scrubber.showsHorizontalScrollIndicator = false
        scrubber.backgroundColor = UIColor.darkBlue()
        timeSelectView.addSubview(scrubber)
        
        scrubber.addConstraints(
            Constraint.tt.of(timeSelectView),
            Constraint.cxcx.of(timeSelectView),
            Constraint.w.of(screenWidth),
            Constraint.h.of(60)
        )
        timeSelectView.bringSubviewToFront(timeSelectView.scrubberCenter)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return createTabBar.selectedDates.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = timeCollectionView.dequeueReusableCellWithReuseIdentifier("timeSelectCell", forIndexPath: indexPath) as! TimeSelectCollectionViewCell
            cell.backgroundColor = UIColor.clearColor()
            
            var selectedTimeIndices = [Int]()
            if indexPath.row == 0 {
                let date = createDateWithComponents(1991, monthNumber: 4, dayNumber: 23, hourNumber: 0)
                cell.date = date
            }
            else {
                cell.date = createTabBar.selectedDates[indexPath.row - 1]
            }
            
            for time in createTabBar.selectedTimes {
                if time.fullDate() == cell.date.fullDate() {
                    let selectedTime = time.hour()
                    selectedTimeIndices.append(selectedTime)
                }
            }
            
            cell.delegate = self
            cell.configureTimes()
            cell.updateTimesStates(selectedTimeIndices)
            
            return cell
        }
        else {
            let cell = scrubber.dequeueReusableCellWithReuseIdentifier("scrubberCell", forIndexPath: indexPath) as! ScrubberCell
            
            if indexPath.row == 0 {
                cell.allDaysLabel.alpha = 0.5
                cell.dateLabel.text = ""
                cell.dayOfTheWeekLabel.text = ""
                cell.tag = indexPath.row
                
                return cell
            }
            
            if indexPath.row == scrubberSelectedIndex {
                cell.dateLabel.alpha = 1.0
                cell.dayOfTheWeekLabel.alpha = 1.0
            }
            else {
                cell.dayOfTheWeekLabel.alpha = 0.5
                cell.dateLabel.alpha = 0.5
            }
            
            cell.allDaysLabel.alpha = 0.0
            let date = createTabBar.selectedDates[indexPath.row - 1]
            cell.tag = indexPath.row
            cell.dateLabel.text = "\(date.monthAbbrevCap()) \(date.day())"
            cell.dayOfTheWeekLabel.text = "\(date.abbrevDayOfWeek())"
            
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView.tag == 1 {
            unhighlightScrubberCenter()
            
            let timePoint = CGPointMake(screenWidth * CGFloat(indexPath.row), timeCollectionView.contentOffset.y)
            let scrubPoint = CGPointMake((screenWidth / 5) * CGFloat(indexPath.row), scrubber.contentOffset.y)
            
            timeCollectionView.setContentOffset(timePoint, animated: true)
            scrubber.setContentOffset(scrubPoint, animated: true)
            
            let cell = scrubber.cellForItemAtIndexPath(indexPath) as! ScrubberCell
            scrubberSelectedIndex = cell.tag
            cell.fadeIn()
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if timesScrolling == false && scrubberScrolling == false {
            if scrollView.tag == 0{
                timesScrolling = true
            }
            else {
                scrubberScrolling = true
            }
        }
        
        if scrollView.tag == 0  && timesScrolling == true{
            let cellCount = CGFloat(createTabBar.selectedDates.count)
            let percent = scrollView.contentOffset.x/(screenWidth * cellCount)
            
            let scrubberCellWidth = cellCount * (screenWidth/5)
            scrubber.contentOffset.x = scrubberCellWidth * percent
        }
        else if scrollView.tag == 1 && scrubberScrolling == true {
            let cellCount = CGFloat(createTabBar.selectedDates.count)
            let percent = scrollView.contentOffset.x/(screenWidth/5 * cellCount)
            
            let scrubberCellWidth = cellCount * (screenWidth)
            timeCollectionView.contentOffset.x = scrubberCellWidth * percent
        }
        
        if scrollView.tag == 0 {
            let percent = scrollView.contentOffset.x/(screenWidth * CGFloat(createTabBar.selectedDates.count))
            let allDaysThreshold = screenWidth / (screenWidth * CGFloat(createTabBar.selectedDates.count))
            
            if percent <= allDaysThreshold{
                let tempPercent = percent / allDaysThreshold
                let rgb = transitionColorToColor(UIColor.whiteColor(), toColor: UIColor.blue(), percent: tempPercent)
                
                red = rgb.red
                green = rgb.green
                blue = rgb.blue
                
                timeCollectionView.backgroundColor = UIColor(red:red/256, green:green/256, blue:blue/256, alpha: 1.0)
                timeSelectView.allDaysHelpLabel.alpha = 1 - tempPercent
                timeSelectView.helpLabel.alpha = tempPercent
            }
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        unhighlightScrubberCenter()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        timesScrolling = false
        scrubberScrolling = false
        highlightScrubberCenter()
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        timesScrolling = false
        scrubberScrolling = false
    }
    
    func highlightScrubberCenter(){
        if let indexPath = scrubber.indexPathForItemAtPoint(timeSelectView.convertPoint(timeSelectView.scrubberCenter.center, toView: scrubber)) {
            let cell = scrubber.cellForItemAtIndexPath(indexPath) as! ScrubberCell
            cell.fadeIn()
            scrubberSelectedIndex = cell.tag
        }
    }
    
    func unhighlightScrubberCenter(){
        if let indexPath = scrubber.indexPathForItemAtPoint(timeSelectView.convertPoint(timeSelectView.scrubberCenter.center, toView: scrubber)) {
            let cell = scrubber.cellForItemAtIndexPath(indexPath) as! ScrubberCell
            cell.fadeOut()
        }
    }
}

extension TimeSelectViewController: TimeSelectCollectionViewCellDelegate {
    func updateSelectedTimes(date: NSDate, time: Int) {
        var newTime = createDateWithComponents(date.year(), monthNumber: date.month(), dayNumber: date.day(), hourNumber: time)
        
        // TODO: this is a crappy system. come up with a better one.
        if newTime.fullDate() == createDateWithComponents(1991, monthNumber: 4, dayNumber: 23, hourNumber: 0).fullDate(){
            if createTabBar.selectedTimes.contains(newTime){
                
                guard let index = createTabBar.selectedTimes.indexOf(newTime) else { return }
                createTabBar.selectedTimes.removeAtIndex(index)
                
                for day in createTabBar.selectedDates {
                    newTime = createDateWithComponents(day.year(), monthNumber: day.month(), dayNumber: day.day(), hourNumber: time)
                    
                    if createTabBar.selectedTimes.contains(newTime){
                        guard let index = createTabBar.selectedTimes.indexOf(newTime) else { return }
                        createTabBar.selectedTimes.removeAtIndex(index)
                    }
                }
            }
            else {
                createTabBar.selectedTimes.append(newTime)
                for day in createTabBar.selectedDates {
                    newTime = createDateWithComponents(day.year(), monthNumber: day.month(), dayNumber: day.day(), hourNumber: time)
                    if !createTabBar.selectedTimes.contains(newTime){
                        createTabBar.selectedTimes.append(newTime)
                    }
                }
            }
            return
        }
        
        if createTabBar.selectedTimes.contains(newTime){
            guard let index = createTabBar.selectedTimes.indexOf(newTime) else { return }
            createTabBar.selectedTimes.removeAtIndex(index)
        }
        else {
            createTabBar.selectedTimes.append(newTime)
        }
    }
    
    func createDateWithComponents(yearNumber: Int, monthNumber: Int, dayNumber: Int, hourNumber: Int) -> NSDate {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = yearNumber
        components.month = monthNumber
        components.day = dayNumber
        components.hour = hourNumber
        components.minute = 0
        components.second = 0
        
        components.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        guard let date = calendar?.dateFromComponents(components) else { return NSDate() }
        
        return date
    }
    
    func transitionColorToColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat){
        let fromRGB = fromColor.rgb()!
        let toRGB = toColor.rgb()!
        
        red = fromRGB.red + (percent * (toRGB.red - fromRGB.red))
        green = fromRGB.green + (percent * (toRGB.green - fromRGB.green))
        blue = fromRGB.blue + (percent * (toRGB.blue - fromRGB.blue))
        
        return (red: red, green: green, blue: blue)
    }
}



