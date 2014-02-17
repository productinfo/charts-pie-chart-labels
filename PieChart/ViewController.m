//
//  ViewController.m
//  PieChart
//
//  Created by Stuart Grey on 18/09/2012.
//  
//  Copyright 2012 Scott Logic
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ViewController.h"
#import <ShinobiCharts/SChartCanvas.h>
#import "ShinobiChart+PieCharts.h"


@interface ViewController () {
    BOOL first;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    BOOL iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    
    //Load our mobile data for both of our charts
    mobileOSVersions = [MobileOSVersions new];
    datasource = [Datasource new];
    datasource.osData = mobileOSVersions;
    
    //Enter your trial license key here
    NSString *licenseKey = @"";
    
    CGRect pieFrame;
    if (iPad) {
        pieFrame = CGRectMake(25,25,350,1000);
    } else {
        pieFrame = self.view.bounds;
    }
    
    pieChart = [ShinobiChart pieChartForOSDataWithFrame:pieFrame];
    pieChart.title = @"Mobile OS use worldwide";
    
    pieChart.licenseKey = licenseKey;
    
    datasource.pieChart = pieChart;
    pieChart.datasource = datasource;
    pieChart.delegate = self;
    [self.view addSubview:pieChart];
    
    CGRect donutFrame;
    //only display our donut if we have room - ie: iPad
    if (iPad) {
        donutFrame = CGRectMake(425,225,300,700);
    
        donutChart = [ShinobiChart donutChartForOSVersionDataWithFrame:donutFrame];
        donutChart.title = @"Versions of OS currently in use";
            
        donutChart.licenseKey = licenseKey;
            
        datasource.donutChart = donutChart;
        donutChart.datasource = datasource;
        //we setup a delegate to modify our labels
        donutChart.delegate = self;
        [self.view addSubview:donutChart];
    }
    self.view.backgroundColor = pieChart.backgroundColor;
    
    //start with one OS selected
    datasource.selectedOS = @"iOS";
    
    //Add an indication of selected OS to our donut
    selectedOSLabel = [[UILabel alloc] initWithFrame:CGRectMake(140.f, 180, 120, 35)];
    selectedOSLabel.font = [UIFont fontWithName:pieChart.theme.regularFontName size:22.f];
    selectedOSLabel.textColor = [UIColor darkTextColor];
    selectedOSLabel.backgroundColor = [UIColor clearColor];
    selectedOSLabel.textAlignment = UITextAlignmentCenter;
    selectedOSLabel.text = datasource.selectedOS;
    selectedOSLabel.adjustsFontSizeToFitWidth = YES;
    [donutChart addSubview:selectedOSLabel];
    
    //Somewhere to display the lines connecting our labels to our donut
    lineView = [[LineView alloc] init];
    [lineView setUserInteractionEnabled:NO];
    [lineView setBackgroundColor:[UIColor clearColor]];
    [donutChart addSubview:lineView];
    
