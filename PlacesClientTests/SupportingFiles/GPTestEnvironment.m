//
//  GPTestEnvironment.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import "GPTestEnvironment.h"

@implementation RKTestFactory (PlacesClient)

+ (void)didInitialize
{
    [RKTestFixture setFixtureBundle:[NSBundle bundleWithIdentifier:@"com.sevenoeight.PlacesClientTests"]];
}

@end
