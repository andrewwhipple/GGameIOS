//
//  GGame.swift
//  GeoGame
//
//  Created by Andrew Whipple on 8/17/15.
//  Copyright © 2015 Andrew Whipple. All rights reserved.
//

import Foundation
import CoreLocation

class GGame: NSObject {
    var state = GeoGameState()
    var regions = [CLCircularRegion]()
    
    private var latitudes = [37.424135, 37.422014]
    private var longitudes = [-122.146621, -122.155054]
    private var ids = ["sound", "sound2"]
    
    override init() {
        for index in 0...1 {
           var geoCenter = CLLocationCoordinate2D(latitude: latitudes[index], longitude: longitudes[index])
            var geoRadius = CLLocationDistance(50.0)
            var geoID = ids[index]
            
            var geoRegion = CLCircularRegion(center: geoCenter, radius: geoRadius, identifier: geoID)
            regions.append(geoRegion)
            
        }
    }
}
