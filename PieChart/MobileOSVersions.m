//
//  mobileOSVersions.m
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

#import "mobileOSVersions.h"

@implementation MobileOSVersions

- (id)init {
    self = [super init];
    
    if (self) {
        
        _osData = [NSMutableDictionary new];
        _versionData = [NSMutableDictionary new];
        _dataKeys = @[@"item", @"uptake_pct"];
        _osTypes = @[@"iOS", @"Android",@"BlackBerry",@"WindowsPhone",@"Symbian"];
        
        _osData[@"Android"] = @52.4f;
        _osData[@"iOS"] = @39.2f;
        _osData[@"BlackBerry"] = @4.8f;
        _osData[@"WindowsPhone"] = @3.f;
        _osData[@"Symbian"] = @0.4f;
        
        NSMutableArray *iosData = [NSMutableArray new];
        [iosData addObject:[NSDictionary dictionaryWithObjects:@[@"7.x", @78.3f] forKeys:_dataKeys]];
        [iosData addObject:[NSDictionary dictionaryWithObjects:@[@"6.x", @15.8f] forKeys:_dataKeys]];
        [iosData addObject:[NSDictionary dictionaryWithObjects:@[@"5.x", @5.1f] forKeys:_dataKeys]];
        [iosData addObject:[NSDictionary dictionaryWithObjects:@[@"4.x", @0.7f] forKeys:_dataKeys]];
        [iosData addObject:[NSDictionary dictionaryWithObjects:@[@"3.x", @0.1f] forKeys:_dataKeys]];
        _versionData[_osTypes[0]] = iosData;
        
        NSMutableArray *androidData = [NSMutableArray new];
        [androidData addObject:[NSDictionary dictionaryWithObjects:@[@"4.4", @1.4f] forKeys:_dataKeys]];
        [androidData addObject:[NSDictionary dictionaryWithObjects:@[@"4.1.x-4.3.x", @59.1f] forKeys:_dataKeys]];
        [androidData addObject:[NSDictionary dictionaryWithObjects:@[@"4.0.x", @16.9f] forKeys:_dataKeys]];
        [androidData addObject:[NSDictionary dictionaryWithObjects:@[@"3.x", @0.1f] forKeys:_dataKeys]];
        [androidData addObject:[NSDictionary dictionaryWithObjects:@[@"2.x", @22.5f] forKeys:_dataKeys]];
        _versionData[_osTypes[1]] = androidData;       
        
        
    }
    return self;
}


@end
