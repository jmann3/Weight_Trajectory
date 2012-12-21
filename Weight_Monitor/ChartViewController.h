//
//  ChartViewController.h
//  WeightData
//
//  Created by John Mann on 11/7/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "WeightEntry.h"
@class DataStore;

@interface ChartViewController : UIViewController <CPTPlotDataSource, CPTAxisDelegate> {
    
    DataStore *sharedDataStore;
    
}

@property (nonatomic, strong) NSMutableArray *dataForPlot;
@property (nonatomic, strong) CPTGraphHostingView *hostView;

@end
