//
//  YelpClient.swift
//  yumbum
//
//  Created by Yoko Yamaguchi on 12/3/15.
//  Copyright © 2015 Yoko Yamaguchi. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift

let kConsumerKey    = "oXElUoT3W_-PHpVdbPHssQ"
let kConsumerSecret = "oMXHG8jYD2D-TXPliYFcNyn20Cw"
let kToken          = "BHVlr1H1UuH11z3v83mVhfEZ0ZoDvteo"
let kTokenSecret    = "exaZCgd8pXw09W_p-PYoA1jL41c"

struct result {
    static var searchResults : [YelpData] = []
}

class YelpClient {
    var ll = ""
    
    init(ll:String){
        self.ll = ll
        yelpOAuth()
    }
    
    func yelpOAuth() {
        let oauthswift = OAuthSwiftClient(
            consumerKey: kConsumerKey,
            consumerSecret: kConsumerSecret,
            accessToken: kToken,
            accessTokenSecret: kTokenSecret
        )
        
        let url = "https://api.yelp.com/v2/search?term=food&ll=\(ll)"
        oauthswift.get(url,
            success: { (data, res) -> Void in
                do {
                    if let jsonResult: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary {
                        if jsonResult is NSDictionary {
                            let json = jsonResult as! NSDictionary
                            let results = json.valueForKey("businesses")! as! NSArray
//                            print(results)
                            for value in results {
                                let yelp = YelpData()
                                yelp.name = value.valueForKey("name") as! String
//                                NSLog("Name: \(yelp.name)")
                                yelp.imageUrl = NSURL(string: value.valueForKey("image_url") as! String)!
//                                NSLog("ImageURL: \(yelp.imageUrl)")
                                let location = value.valueForKey("location") as! NSDictionary
                                yelp.address = (location.valueForKey("address") as! Array).joinWithSeparator(",")
                                yelp.city = location.valueForKey("city") as! String
                                yelp.state = location.valueForKey("state_code") as! String
                                let coordinate = location.valueForKey("coordinate") as! NSDictionary
                                yelp.latitude = Double(coordinate.valueForKey("latitude")!.stringValue)!
                                yelp.longtitude = Double(coordinate.valueForKey("longitude")!.stringValue)!
                                NSLog("\(yelp.latitude) AND \(yelp.longtitude)")
                                result.searchResults.append(yelp)
                            }
                        }
                        NSLog("\(result.searchResults.count)")
                    }
                } catch {
                    print("Error")
                }
            }, failure: nil)
    }

}
