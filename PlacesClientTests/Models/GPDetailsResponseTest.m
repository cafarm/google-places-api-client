//
//  GPDetailsResponseTest.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>

#import "GPMappingProvider.h"
#import "GPDetailsResponse.h"
#import "GPDetailsResult.h"

@interface GPDetailsResponseTest : SenTestCase
@end

@implementation GPDetailsResponseTest

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
    return [RKTestFixture parsedObjectWithContentsOfFixture:@"detailsResponse.json"];
}

- (RKObjectMapping *)mapping
{
    GPMappingProvider *mappingProvider = [[GPMappingProvider alloc] init];
    return [mappingProvider detailsResponseObjectMapping];
}

- (RKMappingTest *)mappingTest
{
    return [RKMappingTest testForMapping:[self mapping] object:[self data]];
}

- (void)testMappingOfStatus
{
    GPDetailsResponse *response = [[GPDetailsResponse alloc] init];
    RKMappingTest *mappingTest = [RKMappingTest testForMapping:[self mapping] sourceObject:[self data] destinationObject:response];
    [mappingTest performMapping];
    STAssertTrue(response.status == GPOk, nil);
}

- (void)testMappingOfResult
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"result" toKeyPath:@"result" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [value isKindOfClass:[GPDetailsResult class]] && value != nil;
    }];
    STAssertNoThrow([mappingTest verify], nil);
}

@end
