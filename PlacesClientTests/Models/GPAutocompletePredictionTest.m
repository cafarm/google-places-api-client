//
//  GPAutocompletePredictionTest.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>

#import "GPMappingProvider.h"

@interface GPAutocompletePredictionTest : SenTestCase
@end

@implementation GPAutocompletePredictionTest

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
    return [[fixtureData valueForKey:@"predictions"] firstObject];
}

- (RKObjectMapping *)mapping
{
    GPMappingProvider *mappingProvider = [[GPMappingProvider alloc] init];
    return [mappingProvider autocompletePredictionObjectMapping];
}

- (RKMappingTest *)mappingTest
{
    return [RKMappingTest testForMapping:[self mapping] object:[self data]];
}

- (void)testMappingOfDescription
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"description" toKeyPath:@"description" withValue:@"Chipotle Mexican Grill, 4th Avenue, Seattle, WA, United States"];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfReference
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"reference" toKeyPath:@"reference" withValue:@"CoQBdwAAAEdboelq1A0WAnx5owe7C-AXqyTZYmIxWsJU5LvBBnffgiqOUOVrwKBxdAUFrI0K9WdEvi1xzijctqwA-a_UUZxUCPjcGXgTzfQQ1wkMliQ40ntEMAnJ08Zg-QBCPM9HxauBGm86vs4e8aSR5BAV9NQNJtUtKgLjDDpl2lp0BAJdEhDMTtwMkLf_G3f_g4v0W6DqGhRUaQ5BbOT5idq8JyARYzkq_zwK0g"];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfTerms
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"terms" toKeyPath:@"terms" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [value isKindOfClass:[NSArray class]] && [value count] == 5;
    }];
    STAssertNoThrow([mappingTest verify], nil);
}

@end
