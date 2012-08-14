//
//  GPDetailsGeometry.h
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GPDetailsGeometry : NSObject

@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;

@end
