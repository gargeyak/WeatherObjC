//
//  SecondTableViewCell.h
//  WeatherObjC
//
//  Created by Ady on 9/18/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *humidityLbl;
@property (weak, nonatomic) IBOutlet UILabel *minTempLbl;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImgView;

@end
