//
//  HBCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by Heli Bavishi on 12/2/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "HBCityAirQualityController.h"

static NSString * const baseURLString = @"https://api.airvisual.com/";
static NSString * const versionComponent = @"v2";
static NSString * const countryComponent = @"countries";
static NSString * const stateComponent = @"states";
static NSString * const cityComponent = @"cities";
static NSString * const cityDetailsComponent = @"city";
static NSString * const stateDetailsComponent = @"state";
static NSString * const countryDetailsComponent = @"country";
static NSString * const apiKey = @"key";
static NSString * const apiKeyValue = @"44088d04-2fc9-4cf4-bda7-ad1ad4552016";

@implementation HBCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [url URLByAppendingPathComponent:versionComponent];
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:countryURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:apiKey value:apiKeyValue];
    urlComponents.queryItems = @[queryItem];
    
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@",finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
        
        if (error)
        {
            NSLog(@"%@",error.localizedDescription);
            return completion(nil);
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"No data was found");
            return completion(nil);
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelDictionary)
        {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil);
        }
        
        NSArray<NSDictionary *> *dataDictionary = topLevelDictionary[@"data"];
        NSMutableArray *arrayOfCountries = [NSMutableArray new];
        
        for (NSDictionary *dictionary in dataDictionary)
        {
            NSString *country = [[NSString alloc] initWithString:dictionary[@"country"]];
            [arrayOfCountries addObject:country];
        }
        completion(arrayOfCountries);
        
    }] resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *stateURL = [versionURL URLByAppendingPathComponent:stateComponent];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:stateURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *countryQueryItem = [NSURLQueryItem queryItemWithName:countryDetailsComponent value:country];
    
    NSURLQueryItem *apiKeyQueryItem = [NSURLQueryItem queryItemWithName:apiKey value:apiKeyValue];
    urlComponents.queryItems = @[countryQueryItem, apiKeyQueryItem];
    
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@",finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
        if (error)
        {
            NSLog(@"%@",error.localizedDescription);
            return completion(nil);
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"No data was found");
            return completion(nil);
        }
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelDictionary)
        {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil);
        }
        
        NSArray<NSDictionary *> *dataDictionary = topLevelDictionary[@"data"];
        NSMutableArray *arrayOfCountries = [NSMutableArray new];
        
        for (NSDictionary *dictionary in dataDictionary)
        {
            NSString *country = [[NSString alloc] initWithString:dictionary[@"state"]];
            [arrayOfCountries addObject:country];
        }
        completion(arrayOfCountries);
        
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:cityURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *stateQueryItem = [NSURLQueryItem queryItemWithName:stateDetailsComponent value:state];
    NSURLQueryItem *countryQueryItem = [NSURLQueryItem queryItemWithName:countryDetailsComponent value:country];
    NSURLQueryItem *apiKeyQueryItem = [NSURLQueryItem queryItemWithName:apiKey value:apiKeyValue];
    
    urlComponents.queryItems = @[stateQueryItem, countryQueryItem, apiKeyQueryItem];
    
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@",finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
        
        if (error)
        {
            NSLog(@"%@",error.localizedDescription);
            return completion(nil);
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"No data was found");
            return completion(nil);
        }
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelDictionary)
        {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil);
        }
        
        NSArray<NSDictionary *> *dataDictionary = topLevelDictionary[@"data"];
               NSMutableArray *arrayOfCities = [NSMutableArray new];

               NSString *status = topLevelDictionary[@"status"];
               
               for (NSDictionary *dictionary in dataDictionary)
               {
                   if ([status isEqualToString: @"success"])
                   {
                       NSString *city = [[NSString alloc] initWithString:dictionary[@"city"]];
                       [arrayOfCities addObject:city];
                   } else
                   {
                       return completion(nil);
                   }
                       
               }
               
               completion(arrayOfCities);
           }] resume];
}
+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(HBCityAirQuality * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:cityURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *cityQueryItem = [NSURLQueryItem queryItemWithName:cityDetailsComponent value:city];
    NSURLQueryItem *stateQueryItem = [NSURLQueryItem queryItemWithName:stateDetailsComponent value:state];
    NSURLQueryItem *countryQueryItem = [NSURLQueryItem queryItemWithName:countryDetailsComponent value:country];
    
    NSURLQueryItem *apiKeyQueryItem = [NSURLQueryItem queryItemWithName:apiKey value:apiKeyValue];
    
    urlComponents.queryItems = @[cityQueryItem, stateQueryItem, countryQueryItem, apiKeyQueryItem];
    
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@",finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
            {
        if (error)
        {
            NSLog(@"%@",error.localizedDescription);
            return completion(nil);
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"No data was found");
            return completion(nil);
        }
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelDictionary)
        {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil);
        }
        
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        
        HBCityAirQuality *cityAirQualityIndex = [[HBCityAirQuality alloc] initWithDictionary:dataDictionary];
        completion(cityAirQualityIndex);
        
        
    }] resume];
    
}
@end
