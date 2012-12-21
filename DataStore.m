//
//  DataStore.m
//  WeightData
//
//  Created by Arielle Mann on 10/28/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore


+ (id)sharedStore {
    static DataStore *sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataStore = [[self alloc] init];
    });
    
    return sharedDataStore;
}

- (id)init {
    if (self = [super init]) {
        _weights = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    
}

@end
