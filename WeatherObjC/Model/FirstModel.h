//
//  FirstModel.h
//  WeatherObjC
//
//  Created by Ady on 9/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *c;
@property (strong, nonatomic) NSString *zmw;
@property (strong, nonatomic) NSString *tz;
@property (strong, nonatomic) NSString *tzs;
@property (strong, nonatomic) NSString *l;
@property (strong, nonatomic) NSString *ll;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;

- (instancetype)initWithName:(NSString *)name type:(NSString *)type c:(NSString *)c zmw:(NSString *)zmw tz:(NSString *)tz tzs:(NSString *)tzs l:(NSString *)l ll:(NSString *)ll lat:(NSString *)lat lon:(NSString *)lon;

@end
