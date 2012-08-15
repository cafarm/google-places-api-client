//
//  GPDetailsLocation.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import "GPDetailsLocation.h"

@implementation GPDetailsLocation

@synthesize latitude;
@synthesize longitude;

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
}

@end
