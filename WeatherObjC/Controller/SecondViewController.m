//
//  SecondViewController.m
//  WeatherObjC
//
//  Created by Ady on 9/14/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import "SecondViewController.h"
#import "NetworkHandler.h"
#import "SecondTableViewCell.h"
#import "SecondModel.h"


@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UITableView *weathertblView;
@property (strong, nonatomic) NSMutableArray *secondArr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Three Day Weather Forecast";
    [self loadData];
    [self weathertblView].estimatedRowHeight = 107;
    [self weathertblView].rowHeight = 107;
    self.weathertblView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   
}

- (void)loadData {
    
    FirstModel *obj = self.firstModelObj;
    NSString *lat = obj.lat;
    NSString *lon = obj.lon;
    
    [NetworkHandler.sharedInstance getWeatherWithLatitude:lat longitude:lon completion:^(NSMutableArray *weatherResponseArr, NSError *error) {
        if (!error) {
            NSLog(@"%@", weatherResponseArr);
            self.secondArr = weatherResponseArr;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.weathertblView reloadData];
            });
        }
    }];
}

-(NSString *)formatDateWithString:(NSString *)date{
    NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * convrtedDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"dd-MMM-yyy"];
    NSString *dateString = [formatter stringFromDate:convrtedDate];
    return dateString;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.secondArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondTableViewCell *cell = (SecondTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SecondTableViewCell"];
    SecondModel *secondModelObj = self.secondArr[indexPath.row];
    FirstModel *firstModelObj = self.firstModelObj;
    cell.nameLbl.text = firstModelObj.name;
    cell.descriptionLbl.text = secondModelObj.desc;
    cell.minTempLbl.text = [NSString stringWithFormat:@"%.2f°C", secondModelObj.temp_min - 273.15];
    cell.maxTempLbl.text = [NSString stringWithFormat:@"%.2f°C", secondModelObj.temp_max - 273.15];
    NSString *humidityStr = [NSString stringWithFormat:@"%.2ld", secondModelObj.humidity];
    cell.humidityLbl.text = [humidityStr stringByAppendingString:@"%"];
    cell.dateLbl.text = [self formatDateWithString:secondModelObj.date];
    NSString *imgStr = [NSString stringWithFormat:@"https://openweathermap.org/img/w/%@.png", secondModelObj.icon];
    NSURL *url = [NSURL URLWithString:imgStr];
    [cell.weatherImgView sd_setImageWithURL:url];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
