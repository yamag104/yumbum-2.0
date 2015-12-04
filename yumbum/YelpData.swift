//
//  YelpItem.swift
//  yumbum
//
//  Created by Yoko Yamaguchi on 12/2/15.
//  Copyright © 2015 Yoko Yamaguchi. All rights reserved.
//

import UIKit

class YelpData: NSObject {
    var name = String()
    var imageUrl = NSURL()
    var address = String()
    var state = String()
    var city = String()
    var latitude = 0.0
    var longtitude = 0.0
    
    override init() {
        name = ""
        imageUrl = NSURL.init()
        address = ""
        state = ""
        city = ""
    }
}
