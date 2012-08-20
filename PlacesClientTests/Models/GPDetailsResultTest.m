//
//  GPDetailsResultTest.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>

#import "GPMappingProvider.h"
#import "GPDetailsGeometry.h"
#import "GPDetailsResult.h"

@interface GPDetailsResultTest : SenTestCase
@end

@implementation GPDetailsResultTest

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
    return [fixtureData valueForKey:@"result"];
}

- (RKObjectMapping *)mapping
{
    GPMappingProvider *mappingProvider = [[GPMappingProvider alloc] init];
    return [mappingProvider detailsResultObjectMapping];
}

- (RKMappingTest *)mappingTest
{
    return [RKMappingTest testForMapping:[self mapping] object:[self data]];
}

- (void)testMappingOfName
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"name" toKeyPath:@"name" withValue:@"Chipotle Mexican Grill"];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfGeometry
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"geometry" toKeyPath:@"geometry" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [value isKindOfClass:[GPDetailsGeometry class]] && value != nil;
    }];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfTypes
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"types" toKeyPath:@"types" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [value isKindOfClass:[NSArray class]] && [((NSArray *)value) containsObject:[NSNumber numberWithInt:GPDetailsResultTypeEstablishment]];
    }];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfVicinity
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"vicinity" toKeyPath:@"vicinity" withValue:@"1501 4th Avenue #114, Seattle"];
    STAssertNoThrow([mappingTest verify], nil);
}

@end
