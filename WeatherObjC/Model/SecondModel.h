//
//  SecondModel.h
//  WeatherObjC
//
//  Created by Ady on 9/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondModel : NSObject

@property (assign, nonatomic) double temp_min;
@property (assign, nonatomic) double temp_max;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) long humidity;
@property (strong, nonatomic) NSString *date;


- (instancetype)initWithName:(NSString *)name temp_min:(double)temp_min temp_max:(double)temp_max desc:(NSString *)desc icon:(NSString *)icon humidity:(long)humidity date:(NSString *)date;

@end
