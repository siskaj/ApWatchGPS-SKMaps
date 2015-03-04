//
//  InterfaceController.swift
//  ApWatchGPS-SKMaps WatchKit Extension
//
//  Created by Jaromir on 03.03.15.
//  Copyright (c) 2015 Baltoro. All rights reserved.
//

import WatchKit
import Foundation

let API_KEY: String = "1d68ee9f95a8d885d94e026d6f10ba1dea5391327676a6a41d1011110a55bc45" // moje API_KEY

class InterfaceController: WKInterfaceController, SKRoutingDelegate, SKNavigationDelegate {

	
	@IBOutlet weak var adviceButton: WKInterfaceButton!
	@IBOutlet weak var nextStreetLabel: WKInterfaceLabel!
	@IBOutlet weak var distanceLabel: WKInterfaceLabel!
	
	var mapMode: Bool
	var myDefaults: NSUserDefaults!
	var adviceData: NSData!
	var mapData: NSData!
	
	override init() {
		mapMode = false
		super.init()
    var initSettings: SKMapsInitSettings = SKMapsInitSettings()
    SKMapsService.sharedInstance().initializeSKMapsWithAPIKey(API_KEY, settings: initSettings)
    SKPositionerService.sharedInstance().startLocationUpdate()
    SKRoutingService.sharedInstance().routingDelegate = self
    SKRoutingService.sharedInstance().navigationDelegate = self
	}
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
      var route = SKRouteSettings()
      route.startCoordinate = CLLocationCoordinate2D(latitude: 46.773360, longitude: 23.593770)
      route.destinationCoordinate = CLLocationCoordinate2D(latitude: 46.790992, longitude: 23.530084)
      route.shouldBeRendered = true
      route.numberOfRoutes = 1

      SKRoutingService.sharedInstance().calculateRoute(route)
}

    override func willActivate() {
			super.willActivate()
    }

    override func didDeactivate() {
			super.didDeactivate()
    }

  func routingServiceDidCalculateAllRoutes(routingService: SKRoutingService!) {
    var navSettings = SKNavigationSettings()
    navSettings.navigationType = SKNavigationType.Simulation
    navSettings.distanceFormat = SKDistanceFormat.Metric
    SKRoutingService.sharedInstance().startNavigationWithSettings(navSettings)
  }
  
  func routingService(routingService: SKRoutingService!, didChangeCurrentVisualAdviceDistance distance: Int32, withFormattedDistance formattedDistance: String!) {
    println("distance")
    distanceLabel.setText(formattedDistance)
  }
  

//	private func startListeningForMessages() {
//		wormHole.listenForMessageWithIdentifier("distance") { messageObject in
//			if let distance = messageObject as? String {
//				self.distanceLabel.setText(distance)
//			}
//		}
//		
//		wormHole.listenForMessageWithIdentifier("nextStreet") { messageObject in
//			if let nextStreetName = messageObject as? String {
//				self.distanceLabel.setText(nextStreetName)
//			}
//		}
//
//		wormHole.listenForMessageWithIdentifier("speed") { messageObject in
//			if let speed = messageObject as? String {
//				self.distanceLabel.setText(speed)
//			}
//		}
//
//		wormHole.listenForMessageWithIdentifier("map") { messageObject in
//			if let messageObject: NSData = messageObject as? NSData {
//				self.mapData = messageObject
//				self.setButtonBackgroundImage()
//			}
//		}
//
//		wormHole.listenForMessageWithIdentifier("image") { messageObject in
//			if let messageObject: NSData = messageObject as? NSData {
//				self.adviceData = messageObject
//				self.setButtonBackgroundImage()
//			}
//		}
//	}
//	
//	private func stopListeningForMessages() {
//		wormHole.stopListeningForMessageWithIdentifier("distance")
//		wormHole.stopListeningForMessageWithIdentifier("nextStreet")
//		wormHole.stopListeningForMessageWithIdentifier("speed")
//	}
	
	private func setButtonBackgroundImage() {
		if mapMode {
			adviceButton.setBackgroundImageData(mapData)
		} else {
			adviceButton.setBackgroundImageData(adviceData)
		}
	}
	
	@IBAction func distanceButtonPressed() {
		if mapMode { mapMode = false } else { mapMode = true }
		setButtonBackgroundImage()
	}
	
	
}
