//
//  SKNavigationSettings.h
//  SKMaps
//
//  Copyright (c) 2015 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKDefinitions.h"

@class SKTrailSettings;

/** SKNavigationSettings stores settings for a navigation session.
 */
@interface SKNavigationSettings : NSObject

/** The distance format for audio and visual advices. The default value is SKDistanceFormatMetric.
 */
@property(nonatomic, assign) SKDistanceFormat distanceFormat;

/** The transportation mode of the navigation. Default is SKTransportCar.
 */
@property(nonatomic, assign) SKTransportMode transportMode;

/** Used for changing the position of the car position icon on the vertical and horizontal axis. It is a scale which indicates the distance between the icon and the center of the screen (in [ -0.5, 0.5 ] interval).
 The default value is -0.25.
 */
@property(nonatomic, assign) SKPositionerAlignment positionerAlignment;

/** Sets the threshold for speed warning callbacks in and outside cities. If the current speed is greater than current speed limit + the speedWarningThreshold, the routingService:didUpdateSpeedWarningToStatus:withAudioWarnings:insideCity: callback from the SKNavigationDelegate is called. 
 */
@property(nonatomic, assign) SKSpeedWarningThreshold speedWarningThreshold;

/** The zoomLevelConfigurations is used for automatic zooming during navigation based on device's speed. It must contain only SKZoomLevelConfiguration objects. By default it is nil which means that the automatic zooming is disabled.
 */
@property(nonatomic, strong) NSArray *zoomLevelConfigurations;

/** If enabled, the route behind current position will be hidden. Default is NO.
 */
@property(nonatomic, assign) BOOL enableSplitRoute;

#pragma mark - Debug settings

/** The positioning type of the navigation.
 */
@property(nonatomic, assign) SKNavigationType navigationType;

/** Enables the displaying of real, unmatched GPS positions, for debug purposes.
 */
@property(nonatomic, assign) BOOL showRealGPSPositions;

/** The viapoint notification distance. The routingService:didEnterViaPointArea: and routingService:didExitViaPointArea: are called from the SKNavigationDelegate based in this given distance. The default value is 200 meters.
 */
@property(nonatomic, assign) int viaPointNotificationDistance;
#pragma mark - Factory method

/** A newly initialized SKNavigationSettings.
 */
+ (instancetype)navigationSettings;

#pragma mark - Deprecated

/** Used for changing the position of the car position icon on the vertical axis. It is a scale which indicates the distance between the icon and the center of the screen (in [ -0.5, 0.5 ] interval).
 The default value is -0.25. DEPRECATED: Use the vertical member of the positionerAlignment property.
 */
@property(nonatomic, assign) float positionerVerticalAlignment DEPRECATED_ATTRIBUTE;

/** Used for changing the position of the car position icon on the horizontal axis. It is a scale which indicates the distance between the icon and the center of the screen (in [ -0.5, 0.5 ] interval).
 The default value is 0. DEPRECATED: Use the horizontal member of the positionerAlignment property.
 */
@property(nonatomic, assign) float positionerHorizontalAlignment DEPRECATED_ATTRIBUTE;

/** Sets the threshold for speed warning callbacks inside cities. If the current speed is greater than current speed limit + speedWarningThresholdInCity, the routingService:didUpdateSpeedWarningToStatus:withAudioWarnings:insideCity: callback from the SKNavigationDelegate is called. DEPRECATED: Use the inCity member of the speedWarningThreshold property.
 */
@property(nonatomic, assign) double speedWarningThresholdInCity DEPRECATED_ATTRIBUTE;

/** Sets the threshold for speed warning callbacks outside cities. If the current speed is greater than current speed limit + speedWarningThresholdOutsideCity, the routingService:didUpdateSpeedWarningToStatus:withAudioWarnings:insideCity: callback from the SKNavigationDelegate is called. DEPRECATED: Use the outsideCity member of the speedWarningThreshold property.
 */
@property(nonatomic, assign) double speedWarningThresholdOutsideCity DEPRECATED_ATTRIBUTE;

/** Marks the path behind the current position with trail settings. DEPRECATED: Use the trailSettings property of the SKMapSettings object.
 */
@property(nonatomic, strong) SKTrailSettings *trail DEPRECATED_ATTRIBUTE;

@end