    //Indicate that this is our first render
    first = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //We have different charat setups per device, therefore different orientation 
    BOOL iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    if (iPad) {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    }
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


- (void)sChart:(ShinobiChart *)chart toggledSelectionForRadialPoint:(SChartRadialDataPoint *)dataPoint inSeries:(SChartRadialSeries *)series atPixelCoordinate:(CGPoint)pixelPoint {
    
    //If we select an element on the pie we need to update the donut
    if (chart == pieChart && ([dataPoint.name isEqualToString:@"iOS" ] || [dataPoint.name isEqualToString:@"Android" ])) {
    
        SChartPieSeries *pieSeries = (SChartPieSeries*)series;
        
        for (int i=0; i<pieSeries.dataSeries.dataPoints.count; i++) {
            SChartDataPoint *dp = [pieSeries.dataSeries.dataPoints objectAtIndex:i];
            if (![dp.xValue isEqualToString:dataPoint.name]) {
                if (dataPoint.selected) {
                    [pieSeries setSlice:i asSelected:NO];
                }
            }
        }
        
        datasource.selectedOS = dataPoint.name;
        selectedOSLabel.text = datasource.selectedOS;
        
        [donutChart reloadData];
        [donutChart redrawChartAndGL:YES];
    }
}

- (void)sChart:(ShinobiChart *)chart alterLabel:(UILabel *)label forDatapoint:(SChartRadialDataPoint *)datapoint atSliceIndex:(int)index inRadialSeries:(SChartRadialSeries *)series {
    
    //For our pie chart - stop displaying labels for narrow slices
    if (chart == pieChart) {
        label.adjustsFontSizeToFitWidth = YES;
        
        if (datapoint.value.floatValue < 5.f) {
            label.text = @"";
            
        }  else if (datapoint.value.floatValue < 15.f) {
            label.adjustsFontSizeToFitWidth = YES;
            CGRect f = label.frame;
            f.size.width = 35.f;
            label.frame = f;
        }
    } else {
        //For our donut move our labels outside and use connecting lines
        if (datapoint.value.floatValue < 2.f) {
            label.text = @"";
        } else {
            float extrusion = 60.f;
            
            SChartPieSeries *pieSeries = (SChartPieSeries *)series;
            
            //get our radial point from our datasource method
            
            // three points:
            CGPoint pieCenter;      // chart center for trig calculations
            CGPoint oldLabelCenter; // original label center
            CGPoint labelCenter;    // new label center
            CGPoint endOfLine;     // we want our line to finish just short of our label
            
            pieCenter = [pieSeries getDonutCenter];
            oldLabelCenter = labelCenter = [pieSeries getSliceCenter:index];
            
            // find the angle of the slice, and add on a little to the label's center
            float xChange, yChange;
            
            xChange = pieCenter.x - labelCenter.x;
            yChange = pieCenter.y - labelCenter.y;
            
            float angle = atan2f(xChange, yChange) + M_PI / 2.f;
            // we do the M_PI / 2 adjustment because of how the pie is drawn internally
            
            labelCenter.x = oldLabelCenter.x + extrusion * cosf(angle);
            labelCenter.y = oldLabelCenter.y - extrusion * sinf(angle);
            
            endOfLine.x = oldLabelCenter.x + (extrusion-15.f) * cosf(angle);
            endOfLine.y = oldLabelCenter.y - (extrusion-15.f) * sinf(angle);
            
            //[label setText:datapoint.xValue];
            label.textColor = [UIColor darkTextColor];
            [label sizeToFit];
            [label setCenter:labelCenter]; // this must be after sizeToFit
            [label setHidden:NO];
            
            // connect our old label point to our new label
            [lineView addPointPair:oldLabelCenter second:endOfLine forLabel:label];
        }
    }
}

- (void) sChartRenderStarted:(ShinobiChart *)chart withFullRedraw:(BOOL)fullRedraw {
    
    //Draw our lines on if we're on our donut
    if (chart == donutChart) {
        // position our view over the top of the GL canvas
        CGRect glFrame = chart.canvas.glView.frame;
        glFrame.origin.y = chart.canvas.frame.origin.y;
        [lineView setFrame:glFrame];
        // remove the old point-pairs from the line view
        [lineView reset];
    }
    
    
}

- (void)sChartRenderFinished:(ShinobiChart *)chart {
    //For our first render make sure we animate our initial pie selection into place for effect :-)
    if (first && chart == pieChart) {
        first = NO;
        [self performSelector:@selector(initialSelectionForChart:) withObject:chart afterDelay:0.1f];
    }
    
}

- (void)initialSelectionForChart:(ShinobiChart*)chart {
    SChartPieSeries *ps = (SChartPieSeries*)[chart.allChartSeries lastObject];
    [ps setSlice:[datasource selectedSliceIndex] asSelected:YES];
    [chart redrawChartAndGL:YES];
}


@end
