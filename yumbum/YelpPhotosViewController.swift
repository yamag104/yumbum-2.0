//
//  YelpPhotosViewController.swift
//  yumbum
//
//  Created by Yoko Yamaguchi on 12/3/15.
//  Copyright © 2015 Yoko Yamaguchi. All rights reserved.
//

import UIKit
import SDWebImage
import MapKit

class YelpPhotosViewController: UICollectionViewController {

    private let locationManager = LocationManager()
    private let reuseIdentifier = "YelpCell"
    private var searches: Array<YelpData> = []
    
    override func viewDidLoad() {
        searches = locationManager.searches
        self.collectionView?.reloadData()
    }
    
    //1
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //2
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches.count
    }
    
    //3
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        NSLog("Size: \(searches.count)")
        //1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! YelpPhotoCell
        if searches.count > 0 {
            let yelp = searches[indexPath.row] as YelpData
            self.title = "\(yelp.city), \(yelp.state)"
            cell.nameLabel.text = searches[indexPath.row].name as String
            cell.nameLabel.textColor = UIColor.whiteColor()
            cell.yelpImageView.sd_setImageWithURL(yelp.imageUrl, placeholderImage: UIImage(named: "doughnut.png"))
            cell.yelpImageView.contentMode = .ScaleAspectFill
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if searches.count > 0 {
            let yelp = searches[indexPath.row] as YelpData
            openMap(yelp)
        }
    }
    
    func openMap(yelp: YelpData) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(yelp.latitude, yelp.longtitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = yelp.name
        mapItem.openInMapsWithLaunchOptions(options)
        
    }

    @IBAction func refresh(sender: AnyObject) {
        searches = result.searchResults
        
        self.collectionView?.reloadData()
    }
}
