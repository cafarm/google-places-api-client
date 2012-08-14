//
//  GPObjectManager.h
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GPObjectManager : NSObject

- (id)initWithBaseURL:(NSURL *)baseURL apiKey:(NSString *)apiKey;

@property (readonly, nonatomic) NSURL *baseURL;
@property (readonly, nonatomic) NSString* apiKey;

- (void)loadAutocompletePredictionsWithInput:(NSString *)input
                                    location:(CLLocationCoordinate2D)location
                                      radius:(double)radius
                           completionHandler:(void (^)(NSArray *predictions, NSError *error))completionHandler;

- (void)loadDetailsResultsWithReference:(NSString *)reference
                      completionHandler:(void (^)(NSArray *results, NSError *error))completionHandler;

@end
