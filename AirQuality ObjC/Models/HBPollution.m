//
//  HBPollution.m
//  AirQuality ObjC
//
//  Created by Heli Bavishi on 12/2/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "HBPollution.h"

static NSString * const airQualityIndexKey = @"aqius";

@implementation HBPollution

- (instancetype)initWithAirQualityIndex:(NSInteger)airQualityIndex
{
    self = [super init];
    if (self)
    {
        _airQualityIndex = airQualityIndex;
    }
    return self;
}
@end

@implementation HBPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger airQualityIndex = [dictionary[airQualityIndexKey]intValue];
    
    return [self initWithAirQualityIndex:airQualityIndex];
}

@end
