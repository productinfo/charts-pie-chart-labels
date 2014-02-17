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
        _dataKeys = [NSArray arrayWithObjects:@"item", @"uptake_pct", nil];
        _osTypes = [NSArray arrayWithObjects:@"iOS", @"Android",@"BlackBerry",@"WindowsPhone",@"Symbian", nil];
        
        [_osData setObject:[NSNumber numberWithFloat:52.4f] forKey:@"Android"];
        [_osData setObject:[NSNumber numberWithFloat:39.2f] forKey:@"iOS"];
        [_osData setObject:[NSNumber numberWithFloat:4.8f] forKey:@"BlackBerry"];
        [_osData setObject:[NSNumber numberWithFloat:3.f] forKey:@"WindowsPhone"];
        [_osData setObject:[NSNumber numberWithFloat:0.4f] forKey:@"Symbian"];
        
        NSMutableArray *iosData = [NSMutableArray new];
        [iosData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"7.x", [NSNumber numberWithFloat:78.3f],nil] forKeys:_dataKeys]];
        [iosData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"6.x", [NSNumber numberWithFloat:15.8f],nil] forKeys:_dataKeys]];
        [iosData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"5.x", [NSNumber numberWithFloat:5.1f],nil] forKeys:_dataKeys]];
        [iosData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"4.x", [NSNumber numberWithFloat:0.7f],nil] forKeys:_dataKeys]];
        [iosData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"3.x", [NSNumber numberWithFloat:0.1f],nil] forKeys:_dataKeys]];
        [_versionData setObject:iosData forKey:[_osTypes objectAtIndex:0]];
        
        NSMutableArray *androidData = [NSMutableArray new];
        [androidData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"4.4", [NSNumber numberWithFloat:1.4f],nil] forKeys:_dataKeys]];
        [androidData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"4.1.x-4.3.x", [NSNumber numberWithFloat:59.1f],nil] forKeys:_dataKeys]];
        [androidData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"4.0.x", [NSNumber numberWithFloat:16.9f],nil] forKeys:_dataKeys]];
        [androidData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"3.x", [NSNumber numberWithFloat:0.1f],nil] forKeys:_dataKeys]];
        [androidData addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"2.x", [NSNumber numberWithFloat:22.5f],nil] forKeys:_dataKeys]];
        [_versionData setObject:androidData forKey:[_osTypes objectAtIndex:1]];
        
        
        
    }
    return self;
}


@end
