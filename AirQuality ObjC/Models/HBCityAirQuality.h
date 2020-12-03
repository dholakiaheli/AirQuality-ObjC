//
//  HBCityAirQuality.h
//  AirQuality ObjC
//
//  Created by Heli Bavishi on 12/2/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBWeather.h"
#import "HBPollution.h"

NS_ASSUME_NONNULL_BEGIN

@interface HBCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, copy, readonly) HBWeather *weather;
@property (nonatomic, copy, readonly) HBPollution *pollution;

- (instancetype)initWithCity:(NSString *)city
                       state:(NSString *)state
                     country:(NSString *)country
                     weather:(HBWeather *)weather
                   pollution:(HBPollution *)pollution;
@end

@interface HBCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary;

@end
NS_ASSUME_NONNULL_END
