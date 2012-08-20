//
//  GPDetailsResult.m
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import "GPDetailsResult.h"
#import "GPDetailsGeometry.h"

@implementation GPDetailsResult

@synthesize name;
@synthesize geometry;
@synthesize types;
@synthesize vicinity;

// Convert types array to types prior to assignment
- (BOOL)validateTypes:(id *)ioValue error:(NSError **)outError
{
    NSArray *arrayValue = (NSArray *)*ioValue;
    
    NSMutableArray *typeValues = [NSMutableArray array];
    
    for (NSString *stringValue in arrayValue) {
        if ([stringValue isEqualToString:@"establishment"]) {
            [typeValues addObject:[NSNumber numberWithInt:GPDetailsResultTypeEstablishment]];
        }
        
        // TODO: Add the rest of the possible types
    }
    
    *ioValue = typeValues;
    
    return YES;
}

@end
