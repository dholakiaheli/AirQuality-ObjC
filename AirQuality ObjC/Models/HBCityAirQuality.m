//
//  HBCityAirQuality.m
//  AirQuality ObjC
//
//  Created by Heli Bavishi on 12/2/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "HBCityAirQuality.h"

static NSString * const cityKey = @"city";
static NSString * const stateKey = @"state";
static NSString * const countryKey = @"country";
static NSString * const weatherKey = @"weather";
static NSString * const pollutionKey = @"pollution";
static NSString * const currentKey = @"current";


@implementation HBCityAirQuality

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(HBWeather *)weather pollution:(HBPollution *)pollution
{
    self = [super init];
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}
@end

@implementation HBCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *city = dictionary[cityKey];
    NSString *state = dictionary[stateKey];
    NSString *country = dictionary[countryKey];
    
    NSDictionary *current = dictionary[currentKey];
    
    HBWeather *weather = [[HBWeather alloc] initWithDictionary:current[weatherKey]];
    HBPollution *pollution = [[HBPollution alloc] initWithDictionary:current[pollutionKey]];
    
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}



@end
