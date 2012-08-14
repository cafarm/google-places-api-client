//
//  GPAutocompletePrediction.h
//  PlacesClient
//
//  Created by Mark Cafaro on 8/13/12.
//  Copyright (c) 2012 Seven O' Eight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPAutocompletePrediction : NSObject

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *reference;
@property (strong, nonatomic) NSArray *terms;

@end
