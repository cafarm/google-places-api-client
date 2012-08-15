//
//  GPMappingProviderTest.m
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
#import "GPDetailsResponse.h"

@interface GPMappingProviderTest : SenTestCase
@end

@implementation GPMappingProviderTest

- (void)setUp
{
    [RKTestFactory setUp];
}

- (void)tearDown
{
    [RKTestFactory tearDown];
}

// These tests require sinatra to be running
// Go to project root directory
// rvm gemset create RestKit
// rvm use 1.9.2@RestKit
// gem install bundler
// bundle
// rake server

- (void)testLoadingOfAutocompleteResponse
{
    GPMappingProvider *mappingProvider = [[GPMappingProvider alloc] init];
    RKTestResponseLoader *responseLoader = [RKTestResponseLoader responseLoader];
    RKURL *url = [[RKTestFactory baseURL] URLByAppendingResourcePath:@"/place/autocomplete/json"];
    RKObjectLoader *objectLoader = [RKObjectLoader loaderWithURL:url mappingProvider:mappingProvider];
    objectLoader.delegate = responseLoader;
    [objectLoader sendAsynchronously];
    [responseLoader waitForResponse];
    
    STAssertEquals(YES, responseLoader.wasSuccessful, nil);
    GPAutocompleteResponse *response = [responseLoader.objects objectAtIndex:0];
    STAssertNotNil(response, @"Expected response not to be nil");
    STAssertTrue([response.predictions count] == 5, nil);
}

- (void)testLoadingOfDetailsResponse
{
    GPMappingProvider *mappingProvider = [[GPMappingProvider alloc] init];
    RKTestResponseLoader *responseLoader = [RKTestResponseLoader responseLoader];
    RKURL *url = [[RKTestFactory baseURL] URLByAppendingResourcePath:@"/place/details/json"];
    RKObjectLoader *objectLoader = [RKObjectLoader loaderWithURL:url mappingProvider:mappingProvider];
    objectLoader.delegate = responseLoader;
    [objectLoader sendAsynchronously];
    [responseLoader waitForResponse];
    
    STAssertEquals(YES, responseLoader.wasSuccessful, nil);
    GPDetailsResponse *response = [responseLoader.objects objectAtIndex:0];
    STAssertNotNil(response, @"Expected response not to be nil");
    STAssertNotNil(response.result, nil);
}

@end
