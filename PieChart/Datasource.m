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

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

- (SChartSeries*)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    SChartSeries *series;
    if (chart == _pieChart) {
        series = [chart pieSeriesForOS];
    } else {
        series = [chart donutSeriesForOSVerison];
    }
    return series;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    NSInteger count;
    if (chart == _pieChart) {
        count = [_osData osTypes].count;
    } else {
        count = [[_osData versionData][_selectedOS] count];
    }
    return count;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    SChartRadialDataPoint *dp = [SChartRadialDataPoint new];
    if (chart == _pieChart) {
        dp.name = [_osData osTypes][dataIndex];
        dp.value = [_osData osData][dp.name];
    } else {
        dp.name = [_osData versionData][_selectedOS][dataIndex][[_osData dataKeys][0]];
        dp.value = [_osData versionData][_selectedOS][dataIndex][[_osData dataKeys][1]];
    }
    return dp;
}

- (NSInteger)selectedSliceIndex; {
    return [[_osData osTypes] indexOfObject:_selectedOS];
}


@end
