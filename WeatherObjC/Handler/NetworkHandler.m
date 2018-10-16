//
//  NetworkHandler.m
//  WeatherObjC
//
//  Created by Ady on 9/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import "NetworkHandler.h"
#import "FirstModel.h"
#import "SecondModel.h"

@interface NetworkHandler()

@property (strong, nonatomic) SecondModel *secondModelExternalObj;

@end


@implementation NetworkHandler

+ (instancetype)sharedInstance {
    
    static dispatch_once_t pred = 0;
    static NetworkHandler *sharedObject;
    dispatch_once(&pred, ^{
        sharedObject = [[NetworkHandler alloc] init];
    });
    return sharedObject;
}


-(instancetype)init{
    
    if (self = [super init]) {
        NSLog(@"initializing only once");
    }
    return self;
}



- (void)getJsonResponseWithSearchText:(NSString *)searchText completion:(void (^)(NSMutableArray *, NSError *))completion {
    
    NSString *apiStr = [NSString stringWithFormat:@"http://autocomplete.wunderground.com/aq?query=%@", searchText];
    NSString *removespacesStr = [apiStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",apiStr);
    NSLog(@"%@",removespacesStr);
    
    NSURL *apiUrl = [NSURL URLWithString:removespacesStr];
    [[[NSURLSession sharedSession] dataTaskWithURL:apiUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSMutableArray<FirstModel *> *firstModelArr = [[NSMutableArray alloc] init];
            
            for (NSMutableDictionary *item in jsonResponse[@"RESULTS"]) {
                
                FirstModel *obj = [[FirstModel alloc] init];
//                if([item[@"type"]  isEqual: @"city" ] && [item[@"c"] isEqual: @"US"]){
                    obj.name = item[@"name"];
                    obj.type = item[@"type"];
                    obj.c = item[@"c"];
                    obj.zmw = item[@"zmw"];
                    obj.tz = item[@"tz"];
                    obj.tzs = item[@"tzs"];
                    obj.l = item[@"l"];
                    obj.ll = item[@"ll"];
                    obj.lat = item[@"lat"];
                    obj.lon = item[@"lon"];
                    
                    [firstModelArr addObject:obj];
//                    NSLog(@"%@", firstModelArr[0].name);
//                }
            }
            completion(firstModelArr, NULL);
        }
        
    }]resume];
}



- (void)getWeatherWithLatitude:(NSString *)latitude longitude:(NSString *)longitude completion:(void (^)(NSMutableArray *, NSError *))completion {

    NSString *threeDayWeatherStr = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?lat=%@&lon=%@&APPID=6d04434e3146aad1c58448070727fbb9",latitude,longitude];
    
    NSString *removeSpacesStr = [threeDayWeatherStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *apiUrl = [NSURL URLWithString:removeSpacesStr];
    [[[NSURLSession sharedSession] dataTaskWithURL:apiUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
             NSMutableArray<SecondModel *> *secondModelArr = [[NSMutableArray alloc] init];
          
            NSMutableDictionary *cityInfo = jsonResponse[@"city"];
            NSMutableArray *weatherInfo = jsonResponse[@"list"];
            NSMutableString *cityName = cityInfo[@"name"];
            
            
            
            SecondModel *firstDay = [self toGetOneDayWeatherInfo:weatherInfo startIndex:0 endIndex:7 cityName:cityName];
            SecondModel *secondDay = [self toGetOneDayWeatherInfo:weatherInfo startIndex:8 endIndex:15 cityName:cityName];
            SecondModel *thirdDay = [self toGetOneDayWeatherInfo:weatherInfo startIndex:16 endIndex:23 cityName:cityName];
            [secondModelArr addObject:firstDay];
            [secondModelArr addObject:secondDay];
            [secondModelArr addObject:thirdDay];
            completion(secondModelArr, NULL);
        }
    }]resume];
}


- (SecondModel *)toGetOneDayWeatherInfo:(NSMutableArray *)weatherInfo startIndex:(int)startIndex endIndex:(int)endIndex cityName:(NSMutableString *)cityName{
    
    NSMutableArray<SecondModel *> *externalArr = [[NSMutableArray alloc] init];
    double minTemp = 0.0;
    double maxTemp = 0.0;
    
    
    for(int weatherIndex = startIndex; weatherIndex <= endIndex; weatherIndex++) {
        NSMutableDictionary *value = weatherInfo[weatherIndex];
        NSMutableString *date = value[@"dt_txt"];
        NSMutableDictionary *mainWeather = value[@"main"];
        NSMutableArray *weather = value[@"weather"];
        
        double temp_min = [mainWeather[@"temp_min"] doubleValue];
        double temp_max = [mainWeather[@"temp_max"] doubleValue];
        long humidity = [mainWeather[@"humidity"] longValue];
        
        NSMutableString *description = weather[0][@"description"];
        NSMutableString *icon = weather[0][@"icon"];
        
        if (minTemp == 0 && maxTemp == 0){
            SecondModel *obj = [[SecondModel alloc] init];
            self.secondModelExternalObj = obj;
            self.secondModelExternalObj.name = cityName;
        }
        
        
        if (minTemp == 0){
             minTemp = temp_min;
            self.secondModelExternalObj.temp_min = minTemp;
        }
       
        if(temp_min < minTemp){
            minTemp = temp_min;
            self.secondModelExternalObj.temp_min = minTemp;
        }
        
        if(maxTemp == 0) {
             maxTemp = temp_max;
            self.secondModelExternalObj.temp_max = maxTemp;
        }
       
        if(temp_max > maxTemp) {
            maxTemp = temp_max;
            self.secondModelExternalObj.temp_max = maxTemp;
        }
        self.secondModelExternalObj.desc = description;
        self.secondModelExternalObj.humidity = humidity;
        self.secondModelExternalObj.date = date;
        self.secondModelExternalObj.icon = icon;
        if(weatherIndex % 7 == 0){
          [externalArr addObject:self.secondModelExternalObj];
        }
 
    }
    return externalArr.lastObject;
}
    





@end
