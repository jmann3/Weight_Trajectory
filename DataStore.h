//
//  DataStore.h
//  WeightData
//
//  Created by Arielle Mann on 10/28/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject {
    
}

@property (nonatomic, retain) NSMutableArray *weights;

+ (id)sharedStore;

@end
