//
//  GPDetailsResponse.h
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import "GPResponse.h"

@class GPDetailsResult;

@interface GPDetailsResponse : GPResponse

@property (strong, nonatomic) GPDetailsResult *result;

@end
