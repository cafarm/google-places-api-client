//
//  GPDetailsLocationTest.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>

#import "GPMappingProvider.h"
#import "GPDetailsLocation.h"

@interface GPDetailsLocationTest : SenTestCase
@end

@implementation GPDetailsLocationTest

- (void)setUp
{
    [RKTestFactory setUp];
}

- (void)tearDown
{
    [RKTestFactory tearDown];
}

- (id)data
{
    id fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"detailsResponse.json"];
    return [[[fixtureData valueForKey:@"result"] valueForKey:@"geometry"] valueForKey:@"location"];
}

- (RKObjectMapping *)mapping
{
    GPMappingProvider *mappingProvider = [[GPMappingProvider alloc] init];
    return [mappingProvider detailsLocationObjectMapping];
}

- (RKMappingTest *)mappingTest
{
    return [RKMappingTest testForMapping:[self mapping] object:[self data]];
}

- (void)testMappingOfCoordinate
{
    GPDetailsLocation *location = [[GPDetailsLocation alloc] init];
    RKMappingTest *mappingTest = [RKMappingTest testForMapping:[self mapping] sourceObject:[self data] destinationObject:location];
    [mappingTest performMapping];
    STAssertTrue(location.coordinate.latitude == 47.6099030, nil);
    STAssertTrue(location.coordinate.longitude == -122.3377170, nil);
}

@end
