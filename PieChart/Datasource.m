//
//  Datasource.m
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

#import "Datasource.h"
#import "ShinobiChart+PieCharts.h"

@implementation Datasource

- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

- (SChartSeries*)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
    SChartSeries *series;
    if (chart == _pieChart) {
        series = [chart pieSeriesForOS];
    } else {
        series = [chart donutSeriesForOSVerison];
    }
    return series;
}

- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    int count;
    if (chart == _pieChart) {
        count = [_osData osTypes].count;
    } else {
        count = [[[_osData versionData] objectForKey:_selectedOS] count];
    }
    return count;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    SChartRadialDataPoint *dp = [SChartRadialDataPoint new];
    if (chart == _pieChart) {
        dp.name = [[_osData osTypes] objectAtIndex:dataIndex];
        dp.value = [[_osData osData] objectForKey:dp.name];
        
    } else {
        dp.name = [[[[_osData versionData] objectForKey:_selectedOS] objectAtIndex:dataIndex] objectForKey:[[_osData dataKeys] objectAtIndex:0]];
        dp.value = [[[[_osData versionData] objectForKey:_selectedOS] objectAtIndex:dataIndex] objectForKey:[[_osData dataKeys] objectAtIndex:1]];
    }
    return dp;
}

- (int)selectedSliceIndex; {
    return [[_osData osTypes] indexOfObject:_selectedOS];
}


@end
