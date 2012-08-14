//
//  GPResponse.h
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GPOk,
    GPUnknownError,
    GPZeroResults,
    GPOverQueryLimit,
    GPRequestDenied,
    GPInvalidRequest,
    GPNotFound
} GPStatus;

@interface GPResponse : NSObject

@property (nonatomic) GPStatus status;

@end
