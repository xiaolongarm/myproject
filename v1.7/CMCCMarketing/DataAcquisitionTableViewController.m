//
//  DataAcquisitionTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-28.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "DataAcquisitionTableViewController.h"
#import "DataAcquisitionTableViewCell.h"
#import "DataAcquisitionReportedTableViewController.h"
#import "DataAcquisitionActivityCostsViewController.h"
#import "DataAcquisitionVisitedDetailsViewController.h"
#import "DataAcquisitionNetworkProblemsTableViewController.h"

#import "DataAcquisitionVipInformationsTableViewController.h"
#import "DataAcquisitionClientServerSegueTableViewController.h"
#import "MBProgressHUD.h"
#import "DataAcquisitionExtendTableViewController.h"

@interface DataAcquisitionTableViewController ()<MBProgressHUDDelegate>{
    NSArray *tableArray;
    NSString *sendString;
}

@end

@implementation DataAcquisitionTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    tableArray=[[NSArray alloc] initWithObjects:@"关键人信息",@"客户服务",@"网络问题台帐",@"竟品信息上报", nil];
    
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
   tableArray=[[NSArray alloc] initWithObjects:@"关键人信息",@"客户服务",@"网络问题台帐",@"竞品信息上报", nil];
#endif
    
#if (defined MANAGER_SY_VERSION) || (defined STANDARD_SY_VERSION)
   tableArray=[[NSArray alloc] initWithObjects:@"市场信息上报",@"业务申报", nil];
#endif
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
    
//    if(self.user)
//        NSLog(@"user:%@",self.user.userName);
}
-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataAcquisitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataAcquisitionTableViewCell" forIndexPath:indexPath];
    
    cell.itemName.text=[tableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    if(indexPath.row == 0){
        //        [self performSegueWithIdentifier:@"DataAcquisitionActivityCostsSegue" sender:self];
        [self performSegueWithIdentifier:@"DataAcquisitionVipInformationsSegue" sender:self];
    }
    if(indexPath.row == 1){
        //        [self performSegueWithIdentifier:@"DataAcquisitionVisitedDetailsSegue" sender:self];
        [self performSegueWithIdentifier:@"DataAcquisitionClientServerSegue" sender:self];
        
    }
    if(indexPath.row == 2){
        [self performSegueWithIdentifier:@"DataAcquisitionNetworkProblemsSegue" sender:self];
    }
    if(indexPath.row == 3){
        [self performSegueWithIdentifier:@"DataAcquisitionReportedSegue" sender:self];
    }
#endif
    
#if (defined MANAGER_SY_VERSION) || (defined STANDARD_SY_VERSION)
    
    if(indexPath.row == 0){
        sendString= @"市场信息上报";
    }
    if(indexPath.row == 1){
        sendString= @"业务申报";
    }

    [self performSegueWithIdentifier:@"DataAcquisitionExtendSegue" sender:self];
#endif
    
}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud = nil;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"DataAcquisitionVipInformationsSegue"]){//关键人信息
        DataAcquisitionVipInformationsTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"DataAcquisitionClientServerSegue"]){//客户服务
        DataAcquisitionClientServerSegueTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"DataAcquisitionReportedSegue"]){//竞品上报
        DataAcquisitionReportedTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"DataAcquisitionNetworkProblemsSegue"]){//网络问题台账
        DataAcquisitionNetworkProblemsTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    //邵阳
    if([segue.identifier isEqualToString:@"DataAcquisitionExtendSegue"]){
        DataAcquisitionExtendTableViewController *controller=segue.destinationViewController;
        controller.recipeTitle=sendString;
        controller.user=self.user;
    }
}


@end
