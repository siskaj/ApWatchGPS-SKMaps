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

	override func viewDidLoad() {
		super.viewDidLoad()

		//add mapview
		mapView = SKMapView(frame: view.frame)
		mapView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
		mapView.delegate = self
		mapView.settings.followerMode = SKMapFollowerMode.Position
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
		route.numberOfRoutes = 1
		
		SKRoutingService.sharedInstance().calculateRoute(route)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	private func saveMapImage () {
		
	}
	
	func routingServiceDidCalculateAllRoutes(routingService: SKRoutingService!) {
		var navSettings = SKNavigationSettings()
		navSettings.navigationType = SKNavigationType.Simulation
		navSettings.distanceFormat = SKDistanceFormat.Metric
		mapView.settings.displayMode = SKMapDisplayMode.Mode2D
		SKRoutingService.sharedInstance().startNavigationWithSettings(navSettings)
	}
}

