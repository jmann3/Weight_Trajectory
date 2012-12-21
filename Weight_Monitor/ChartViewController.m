//
//  ChartViewController.m
//  WeightData
//
//  Created by John Mann on 11/7/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import "ChartViewController.h"
#import "DataStore.h"
#import "WeightEntry.h"

@interface ChartViewController ()

@end

@implementation ChartViewController

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    sharedDataStore = [DataStore sharedStore];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self initPlot];
}

#pragma mark - Chart behavior
- (void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

- (void)configureHost {
    self.hostView = [(CPTGraphHostingView *)[CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
    self.hostView.allowPinchScaling = YES;
    [self.view addSubview:self.hostView];
}

- (void)configureGraph {
    // Create the graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    self.hostView.hostedGraph = graph;
    
    // Set graph title
    NSString *title = @"Weight Progress";
    graph.title = title;
    
    // Create and set text style
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
	titleStyle.fontSize = 16.0f;
	graph.titleTextStyle = titleStyle;
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
	graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
    
	// Set padding for plot area
	[graph.plotAreaFrame setPaddingLeft: 30.0f];
	[graph.plotAreaFrame setPaddingBottom: 30.0f];
    
	// Enable user interactions for plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = YES;
}

-(void)configurePlots {
	// Get graph and plot space
	CPTGraph *graph = self.hostView.hostedGraph;
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
	// Create the plot
	CPTScatterPlot *mainPlot = [[CPTScatterPlot alloc] init];
	mainPlot.dataSource = self;
	mainPlot.identifier = CPDWeight;
	CPTColor *mainColor = [CPTColor blueColor];
	[graph addPlot:mainPlot toPlotSpace:plotSpace];
    
	// Set up plot space
	[plotSpace scaleToFitPlots:[NSArray arrayWithObjects:mainPlot, nil]];
	CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
	[xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
	plotSpace.xRange = xRange;
	CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
	[yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
	plotSpace.yRange = yRange;
    
	// Create styles and symbols
	CPTMutableLineStyle *mainLineStyle = [mainPlot.dataLineStyle mutableCopy];
	mainLineStyle.lineWidth = 2.5;
	mainLineStyle.lineColor = mainColor;
	mainPlot.dataLineStyle = mainLineStyle;
	CPTMutableLineStyle *mainSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	mainSymbolLineStyle.lineColor = mainColor;
	CPTPlotSymbol *mainSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	mainSymbol.fill = [CPTFill fillWithColor:mainColor];
	mainSymbol.lineStyle = mainSymbolLineStyle;
	mainSymbol.size = CGSizeMake(6.0f, 6.0f);
	mainPlot.plotSymbol = mainSymbol;
}

- (void)configureAxes {
    // Create styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor whiteColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 12.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 2.0f;
	axisLineStyle.lineColor = [CPTColor whiteColor];
	CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
	axisTextStyle.color = [CPTColor whiteColor];
	axisTextStyle.fontName = @"Helvetica-Bold";
	axisTextStyle.fontSize = 11.0f;
	CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor whiteColor];
	tickLineStyle.lineWidth = 2.0f;
	CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor blackColor];
	tickLineStyle.lineWidth = 1.0f;
    
	// Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    
	// Configure x-axis
	CPTAxis *x = axisSet.xAxis;
	x.title = @"Entry #";
	x.titleTextStyle = axisTitleStyle;
	x.titleOffset = 15.0f;
	x.axisLineStyle = axisLineStyle;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	x.labelTextStyle = axisTextStyle;
	x.majorTickLineStyle = axisLineStyle;
	x.majorTickLength = 4.0f;
	x.tickDirection = CPTSignNegative;
	CGFloat weightCount = [[sharedDataStore weights] count];
	NSMutableSet *xLabels = [NSMutableSet setWithCapacity:weightCount];
	NSMutableSet *xLocations = [NSMutableSet setWithCapacity:weightCount];
    
    /*
	NSInteger i = 0;
	for (NSString *date in [[CPDStockPriceStore sharedInstance] datesInMonth]) {
		CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
		CGFloat location = i++;
		label.tickLocation = CPTDecimalFromCGFloat(location);
		label.offset = x.majorTickLength;
		if (label) {
			[xLabels addObject:label];
			[xLocations addObject:[NSNumber numberWithFloat:location]];
		}
	}
    */

    for (int i = 0; i < weightCount; i++) {
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", i] textStyle:x.labelTextStyle];
        CGFloat location = i + 1.0f;
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = x.majorTickLength;
        if (label) {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    
	x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
        
	// Configure y-axis
	CPTAxis *y = axisSet.yAxis;
	y.title = @"Weight";
	y.titleTextStyle = axisTitleStyle;
	y.titleOffset = -40.0f;
	y.axisLineStyle = axisLineStyle;
	y.majorGridLineStyle = gridLineStyle;
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
	y.labelTextStyle = axisTextStyle;
	y.labelOffset = 16.0f;
	y.majorTickLineStyle = axisLineStyle;
	y.majorTickLength = 4.0f;
	y.minorTickLength = 2.0f;
	y.tickDirection = CPTSignPositive;
	NSInteger majorIncrement = 5;
	NSInteger minorIncrement = 1;
	CGFloat yMax = 500.0f;  // should determine dynamically based on max weight
	NSMutableSet *yLabels = [NSMutableSet set];
	NSMutableSet *yMajorLocations = [NSMutableSet set];
	NSMutableSet *yMinorLocations = [NSMutableSet set];
	for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
		NSUInteger mod = j % majorIncrement;
		if (mod == 0) {
			CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
			NSDecimal location = CPTDecimalFromInteger(j);
			label.tickLocation = location;
			label.offset = -y.majorTickLength - y.labelOffset;
			if (label) {
				[yLabels addObject:label];
			}
			[yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
		} else {
			[yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
		}
	}
	y.axisLabels = yLabels;
	y.majorTickLocations = yMajorLocations;
	y.minorTickLocations = yMinorLocations;

}

#pragma mark - 
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [[sharedDataStore weights] count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSInteger valueCount = [[sharedDataStore weights] count];
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            if (index < valueCount) {
                return [NSNumber numberWithUnsignedInt:index];
            }
            break;
            
        case CPTScatterPlotFieldY:
            if ([plot.identifier isEqual:CPDWeight]) {
                WeightEntry *weightObject = (WeightEntry *)[[sharedDataStore weights] objectAtIndex:index];
                return [NSNumber numberWithFloat:[weightObject weight]];
            }
            break;
    }
    
    return [NSDecimalNumber zero];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
