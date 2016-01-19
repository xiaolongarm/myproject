//
//  MarketingGroupUserFilterViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-10-9.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "MarketingGroupUserFilterViewController.h"
#import "MarketingGroupUserFilterTableViewCell.h"

@interface MarketingGroupUserFilterViewController (){
    NSMutableArray *filterArray;
}

@end

@implementation MarketingGroupUserFilterViewController
@synthesize _filterArray=filterArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadFilterData];
    self.filterOfTimePeriod=0;
    filterTableView.dataSource=self;
    filterTableView.delegate=self;
}
-(void)loadFilterData{

    //customers-filter
    
    NSString *path = [[NSBundle mainBundle]  pathForResource:@"customers-filter" ofType:@"json"];
    NSLog(@"path:%@",path);
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:path ];
    NSLog(@"length:%d",[jdata length]);
    NSError *error = nil;
    NSDictionary * adata = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *dict=[adata objectForKey:@"filter"];
    
    filterArray=[[NSMutableArray alloc] init];
    
    for (NSString *key in [dict allKeys]) {
        NSDictionary *item=[dict objectForKey:key];
        for (NSString *k in [item allKeys]) {
            NSString *v=[item objectForKey:k];
            
            NSMutableDictionary *tmp=[[NSMutableDictionary alloc] init];
            [tmp setObject:key forKey:@"type"];
            [tmp setObject:k forKey:@"key"];
            [tmp setObject:v forKey:@"value"];
            [tmp setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
            [filterArray addObject:tmp];
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filterArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    MarketingGroupUserFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketingGroupUserFilterTableViewCell"];
    NSDictionary *dict=[filterArray objectAtIndex:indexPath.row];
    BOOL selected =[[dict objectForKey:@"selected"] boolValue];
    cell.itemName.text=[dict objectForKey:@"value"];
    if(!selected){
        [cell.itemSelected setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    }
    else{
        [cell.itemSelected setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketingGroupUserFilterTableViewCell *cell = (MarketingGroupUserFilterTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *dict=[filterArray objectAtIndex:indexPath.row];
    BOOL selected =[[dict objectForKey:@"selected"] boolValue];
    if(selected){
        [cell.itemSelected setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
        [dict setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
    }
    else{
        [cell.itemSelected setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
        [dict setObject:[NSNumber numberWithBool:YES] forKey:@"selected"];

    }
}

- (IBAction)cancelOnclick:(id)sender {
    [self.delegate marketingGroupUserFilterViewControllerDidCanceled];
}
- (IBAction)submitOnclick:(id)sender {
    [self.delegate marketingGroupUserFilterViewControllerDidFinished:self];
}


- (IBAction)marketingOfWeekButtonOnclick:(id)sender {
    if(marketingOfWeekImage.tag){
        [marketingOfWeekImage setImage:[UIImage imageNamed:@"未勾选"]];
        marketingOfWeekImage.tag=0;
        self.filterOfTimePeriod=0;
    }
    else{
        [marketingOfWeekImage setImage:[UIImage imageNamed:@"勾选"]];
        marketingOfWeekImage.tag=1;
        self.filterOfTimePeriod=1;
    }
    
    marketingOfMonthImage.image=[UIImage imageNamed:@"未勾选"];
    marketingOfMonthImage.tag=0;
}
- (IBAction)marketingOfMonthButtonOnclick:(id)sender {
    if(marketingOfMonthImage.tag){
        [marketingOfMonthImage setImage:[UIImage imageNamed:@"未勾选"]];
        marketingOfMonthImage.tag=0;
        self.filterOfTimePeriod=0;
    }
    else{
        [marketingOfMonthImage setImage:[UIImage imageNamed:@"勾选"]];
        marketingOfMonthImage.tag=1;
        self.filterOfTimePeriod=2;
    }
    
    marketingOfWeekImage.image=[UIImage imageNamed:@"未勾选"];
    marketingOfWeekImage.tag=0;
}

@end
