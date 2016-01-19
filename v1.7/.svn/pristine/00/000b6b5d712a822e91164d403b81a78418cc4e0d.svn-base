//
//  BusinesProcessViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-15.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "BusinessProcessTableViewCell.h"
#import "BusinesProcessViewController.h"
#import "FlowBusinessViewController.h"
#import "PreferentialPurchaseViewController.h"
#import "GroupBroadbandViewController.h"
#import "BusinessProcessSYViewController.h"

@interface BusinesProcessViewController (){
    NSArray *tableArray;
}

@end

@implementation BusinesProcessViewController

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

#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
   tableArray=[[NSArray alloc] initWithObjects:@"流量业务",@"优惠购机",@"集团宽带", nil];
#endif
    
#if (defined MANAGER_SY_VERSION)|| (defined STANDARD_SY_VERSION)
    tableArray=[[NSArray alloc] initWithObjects:@"4G套餐",@"4G终端",@"4G流量",@"集团宽带", nil];
#endif
   
}
-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessProcessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessProcessTableViewCell" forIndexPath:indexPath];
    
    cell.itemName.text=[tableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        
        
        
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
        [self performSegueWithIdentifier:@"flowBusinessSegue" sender:self];
#endif
        
#if (defined MANAGER_SY_VERSION)|| (defined STANDARD_SY_VERSION)
        BusinessProcessSYViewController *controller=[[BusinessProcessSYViewController alloc] initWithNibName:@"BusinessProcessSYViewController" bundle:nil];
        controller.user=self.user;
        controller.busType=indexPath.row;
        [self.navigationController pushViewController:controller animated:YES];
#endif
        
        
    }
    if(indexPath.row == 1){
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
        [self performSegueWithIdentifier:@"preferentialPurchaseSegue" sender:self];
#endif
        
#if (defined MANAGER_SY_VERSION)|| (defined STANDARD_SY_VERSION)
        BusinessProcessSYViewController *controller=[[BusinessProcessSYViewController alloc] initWithNibName:@"BusinessProcessSYViewController" bundle:nil];
        controller.user=self.user;
        controller.busType=indexPath.row;
        [self.navigationController pushViewController:controller animated:YES];
#endif
        
    }
    if(indexPath.row == 2){
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
        [self performSegueWithIdentifier:@"groupBroadbandSegue" sender:self];
#endif
        
#if (defined MANAGER_SY_VERSION)|| (defined STANDARD_SY_VERSION)
        BusinessProcessSYViewController *controller=[[BusinessProcessSYViewController alloc] initWithNibName:@"BusinessProcessSYViewController" bundle:nil];
        controller.user=self.user;
        controller.busType=indexPath.row;
        [self.navigationController pushViewController:controller animated:YES];
#endif
        
    }
    if(indexPath.row == 3){
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
        
#endif
        
#if (defined MANAGER_SY_VERSION)|| (defined STANDARD_SY_VERSION)
    [self performSegueWithIdentifier:@"groupBroadbandSegue" sender:self];
#endif
        
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if([segue.identifier isEqualToString:@"preferentialPurchaseSegue"]){
//        UITabBarController *tabbarController=segue.destinationViewController;
//        [tabbarController.tabBar setTintColor:[UIColor whiteColor]];
////        UIViewController *viewController = [tabbarController.viewControllers objectAtIndex:0];
////        [viewController removeFromParentViewController];
////        [tabbarController.tabBar setHidden:YES];
////        tabbarController.selectedIndex=1;
//      
//    }
    
    //flowBusinessSegue
    if([segue.identifier isEqualToString:@"flowBusinessSegue"]){
        FlowBusinessViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"preferentialPurchaseSegue"]){
        PreferentialPurchaseViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"groupBroadbandSegue"]){
        GroupBroadbandViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
}


@end
