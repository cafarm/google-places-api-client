//
//  GPMappingProvider.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import "GPMappingProvider.h"
#import "GPAutocompleteResponse.h"
#import "GPAutocompletePrediction.h"
#import "GPAutocompleteTerm.h"
#import "GPDetailsResponse.h"
#import "GPDetailsResult.h"
#import "GPDetailsGeometry.h"

@implementation GPMappingProvider

- (id)init
{
    self = [super init];
    if (self) {
        [self setObjectMapping:[self autocompleteResponseObjectMapping] forKeyPath:@"/place/autocomplete"];
        [self setObjectMapping:[self detailsResponseObjectMapping] forKeyPath:@"/place/details"];
    }
    return self;
}

- (RKObjectMapping *)autocompleteResponseObjectMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[GPAutocompleteResponse class]];
    
    [mapping mapAttributes:@"status", nil];
    
    [mapping mapKeyPath:@"predictions" toRelationship:@"predictions" withMapping:[self autocompletePredictionObjectMapping]];
    
    return mapping;
}

- (RKObjectMapping *)autocompletePredictionObjectMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[GPAutocompletePrediction class]];
    
    [mapping mapAttributes:@"description", @"reference", nil];
    
    [mapping mapKeyPath:@"terms" toRelationship:@"terms" withMapping:[self autocompleteTermObjectMapping]];
    
    return mapping;
}

- (RKObjectMapping *)autocompleteTermObjectMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[GPAutocompleteTerm class]];

    [mapping mapAttributes:@"value", nil];
    
    return mapping;
}

- (RKObjectMapping *)detailsResponseObjectMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[GPDetailsResponse class]];
    
    [mapping mapAttributes:@"status", nil];
    
    [mapping mapKeyPath:@"results" toRelationship:@"results" withMapping:[self detailsResultObjectMapping]];
    
    return mapping;
}

- (RKObjectMapping *)detailsResultObjectMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[GPDetailsResult class]];
        
    [mapping mapKeyPath:@"geometry" toRelationship:@"geometry" withMapping:[self detailsGeometryObjectMapping]];
    
    return mapping;
}

- (RKObjectMapping *)detailsGeometryObjectMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[GPDetailsGeometry class]];
    
    [mapping mapKeyPathsToAttributes:
     @"lat", @"latitude",
     @"lng", @"longitude",
     nil];
    
    return mapping;
}

@end
