//
//  WindoProfileImageView.swift
//  Windo
//
//  Created by Joey on 6/17/16.
//  Copyright © 2016 NelsonJE. All rights reserved.
//

import UIKit

class WindoProfileImageView: UIView {
    
    //MARK: Properties
    private var cachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
    private var blurRadius: CGFloat?
    private var urlString: String?
    private var request: NSMutableURLRequest?
    private var task: NSURLSessionDataTask?
    
    var imageView = UIImageView()
    var initals = UILabel()
    
    //MARK: Inits
//    convenience init(width: CGFloat, userProfile: UserProfile, fetchImage: Bool = true) {
//        self.init(frame: CGRectZero)
//        self.user = userProfile
//        self.width = width
//        
//        if fetchImage {
//            self.fetchProfileImage()
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Configuration
    
    override func updateConstraints() {
        super.updateConstraints()
        configureSubviews()
        applyConstraints()
    }
    
    func configureSubviews(){
        clipsToBounds = true
        
        imageView.contentMode = .ScaleAspectFill
        
        initals.textAlignment = .Center
        
        addSubview(initals)
        addSubview(imageView)
    }
    
    func applyConstraints(){
        initals.addConstraints(
            Constraint.llrr.of(self),
            Constraint.ttbb.of(self)
        )
        
        imageView.addConstraints(
            Constraint.llrr.of(self),
            Constraint.ttbb.of(self)
        )
    }
    
    func setupView(user: UserProfile, width: CGFloat, withCachePolicy cachePolicy: NSURLRequestCachePolicy = .ReturnCacheDataElseLoad, blurRadius: CGFloat? = nil) {
        // Don't bother reloading if the url isn't changing, unless the cache policy reqeusts it
        if user.profilePictureURL == self.urlString &&
            cachePolicy != .ReloadIgnoringCacheData &&
            cachePolicy != .ReloadIgnoringLocalCacheData &&
            cachePolicy != .ReloadIgnoringLocalAndRemoteCacheData {
            return
        }
        // Note: Image access must occur on main queue
        initals.text = user.getInitials()
        layer.cornerRadius = width/2
        initals.font = UIFont.graphikRegular(width/2)
//        self.placeholderView.alpha = 1
        
        
        self.urlString = user.profilePictureURL
        self.cachePolicy = cachePolicy
        self.blurRadius = blurRadius
        // Cancel any in-progress image downloads
        self.task?.cancel()
        // Execute current download
        self.executeQuery()
    }
    
    
    /// Attempts to download an image from the given URL, and displays it once the download has completed.
    /// This must be called from the background queue.
    private func executeQuery() {
        guard let urlString = self.urlString else {
            return
        }
        guard let url = NSURL(string: urlString) else {
            return
        }
        // Only need to initialize request once; afterwards we just reset the URL and task object
        if self.request == nil {
            self.request = NSMutableURLRequest(URL: url)
            self.request!.cachePolicy = self.cachePolicy
        } else {
            self.request!.URL = url
        }
        self.task = NSURLSession.sharedSession().dataTaskWithRequest(self.request!, completionHandler: { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let imageData = data else {
                return
            }
            guard let image = UIImage(data: imageData) else {
                return
            }
            // Blur image if requested
//            let outputImage = image.blurredImageWithRadius(self.blurRadius)
            // Display image on main queue
            dispatch_async(dispatch_get_main_queue()) {
                
                // Animate the placeholder view away
                UIView.animateWithDuration(0.2) {
                    self.imageView.image = image
//                    self.placeholderView.alpha = 0
                }
            }
        })
        self.task?.resume()
    }
}