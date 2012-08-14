//
//  GPObjectManager.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/14/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <RestKit/RestKit.h>

#import "GPObjectManager.h"
#import "GPMappingProvider.h"
#import "GPAutocompleteResponse.h"
#import "GPAutocompletePrediction.h"
#import "GPDetailsResponse.h"
#import "GPDetailsResult.h"

@interface GPObjectManager ()

@property (readonly, nonatomic) RKObjectManager *rkObjectManager;

@end


@implementation GPObjectManager

@synthesize baseURL = _baseURL;
@synthesize apiKey = _apiKey;

@synthesize rkObjectManager = _rkObjectManager;

- (id)initWithBaseURL:(NSURL *)baseURL apiKey:(NSString *)apiKey
{
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _apiKey = apiKey;
    }
    return self;
}

- (RKObjectManager *)rkObjectManager
{
    if (_rkObjectManager == nil) {
        _rkObjectManager = [RKObjectManager managerWithBaseURL:self.baseURL];
        _rkObjectManager.mappingProvider = [[GPMappingProvider alloc] init];
        [_rkObjectManager.client setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    return _rkObjectManager;
}

- (void)loadAutocompletePredictionsWithInput:(NSString *)input
                                    location:(CLLocationCoordinate2D)location
                                      radius:(double)radius
                           completionHandler:(void (^)(NSArray *predictions, NSError *error))completionHandler
{
    NSDictionary *queryParameters = [NSDictionary dictionaryWithKeysAndObjects:
                                     @"input", input,
                                     @"sensor", @"true",
                                     @"key", self.apiKey,
                                     @"location", [NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude],
                                     @"radius", [NSString stringWithFormat:@"%f", radius],
                                     @"components", @"country:us",
                                     nil];
    
    NSString *resourcePath = [@"/place/autocomplete" stringByAppendingQueryParameters:queryParameters];
    
    DLog(@"Request URL: %@%@", [[self rkObjectManager].baseURL absoluteString], resourcePath);

    [self.rkObjectManager loadObjectsAtResourcePath:resourcePath usingBlock:^(RKObjectLoader *loader) {
        
        loader.onDidLoadObject = ^(id object) {
            GPAutocompleteResponse *response = (GPAutocompleteResponse *)object;
            
            NSArray *predictions = response.predictions;
            
            NSError *error = nil;
            if (response.status != GPOk) {
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setValue:[NSNumber numberWithInt:response.status] forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:@"com.sevenoeight.PlacesClient"
                                            code:response.status
                                        userInfo:userInfo];
            }
            
            completionHandler(predictions, error);
        };
        
        loader.onDidFailWithError = ^(NSError *error) {
            completionHandler(nil, error);
        };
    }];
}

- (void)loadDetailsResultsWithReference:(NSString *)reference
                      completionHandler:(void (^)(NSArray *, NSError *))completionHandler
{
    NSDictionary *queryParameters = [NSDictionary dictionaryWithKeysAndObjects:
                                     @"reference", reference,
                                     @"sensor", @"true",
                                     @"key", self.apiKey,
                                     nil];
    
    NSString *resourcePath = [@"/place/details" stringByAppendingQueryParameters:queryParameters];
    
    DLog(@"Request URL: %@%@", [[self rkObjectManager].baseURL absoluteString], resourcePath);
    
    [self.rkObjectManager loadObjectsAtResourcePath:resourcePath usingBlock:^(RKObjectLoader *loader) {
        
        loader.onDidLoadObject = ^(id object) {
            GPDetailsResponse *response = (GPDetailsResponse *)object;
            
            NSArray *results = response.results;
            
            NSError *error = nil;
            if (response.status != GPOk) {
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setValue:[NSNumber numberWithInt:response.status] forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:@"com.sevenoeight.PlacesClient"
                                            code:response.status
                                        userInfo:userInfo];
            }
            
            completionHandler(results, error);
        };
        
        loader.onDidFailWithError = ^(NSError *error) {
            completionHandler(nil, error);
        };
    }];
}

@end
