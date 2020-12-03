//
//  HBWeather.h
//  AirQuality ObjC
//
//  Created by Heli Bavishi on 12/2/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBWeather : NSObject

@property (nonatomic, readonly) NSInteger temperature;
@property (nonatomic, readonly) NSInteger humidity;
@property (nonatomic, readonly) NSInteger windSpeed;


-(instancetype)initWithTempature:(NSInteger)temperature
                        humidity:(NSInteger)humidity
                        windSpeed:(NSInteger)windSpeed;

@end

@interface HBWeather (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary;

@end
NS_ASSUME_NONNULL_END
