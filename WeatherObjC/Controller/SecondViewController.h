//
//  SecondViewController.h
//  WeatherObjC
//
//  Created by Ady on 9/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"
#import <SDWebImage.h>

@interface SecondViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) FirstModel *firstModelObj;

@end
