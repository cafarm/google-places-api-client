//
//  GPDetailsResult.h
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPDetailsGeometry;

typedef enum {
    GPDetailsResultTypeEstablishment
} GPDetailsResultType;

@interface GPDetailsResult : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) GPDetailsGeometry *geometry;
@property (strong, nonatomic) NSArray *types;
@property (strong, nonatomic) NSString *vicinity;

@end
