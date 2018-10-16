//
//  SecondModel.m
//  WeatherObjC
//
//  Created by Ady on 9/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import "SecondModel.h"

@implementation SecondModel

- (instancetype)initWithName:(NSString *)name temp_min:(double)temp_min temp_max:(double)temp_max desc:(NSString *)desc icon:(NSString *)icon humidity:(long)humidity date:(NSString *)date {
    
    if(self = [super init]) {
        self.name = name;
        self.temp_min = temp_min;
        self.temp_max = temp_max;
        self.desc = desc;
        self.icon = icon;
        self.humidity = humidity;
        self.date = date;
    }
    return self;
}

@end
