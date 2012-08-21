//
//  GPObjectManagerTest.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Testing.h>

#import "GPObjectManager.h"
#import "GPAutocompletePrediction.h"
#import "GPDetailsResult.h"

@interface GPObjectManagerTest : SenTestCase
@end

@implementation GPObjectManagerTest
{
    BOOL done;
}

- (void)setUp
{
    [RKTestFactory setUp];
    done = NO;
}

- (void)tearDown
{
    [RKTestFactory tearDown];
}

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0) {
            break;
        }
    } while (!done);
    
    return done;
}

- (GPObjectManager *)objectManager
{
    return [[GPObjectManager alloc] initWithBaseURL:RKTestFactory.baseURL apiKey:@"apiKey"];
    //return [[GPObjectManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://maps.googleapis.com/maps/api"] apiKey:@"AIzaSyCXTU7jtaUbbQ4ZouFEKabc2VfJv260YhE"];
}

- (void)testLoadingOfAutocompletePredictions
{
    GPObjectManager *objectManager = [self objectManager];
    
    __block NSArray *fetchedPredictions;
    __block NSError *fetchError;
    [objectManager fetchAutocompletePredictionsWithInput:@"Chipot"
                                               location:CLLocationCoordinate2DMake(47.659746, -122.314012)
                                                 radius:16000
                                      completionHandler:^(NSArray *predictions, NSError *error)
    {
        fetchedPredictions = predictions;
        fetchError = error;
        done = YES;
    }];
    
    STAssertTrue([self waitForCompletion:90.0], @"Failed to get any results in time");
    STAssertNil(fetchError, nil);
    STAssertNotNil(fetchedPredictions, nil);
}

- (void)testLoadingOfDetailsResult
{
    GPObjectManager *objectManager = [self objectManager];
    
    __block GPDetailsResult *fetchedResult;
    __block NSError *fetchError;
    [objectManager fetchDetailsResultWithReference:@"CoQBdwAAAEdboelq1A0WAnx5owe7C-AXqyTZYmIxWsJU5LvBBnffgiqOUOVrwKBxdAUFrI0K9WdEvi1xzijctqwA-a_UUZxUCPjcGXgTzfQQ1wkMliQ40ntEMAnJ08Zg-QBCPM9HxauBGm86vs4e8aSR5BAV9NQNJtUtKgLjDDpl2lp0BAJdEhDMTtwMkLf_G3f_g4v0W6DqGhRUaQ5BbOT5idq8JyARYzkq_zwK0g"
                                completionHandler:^(GPDetailsResult *result, NSError *error)
     {
         fetchedResult = result;
         fetchError = error;
         done = YES;
     }];
    
    STAssertTrue([self waitForCompletion:90.0], @"Failed to get any results in time");
    STAssertNil(fetchError, nil);
    STAssertNotNil(fetchedResult, nil);
}

@end
