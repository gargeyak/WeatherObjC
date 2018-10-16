//
//  FirstModel.m
//  WeatherObjC
//
//  Created by Ady on 9/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import "FirstModel.h"

@implementation FirstModel

- (instancetype)initWithName:(NSString *)name type:(NSString *)type c:(NSString *)c zmw:(NSString *)zmw tz:(NSString *)tz tzs:(NSString *)tzs l:(NSString *)l ll:(NSString *)ll lat:(NSString *)lat lon:(NSString *)lon {
    
    if(self = [super init]) {
        self.name = name;
        self.type = type;
        self.c = c;
        self.zmw = zmw;
        self.tz = tz;
        self.tzs = tzs;
        self.l = l;
        self.ll = ll;
        self.lat = lat;
        self.lon = lon;
    }
    return self;
}

@end
