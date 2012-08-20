//
//  GPResponse.h
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GPResponseStatusOk,
    GPResponseStatusUnknownError,
    GPResponseStatusZeroResults,
    GPResponseStatusOverQueryLimit,
    GPResponseStatusRequestDenied,
    GPResponseStatusInvalidRequest,
    GPResponseStatusNotFound
} GPResponseStatus;

@interface GPResponse : NSObject

@property (nonatomic) GPResponseStatus status;

@end
