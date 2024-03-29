//
//  GPResponse.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import "GPResponse.h"

@implementation GPResponse

@synthesize status;

// Convert status string to status type prior to assignment
- (BOOL)validateStatus:(id *)ioValue error:(NSError **)outError
{
    NSString *stringValue = (NSString *)*ioValue;
    
    if ([stringValue isEqualToString:@"OK"]) {
        *ioValue = [NSNumber numberWithInt:GPResponseStatusOk];
    } else if ([stringValue isEqualToString:@"ZERO_RESULTS"]) {
        *ioValue = [NSNumber numberWithInt:GPResponseStatusZeroResults];
    } else if ([stringValue isEqualToString:@"OVER_QUERY_LIMIT"]) {
        *ioValue = [NSNumber numberWithInt:GPResponseStatusOverQueryLimit];
    } else if ([stringValue isEqualToString:@"REQUEST_DENIED"]) {
        *ioValue = [NSNumber numberWithInt:GPResponseStatusRequestDenied];
    } else if ([stringValue isEqualToString:@"INVALID_REQUEST"]) {
        *ioValue = [NSNumber numberWithInt:GPResponseStatusInvalidRequest];
    } else {
        return NO;
    }
    return YES;
}

@end
