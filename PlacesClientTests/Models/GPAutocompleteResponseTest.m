//
//  GPAutocompleteResponseTest.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>

#import "GPMappingProvider.h"
#import "GPAutocompleteResponse.h"
#import "GPAutocompletePrediction.h"

@interface GPAutocompleteResponseTest : SenTestCase
@end

@implementation GPAutocompleteResponseTest

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
    return [RKTestFixture parsedObjectWithContentsOfFixture:@"autocompleteResponse.json"];
}

- (RKObjectMapping *)mapping
{
    GPMappingProvider *mappingProvider = [[GPMappingProvider alloc] init];
    return [mappingProvider autocompleteResponseObjectMapping];
}

- (RKMappingTest *)mappingTest
{
    return [RKMappingTest testForMapping:[self mapping] object:[self data]];
}

- (void)testMappingOfStatus
{
    GPAutocompleteResponse *response = [[GPAutocompleteResponse alloc] init];
    RKMappingTest *mappingTest = [RKMappingTest testForMapping:[self mapping] sourceObject:[self data] destinationObject:response];
    [mappingTest performMapping];
    STAssertTrue(response.status == GPOk, nil);
}

- (void)testMappingOfPredictions
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"predictions" toKeyPath:@"predictions" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [value isKindOfClass:[NSArray class]] && [value count] == 5;
    }];
    STAssertNoThrow([mappingTest verify], nil);
}

@end
