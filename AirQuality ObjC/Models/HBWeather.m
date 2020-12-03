//
//  HBWeather.m
//  AirQuality ObjC
//
//  Created by Heli Bavishi on 12/2/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "HBWeather.h"

static NSString * const temperatureKey = @"tp";
static NSString * const humidityKey = @"hu";
static NSString * const windSpeedKey = @"ws";

@implementation HBWeather

- (instancetype)initWithTempature:(NSInteger)temperature humidity:(NSInteger)humidity windSpeed:(NSInteger)windSpeed
{
    self = [super init];
    if (self)
    {
        _temperature = temperature;
        _humidity = humidity;
        _windSpeed = windSpeed;
    }
    return self;
}

@end

@implementation HBWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger temperature = [dictionary[temperatureKey]intValue];
    NSInteger humidity = [dictionary[humidityKey]intValue];
    NSInteger windSpeed = [dictionary[windSpeedKey]intValue];
    
    return [self initWithTempature:temperature humidity:humidity windSpeed:windSpeed];
}
@end
