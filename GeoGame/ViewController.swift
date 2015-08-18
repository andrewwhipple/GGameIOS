//
//  ViewController.swift
//  GeoGame
//
//  Created by Andrew Whipple on 8/14/15.
//  Copyright © 2015 Andrew Whipple. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latLongLabel: UILabel!
    
    
    //Hopfully deprecated by GGameState!
    var gameStarted = false
    var gameNotOver = true
    
    var audioPlayer = AVAudioPlayer()
    var manager = CLLocationManager()
    
    var locationsToAudio = ["meow":"sound", "rawr": "sound2"]
    
    var geoRegion1 = CLCircularRegion()
    var geoRegion2 = CLCircularRegion()
    //Registers the geofences
    // (Hopefully will be deprecated by initialization of the GGame!
    func registerLocations() {
        print("In registerLocations")
        var geoCenter = CLLocationCoordinate2D(latitude: 37.424135, longitude: -122.146621)
        var geoRadius = CLLocationDistance(50.0)
        var geoID = "meow"
        geoRegion1 = CLCircularRegion(center: geoCenter, radius: geoRadius, identifier: geoID)
        
        //manager.startUpdatingLocation()
        
        manager.startMonitoringForRegion(geoRegion1)
        
        geoCenter = CLLocationCoordinate2D(latitude: 37.422014, longitude: -122.155054)
        geoRadius = CLLocationDistance(50.0)
        geoID = "rawr"
        geoRegion2 = CLCircularRegion(center: geoCenter, radius: geoRadius, identifier: geoID)
        
        //manager.startUpdatingLocation()
        
        manager.startMonitoringForRegion(geoRegion2)
        
        print("end of registerlocations")
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered region")
        let alertController = UIAlertController(title: "iOScreator", message: "Hello world!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        let regionID = region.identifier
        
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(locationsToAudio[regionID], ofType: "mp3")!)

        print(alertSound)
        

        do {
           try audioPlayer = AVAudioPlayer(contentsOfURL: alertSound)
        } catch {
            
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lati = locations[0].coordinate.latitude
        let longi = locations[0].coordinate.longitude
        
        latLongLabel.text = "Lat: \(lati), Long: \(longi)"
        

    }
    
    /*
    func getCurrentLocation() -> GeoGameLocation {
        
    }
    
    func getCurrentGameState() -> GeoGameState {
        
    }
    
    func loadLocations() {
        
    }
    
    func checkSound(location: GeoGameLocation, gameState: GeoGameState) {
        
    }*/
    @IBOutlet weak var gameButtonLabel: UIButton!
    
    @IBAction func startGameButton(sender: UIButton) {
        if !gameStarted {
            gameStarted = true
            gameNotOver = true
            
            manager.delegate = self
            manager.requestAlwaysAuthorization()
            //loadLocations()
            registerLocations()
            gameButtonLabel.setTitle("Stop Game", forState: UIControlState.Normal)
            gameLoop()
        } else {
            gameStarted = false
            manager.stopMonitoringForRegion(geoRegion1)
            manager.stopMonitoringForRegion(geoRegion2)
        }
    
    }
    
    
    func gameLoop() {
        //let curLocation = getCurrentLocation()
        //let curGameState = getCurrentGameState()
        //checkSound(curLocation, gameState: curGameState)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

