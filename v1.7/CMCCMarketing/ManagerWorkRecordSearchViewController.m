//
//  ManagerWorkRecordSearchViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-2-4.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ManagerWorkRecordSearchViewController.h"
#import "PreferentialPurchaseSelectDateTimeViewController.h"
#import "ManagerWorkRecordSearchTableViewCell.h"
#import "CustomerManager.h"
#import "ManagerWorkRecordDetailViewController.h"

@interface ManagerWorkRecordSearchViewController ()<PreferentialPurchaseSelectDateTimeViewControllerDelegate>{
    PreferentialPurchaseSelectDateTimeViewController *selectDateTimeViewController;
    UIView *backView;
    
    CustomerManager *selectedCustomerManager;
    NSDate *selectDatetime;
}

@end

@implementation ManagerWorkRecordSearchViewController

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
    vwSelectUserBody.hidden=YES;
    tbView.dataSource=self;
    tbView.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"searchToManagerWorkRecordDetailSegue"]){
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:selectedCustomerManager.vip_mngr_user_id] forKey:@"daily_user_id"];
        
        ManagerWorkRecordDetailViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.selectedWorkRecord = dict;
        controller.selectDate=selectDatetime;
    }
}

- (IBAction)selectUserOnclick:(id)sender {
    vwSelectUserBody.hidden=NO;
}
- (IBAction)selectDateOnclick:(id)sender {
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    selectDateTimeViewController=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseSelectDateTimeViewControllerId"];
    selectDateTimeViewController.modeDateAndTime=1;
    selectDateTimeViewController.delegate=self;
    CGRect rect=selectDateTimeViewController.view.frame;
    rect.origin.x=0;
    rect.origin.y=[[UIScreen mainScreen] bounds].size.height - 300;
    rect.size.width=320;
    rect.size.height=300;
    
    selectDateTimeViewController.view.frame=rect;
    selectDateTimeViewController.view.layer.borderWidth=1;
    selectDateTimeViewController.view.layer.borderColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0].CGColor;
    selectDateTimeViewController.view.layer.shadowOffset = CGSizeMake(2, 2);
    selectDateTimeViewController.view.layer.shadowOpacity = 0.80;
    
    backView=[[UIView alloc] init];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.1;
    
    backView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backView];
    [self.view addSubview:selectDateTimeViewController.view];

}
- (IBAction)selectUserBodyCancelOnclick:(id)sender {
    vwSelectUserBody.hidden=YES;
}

-(void)preferentialPurchaseSelectDateTimeViewControllerDidCancel{
    [backView removeFromSuperview];
    [selectDateTimeViewController.view removeFromSuperview];
    
    backView=nil;
    selectDateTimeViewController=nil;
}
-(void)preferentialPurchaseSelectDateTimeViewControllerDidFinished:(PreferentialPurchaseSelectDateTimeViewController *)controller{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString=[dateFormatter stringFromDate:controller.datetimePicker.date];
    selectDatetime=controller.datetimePicker.date;
    lbDate.text=dateString;
//    [selectDateWithButton setTitle:dateString forState:UIControlStateNormal];
    [self preferentialPurchaseSelectDateTimeViewControllerDidCancel];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.user.customerManagerInfo count] ;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ManagerWorkRecordSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManagerWorkRecordSearchTableViewCell" forIndexPath:indexPath];
    
    selectedCustomerManager=[self.user.customerManagerInfo objectAtIndex:indexPath.row];
    cell.itemName.text=selectedCustomerManager.vip_mngr_name;
    cell.itemPhone.text=selectedCustomerManager.vip_mngr_msisdn;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    vwSelectUserBody.hidden=YES;
    selectedCustomerManager=[self.user.customerManagerInfo objectAtIndex:indexPath.row];
    lbUser.text=selectedCustomerManager.vip_mngr_name;
}
- (IBAction)searchOnclick:(id)sender {
    if(!selectedCustomerManager)
        return;
    if(!selectDatetime)
        return;
    [self performSegueWithIdentifier:@"searchToManagerWorkRecordDetailSegue" sender:self];
}

@end
