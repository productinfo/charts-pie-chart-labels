//
//  ShinobiChart+PieCharts.m
//  PieChart
//
//  Created by Stuart Grey on 21/09/2012.
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

#import "ShinobiChart+PieCharts.h"

@implementation ShinobiChart (PieCharts)

+ (ShinobiChart*)pieChartForOSDataWithFrame:(CGRect)frame {
    BOOL iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    ShinobiChart *chart = [[ShinobiChart alloc] initWithFrame:frame];
    chart.autoresizingMask = ~UIViewAutoresizingNone;
        
    SChartTheme *d = [SChartiOS7Theme new];
    if (!iPad) {
        d.legendStyle.font = [UIFont fontWithName:d.lightFontName size:13.f];
    }
    [chart applyTheme:d];
    
    chart.legend.hidden = NO;
    chart.legend.position = SChartLegendPositionBottomMiddle;
    chart.legend.maxSeriesPerLine = iPad ? 1 : 2;
   
    
    return chart;
}

+ (ShinobiChart*)donutChartForOSVersionDataWithFrame:(CGRect)frame {
    
    ShinobiChart *chart = [[ShinobiChart alloc] initWithFrame:frame];
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    chart.legend.hidden = NO;
    chart.legend.position = SChartLegendPositionBottomMiddle;
    chart.legend.maxSeriesPerLine = 2;
    
    return chart;
}

- (SChartPieSeries*)pieSeriesForOS {
    BOOL iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    SChartPieSeries *p = [SChartPieSeries new];
    p.selectedStyle.protrusion = iPad ? 40.f : 10.f;
    p.style.showCrust = NO;
    p.selectedStyle.showCrust = NO;
    p.labelFormatString = @"%.0f%%";
    p.selectedPosition = [NSNumber numberWithFloat:(float)(-M_PI/2.f)];
    p.animationEnabled = YES;
    p.gesturePanningEnabled = YES;
    p.selectionEnabledDuringPanning = YES;
    return p;
}

- (SChartDonutSeries*)donutSeriesForOSVerison {
    SChartDonutSeries *d = [SChartDonutSeries new];
    d.style.showCrust = NO;
    d.selectedStyle.showCrust = NO;
    d.labelFormatString = @"%.0f%%";
    d.style.labelFont = [UIFont fontWithName:[SChartiOS7Theme new].lightFontName size:16.f];
    d.outerRadius = 105.f;
    d.innerRadius = 65.f;
    d.selectedStyle.protrusion = 0.f;
    d.animationEnabled = YES;
    d.gesturePanningEnabled = YES;
    return d;
}




@end
