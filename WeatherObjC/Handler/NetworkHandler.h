//
//  NetworkHandler.h
//  WeatherObjC
//
//  Created by Ady on 9/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHandler : NSObject

+(instancetype)sharedInstance;

-(void)getJsonResponseWithSearchText:(NSString *)searchText completion:(void (^)(NSMutableArray *, NSError *))completion;

-(void)getWeatherWithLatitude:(NSString *)latitude longitude:(NSString *)longitude completion:(void (^)(NSMutableArray *, NSError *))completion;

@end
