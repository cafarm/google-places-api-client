//
//  GPMappingProvider.h
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <RestKit/RestKit.h>

@interface GPMappingProvider : RKObjectMappingProvider

- (RKObjectMapping *)autocompleteResponseObjectMapping;

- (RKObjectMapping *)autocompletePredictionObjectMapping;

- (RKObjectMapping *)autocompleteTermObjectMapping;

- (RKObjectMapping *)detailsResponseObjectMapping;

- (RKObjectMapping *)detailsResultObjectMapping;

- (RKObjectMapping *)detailsGeometryObjectMapping;

@end
