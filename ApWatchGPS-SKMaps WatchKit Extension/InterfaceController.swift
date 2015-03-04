//
//  InterfaceController.swift
//  ApWatchGPS-SKMaps WatchKit Extension
//
//  Created by Jaromir on 03.03.15.
//  Copyright (c) 2015 Baltoro. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

	
	@IBOutlet weak var adviceButton: WKInterfaceButton!
	@IBOutlet weak var nextStreetLabel: WKInterfaceLabel!
	@IBOutlet weak var distanceLabel: WKInterfaceLabel!
	let wormHole: MMWormhole!
	
	var mapMode: Bool
	var myDefaults: NSUserDefaults!
	var adviceData: NSData!
	var mapData: NSData!
	
	override init() {
		wormHole = MMWormhole(applicationGroupIdentifier:"group.com.baltoro.ApWatchGPS-SKMaps", optionalDirectory: nil)
		mapMode = false
		super.init()
	}
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
//			wormHole = MMWormhole(applicationGroupIdentifier:"group.com.baltoro.ApWatchGPS-SKMaps", optionalDirectory: nil)
			
    }

    override func willActivate() {
			super.willActivate()
			startListeningForMessages()
    }

    override func didDeactivate() {
			stopListeningForMessages()
			super.didDeactivate()
    }

	private func startListeningForMessages() {
		wormHole.listenForMessageWithIdentifier("distance") { messageObject in
			if let distance = messageObject as? String {
				self.distanceLabel.setText(distance)
			}
		}
		
		wormHole.listenForMessageWithIdentifier("nextStreet") { messageObject in
			if let nextStreetName = messageObject as? String {
				self.distanceLabel.setText(nextStreetName)
			}
		}

		wormHole.listenForMessageWithIdentifier("speed") { messageObject in
			if let speed = messageObject as? String {
				self.distanceLabel.setText(speed)
			}
		}

		wormHole.listenForMessageWithIdentifier("map") { messageObject in
			if let messageObject: NSData = messageObject as? NSData {
				self.mapData = messageObject
				self.setButtonBackgroundImage()
			}
		}

		wormHole.listenForMessageWithIdentifier("image") { messageObject in
			if let messageObject: NSData = messageObject as? NSData {
				self.adviceData = messageObject
				self.setButtonBackgroundImage()
			}
		}
	}
	
	private func stopListeningForMessages() {
		wormHole.stopListeningForMessageWithIdentifier("distance")
		wormHole.stopListeningForMessageWithIdentifier("nextStreet")
		wormHole.stopListeningForMessageWithIdentifier("speed")
	}
	
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
