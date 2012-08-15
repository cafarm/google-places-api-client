//
//  GPAutocompleteTermTest.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>

#import "GPMappingProvider.h"

@interface GPAutocompleteTermTest : SenTestCase
@end

@implementation GPAutocompleteTermTest

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
    id fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"autocompleteResponse.json"];
    return [[[[fixtureData valueForKey:@"predictions"] firstObject] valueForKey:@"terms"] firstObject];
}

- (RKObjectMapping *)mapping
{
    GPMappingProvider *mappingProvider = [[GPMappingProvider alloc] init];
    return [mappingProvider autocompleteTermObjectMapping];
}

- (RKMappingTest *)mappingTest
{
    return [RKMappingTest testForMapping:[self mapping] object:[self data]];
}

- (void)testMappingOfDescription
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"value" toKeyPath:@"value" withValue:@"Chipotle Mexican Grill"];
    STAssertNoThrow([mappingTest verify], nil);
}

@end
