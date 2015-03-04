//
//  ViewController.swift
//  ApWatchGPS-SKMaps
//
//  Created by Jaromir on 03.03.15.
//  Copyright (c) 2015 Baltoro. All rights reserved.
//

import UIKit
import SKMaps

class ViewController: UIViewController, SKMapViewDelegate, SKPositionerServiceDelegate, SKRoutingDelegate, SKNavigationDelegate {
	
	var mapView: SKMapView!
	var myDefaults: NSUserDefaults!
	var wormHole: MMWormhole!

	override func viewDidLoad() {
		super.viewDidLoad()

		myDefaults = NSUserDefaults(suiteName: "group.com.baltoro.ApWatchGPS-SKMaps")
		wormHole = MMWormhole(applicationGroupIdentifier: "group.com.baltoro.ApWatchGPS-SKMaps", optionalDirectory: nil)
		
		//add mapview
		mapView = SKMapView(frame: view.frame)
		mapView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
		mapView.delegate = self
//		mapView.settings.followerMode = SKMapFollowerMode.Position
		mapView.settings.showCurrentPosition = true
		view.addSubview(mapView)
		
		mapView.visibleRegion = SKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.5167, longitude: 13.3833), zoomLevel: 14)
		
		//routing
		SKRoutingService.sharedInstance().mapView = mapView
		SKPositionerService.sharedInstance().delegate = self
		SKRoutingService.sharedInstance().routingDelegate = self
		SKRoutingService.sharedInstance().navigationDelegate = self
		
		var route = SKRouteSettings()
		route.startCoordinate = CLLocationCoordinate2D(latitude: 46.773360, longitude: 23.593770)
		route.destinationCoordinate = CLLocationCoordinate2D(latitude: 46.790992, longitude: 23.530084)
		route.shouldBeRendered = true
		route.numberOfRoutes = 1
		
		
		var settings = SKAdvisorSettings()
		settings.advisorVoice = "en"
		SKRoutingService.sharedInstance().advisorConfigurationSettings = settings
		
		SKRoutingService.sharedInstance().calculateRoute(route)
//		SKRoutingService.sharedInstance().routingDelegate = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	private func saveMapImage () {
		let box = SKBoundingBox(forRegion: mapView.visibleRegion, inMapViewWithSize: CGSize(width: mapView.frame.size.width * 0.3, height: mapView.frame.size.height * 0.3))
		let libraryPath = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true).first as! String
		let path = libraryPath.stringByAppendingString("image.png")
		mapView.renderMapImageInBoundingBox(box, toPath: path, withSize: CGSize(width: 320.0, height: 237.0))
		let data = NSData(contentsOfFile: path)
		
		wormHole.passMessageObject(data, identifier: "map")
	}
	
	private func distanceStringForDistance(distance: Double, withFormat distanceFormat: SKDistanceFormat) -> NSString {
		var distanceString: NSString!
		if distanceFormat == SKDistanceFormat.Metric {
			if distance < 1000 {
				let distanceInKm = distance - (distance % 10)
				distanceString = NSString(format: "%d", distanceInKm)
			}
			if distance >= 1000 && distance < 10000 {
				let distanceInKm = Float(distance/1000)
				distanceString = NSString(format: "%.1f", distanceInKm)
			}
			if distance >= 10000 {
				let distanceInKm = distance/1000
				distanceString = NSString(format: "%d", distanceInKm)
			}
		} else {
			if Double(distance) <= 1500/3.8084 {
				let distanceInFeet = distance * 3.28084 - Double((Int(distance * 3.28084)) % 10)
				distanceString = NSString(format:"%d",distanceInFeet)
			}
			if distance > 1500/3.28084 && distance < 1609.34 * 10 {
				let distanceInMiles = Float(distance)/1609.34 * 10
				distanceString = NSString(format: "%.1f", distanceInMiles)
			}
			if Double(distance) > 1609.34 * 10 {
				let distanceInMiles = Int(distance/1609.34)
				distanceString = NSString(format: "%d", distanceInMiles)
			}
		}
		return distanceString
	}
	
	//MARK: Delegate methods
	
	func positionerService(positionerService: SKPositionerService!, updatedCurrentLocation currentLocation: CLLocation!) {
		println("distance")
		
	}
	
	func routingService(routingService: SKRoutingService!, didFinishRouteCalculationWithInfo routeInformation: SKRouteInformation!) {
		println("distance")
		
	}
	
	func routingServiceDidCalculateAllRoutes(routingService: SKRoutingService!) {
		var navSettings = SKNavigationSettings()
		navSettings.navigationType = SKNavigationType.Simulation
		navSettings.distanceFormat = SKDistanceFormat.Metric
		mapView.settings.displayMode = SKMapDisplayMode.Mode2D
		SKRoutingService.sharedInstance().startNavigationWithSettings(navSettings)
//		SKRoutingService.sharedInstance().navigationDelegate = self
	}
	
	func routingService(routingService: SKRoutingService!, didChangeCurrentAdviceImage adviceImage: UIImage!, withLastAdvice isLastAdvice: Bool) {
		println("distance")
		let imageData = UIImagePNGRepresentation(adviceImage)
		wormHole.passMessageObject(imageData, identifier: "image")
	}
	
	func routingService(routingService: SKRoutingService!, didChangeCurrentVisualAdviceDistance distance: Int32, withFormattedDistance formattedDistance: String!) {
		println("distance")
		wormHole.passMessageObject(formattedDistance, identifier: "distance")
	}
	
	func routingService(routingService: SKRoutingService!, didChangeNextStreetName nextStreetName: String!, streetType: SKStreetType, countryCode: String!) {
		println("distance")
		wormHole.passMessageObject(nextStreetName, identifier: "nextStreet")
	}
	
	func routingService(routingService: SKRoutingService!, didChangeCurrentSpeed speed: Double) {
		println("distance")
		let speedString = distanceStringForDistance(speed, withFormat: SKDistanceFormat.Metric)
		wormHole.passMessageObject(speedString, identifier: "speed")
	}
	
}

