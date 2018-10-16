//
//  ViewController.m
//  WeatherObjC
//
//  Created by Ady on 9/13/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

#import "ViewController.h"
#import "NetworkHandler.h"
#import "FirstModel.h"
#import "SecondViewController.h"

@interface ViewController ()

//@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) NSMutableArray<FirstModel *> *firstArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.firstArr = [[NSMutableArray alloc] init];
    self.tblView.separatorStyle = UITableViewCellSeparatorStyleNone;

}



-(void)loadDataWithSearchText:(NSString *)search{
    [NetworkHandler.sharedInstance getJsonResponseWithSearchText:search completion:^(NSMutableArray * responseArr, NSError *error) {
        self.firstArr = responseArr;
        NSLog(@"%@", responseArr);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tblView reloadData];
        });
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.firstArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    FirstModel *firstObj = self.firstArr[indexPath.row];
    
    
    cell.textLabel.text = firstObj.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    controller.firstModelObj = self.firstArr[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self loadDataWithSearchText:searchText];
        if(searchText.length == 0){
            [self.firstArr removeAllObjects];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tblView reloadData];
            });
            
        }else if(!self.firstArr || ![self.firstArr count]){
            [self loadDataWithSearchText:searchText];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tblView reloadData];
            });
        }else{
            [self loadDataWithSearchText: searchText];
            NSLog(@"%@", searchText);
        }
//    });
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
