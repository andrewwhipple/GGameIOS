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
    
    var gGame = GGame()
    
    @IBOutlet weak var latLongLabel: UILabel!
    
    
    var audioPlayer = AVAudioPlayer()
    var manager = CLLocationManager()
 

    //Registers the geofences
    // (Hopefully will be deprecated by initialization of the GGame!
    
    
    func registerLocations() {
        print("In registerLocations")
        
        for region in gGame.regions {
            manager.startMonitoringForRegion(region)
        }
        
        /*var geoCenter = CLLocationCoordinate2D(latitude: 37.424953, longitude: -122.136712)
        var geoRadius = CLLocationDistance(50.0)
        var geoID = "meow"
        geoRegion1 = CLCircularRegion(center: geoCenter, radius: geoRadius, identifier: geoID)
        
        //manager.startUpdatingLocation()
        
        manager.startMonitoringForRegion(geoRegion1)
        
        geoCenter = CLLocationCoordinate2D(latitude: 37.424426, longitude: -122.136829)
        geoRadius = CLLocationDistance(50.0)
        geoID = "rawr"
        geoRegion2 = CLCircularRegion(center: geoCenter, radius: geoRadius, identifier: geoID)
        
        //manager.startUpdatingLocation()
        
        manager.startMonitoringForRegion(geoRegion2)*/
        
        print("end of registerlocations")
        
        /*
        

        */
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered region")
        let alertController = UIAlertController(title: "iOScreator", message: "Hello world!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        let regionID = region.identifier
        
        let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(regionID, ofType: "mp3")!)

        print(sound)
        

        do {
           try audioPlayer = AVAudioPlayer(contentsOfURL: sound)
        } catch {
            
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    //Currently unused dev tool to visually check location
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
        
        
        
        if !gGame.state.gameStarted {
            gGame.state.gameStarted = true
            gGame.state.gameEnded = true
            
            manager.delegate = self
            manager.requestAlwaysAuthorization()
            //loadLocations()
            registerLocations()
            gameButtonLabel.setTitle("Stop Game", forState: UIControlState.Normal)
            
        } else {
            gGame.state.gameStarted = false
            gGame.state.gameEnded = true
            for region in gGame.regions {
                manager.stopMonitoringForRegion(region)
            }
            gameButtonLabel.setTitle("Start Game", forState: UIControlState.Normal)
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

