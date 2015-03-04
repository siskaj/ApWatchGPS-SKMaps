//
//  SKAnnotation.h
//  SKMaps
//
//  Copyright (c) 2015 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import "SKDefinitions.h"

@class SKAnnotationView;

/** The SKAnnotation is used for presenting annotations visually on the map view. The image of the annotation can be either a predefined one (using annotationType property) or a custom one (using imagePath and imageSize properties).
 */
@interface SKAnnotation : NSObject

/** A unique identifier for the annotation.
 */
@property(nonatomic, assign) int identifier;

/** The annotation type from a predefined list. The default value is SKAnnotationTypeBlue.
 */
@property(nonatomic, assign) SKAnnotationType annotationType;

/** Used for positioning the annotation image around the location. By default, the center of the image will coincide with the location.
 */
@property(nonatomic, assign) CGPoint offset;

/** The coordinate where the annotation should be added.
 */
@property(nonatomic, assign) CLLocationCoordinate2D location;

/** The minimum zoom level on which the annotation will be visible.
 */
@property(nonatomic, assign) int minZoomLevel;

/** Object containing a UIView which will represent the annotation image.
 */
@property(nonatomic) SKAnnotationView *annotationView;

/** A newly initialized SKAnnotation.
 */
+ (instancetype)annotation;

#pragma mark - Deprecated

/** The absolute path to the image file to be added as an annotation. The image must be a square image and the size must be a power of 2. ( 32x32, 64x64, etc. ). DEPRECATED: Use the annotationView property for displaying custom images as annotations.
 */
@property(nonatomic) NSString *imagePath DEPRECATED_ATTRIBUTE;

/** The size of the image (width and height) in pixels. DEPRECATED: Use the annotationView property for displaying custom images as annotations.
 */
@property(nonatomic, assign) int imageSize DEPRECATED_ATTRIBUTE;

@end
