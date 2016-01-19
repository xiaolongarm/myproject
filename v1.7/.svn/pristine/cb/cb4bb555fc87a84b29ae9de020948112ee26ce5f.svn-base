//
//  DataAcquisitionExtendTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-2-26.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "DataAcquisitionExtendTableViewController.h"
#import "DataAcquisitionExtendTableViewCell.h"

#import "DataAcquisitionWithGroupInformationTableViewController.h"
#import "DataAcquisitionWithMarketOpportunitiesTableViewController.h"
#import "DataAcquisitionWithGeneralInformationTableViewController.h"
#import "DataAq4GChangeCardTableViewController.h"
#import "DataAq4GPackageTableViewController.h"
#import "DataAq4GTermialTableViewController.h"
#import "DataAq4GDataFlowTableViewController.h"
#import "DataAq4GNetworkTableViewController.h"

@interface DataAcquisitionExtendTableViewController (){
    NSArray *tableArray;
}

@end

@implementation DataAcquisitionExtendTableViewController

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
    if ([_recipeTitle isEqualToString:@"市场信息上报"]) {
        self.navigationItem.title=@"市场信息上报";
        tableArray=[[NSArray alloc] initWithObjects:@"集团信息采集",@"大众信息采集",@"市场商机采集", nil];
    }
    if ([_recipeTitle isEqualToString:@"业务申报"]) {
        self.navigationItem.title=@"业务申报";
        tableArray=[[NSArray alloc] initWithObjects:@"4G短信换卡",@"4G套餐",@"4G终端",@"宽带发展",@"异网回归", nil];
    }
    
    
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
    DataAcquisitionExtendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataAcquisitionExtendTableViewCell" forIndexPath:indexPath];
    
    cell.itemName.text=[tableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_recipeTitle isEqualToString:@"市场信息上报"]) {
        if(indexPath.row == 0){
            [self performSegueWithIdentifier:@"DataAcquisitionWithGroupInformationSegue" sender:self];
        }
        if(indexPath.row == 1){
            [self performSegueWithIdentifier:@"DataAcquisitionWithGeneralInformationSegue" sender:self];
        }
        if(indexPath.row == 2){
            [self performSegueWithIdentifier:@"DataAcquisitionWithMarketOpportunitiesSegue" sender:self];
        }

    }
    if ([_recipeTitle isEqualToString:@"业务申报"]) {
        if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"DataAq4GChangeCardSegue" sender:self];
    }
    if(indexPath.row == 1){
        [self performSegueWithIdentifier:@"DataAq4GPackageSegue" sender:self];
    }

    if(indexPath.row == 2){
        [self performSegueWithIdentifier:@"DataAq4GTermialSegue" sender:self];
    }

    if(indexPath.row == 3){
        [self performSegueWithIdentifier:@"DataAq4GDataFlowSegue" sender:self];
    }

    if(indexPath.row == 4){
        [self performSegueWithIdentifier:@"DataAq4GNetworkSegue" sender:self];
    }

  }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"DataAcquisitionWithGroupInformationSegue"]){
        DataAcquisitionWithGroupInformationTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"DataAcquisitionWithMarketOpportunitiesSegue"]){
        DataAcquisitionWithMarketOpportunitiesTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"DataAcquisitionWithGeneralInformationSegue"]){
        DataAcquisitionWithGeneralInformationTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"DataAq4GChangeCardSegue"]){
        DataAq4GChangeCardTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    
    if([segue.identifier isEqualToString:@"DataAq4GPackageSegue"]){
        DataAq4GPackageTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"DataAq4GTermialSegue"]){
        DataAq4GTermialTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"DataAq4GDataFlowSegue"]){
        DataAq4GDataFlowTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"DataAq4GNetworkSegue"]){
        DataAq4GNetworkTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
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





@end
