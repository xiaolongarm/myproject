//
//  ChagangMonitorWarningAreaInformationViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-4-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ChagangMonitorWarningAreaInformationViewController.h"
#import "ChagangMonitorWarningAreaInformationTableViewCell.h"

@interface ChagangMonitorWarningAreaInformationViewController (){
    NSArray *tableArray;
    int userId;
    NSString *rowId;
}

@end

@implementation ChagangMonitorWarningAreaInformationViewController

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
    
    self.detailsTableView.delegate=self;
    self.detailsTableView.dataSource=self;
    self.detailsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    rowId=@"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChagangMonitorWarningAreaInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChagangMonitorWarningAreaInformationTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    cell.itemDate.text=[dict objectForKey:@"start_time"];
    
    int during_sec=[[dict objectForKey:@"during_sec"] intValue];
    NSString *secString=@"";
    if(during_sec > 60){
        int min=during_sec/60;
        int ss=during_sec%60;
        secString=[NSString stringWithFormat:@"%d分 %d秒",min,ss];
    }
    if(during_sec > 3600){
        int hh=during_sec/3600;
        int hh_m=during_sec%3600;
        
        int min=hh_m/60;
        int ss=hh_m%60;
        secString=[NSString stringWithFormat:@"%d时 %d分 %d秒",hh,min,ss];
    }
    
    cell.itemDuringSec.text=secString;
    
    BOOL is_back;
    if([dict objectForKey:@"is_back"] == [NSNull null])
        is_back=NO;
    else
        is_back =[[dict objectForKey:@"is_back"] boolValue];
    if(is_back){
        cell.itemState.text=@"已回归";
        cell.itemState.textColor=[UIColor greenColor];
    }
    else{
        cell.itemState.text=@"未回归";
        cell.itemState.textColor=[UIColor redColor];
    }
    
    int gps_sta =[[dict objectForKey:@"gps_sta"] intValue];
    switch (gps_sta) {
        case 0:
            cell.itemTerminalState.text=@"正常";
            break;
        case 1:
            cell.itemTerminalState.text=@"未开启gps上报";
            break;
        case 2:
            cell.itemTerminalState.text=@"无网络";
            break;
        case 3:
            cell.itemTerminalState.text=@"未登录";
            break;
            
        default:
            break;
    }
    
    BOOL check_state=[[dict objectForKey:@"check_state"] boolValue];
    int row_id=[[dict objectForKey:@"row_id"] intValue];
    if(!check_state)
        rowId=[rowId stringByAppendingFormat:@"%d,",row_id];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}
//mobile = 13973177816;
//"user_id" = 4;
//"user_name" = "\U848b\U679c";
//warningDetail =         (
//                         {
//                             "check_state" = 1;
//                             "during_sec" = 6463;
//                             "gps_sta" = 1;
//                             "is_back" = 0;
//                             "row_id" = 84;
//                             "start_time" = "2015-04-13 09:32:17";
//                         },
//                         {
//                             "check_state" = 0;
//                             "during_sec" = 751;
//                             "gps_sta" = 1;
//                             "is_back" = 0;
//                             "row_id" = 85;
//                             "start_time" = "2015-04-13 11:30:51";
//                         }
//                         );
-(void)loadWarningInformation:(NSDictionary*)details{
    lbUser.text=[NSString stringWithFormat:@"%@ %@",[details objectForKey:@"user_name"],[details objectForKey:@"mobile"]];
    tableArray=[details objectForKey:@"warningDetail"];
    userId = [[details objectForKey:@"user_id"] intValue];
    [self.detailsTableView reloadData];
}
- (IBAction)cancel:(id)sender {
    rowId=[rowId substringToIndex:[rowId length]-1];
    [self.delegate chagangMonitorWarningAreaInformationViewControllerDidCancel:rowId];
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

@end
