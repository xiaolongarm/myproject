//
//  VisitPlanMainListTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-1-4.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "VisitPlanMainListTableViewController.h"
#import "W_VisitPlanViewController.h"
#import "ManagerWorkRecordViewController.h"
#import "WorkRecordViewController.h"
#import "AlreadyVisitPlanListViewController.h"

@interface VisitPlanMainListTableViewController (){
    NSArray *tableArray;
}

@end

@implementation VisitPlanMainListTableViewController


-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"工作计划";
    tableArray=[[NSArray alloc] initWithObjects:@"工作日报",@"拜访计划", nil];
    /**
     *  长沙主管拜访计划添加已完成拜访计划数量
     */
    
#if (defined MANAGER_CS_VERSION)
     tableArray=[[NSArray alloc] initWithObjects:@"工作日报",@"拜访计划",@"工作日志日报", nil];
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
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[tableArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //工作日志
    if(indexPath.row == 0){
        
#if (defined MANAGER_SY_VERSION) || (defined MANAGER_CS_VERSION)
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Manager.WorkRecord" bundle:nil];
        ManagerWorkRecordViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ManagerWorkRecordViewControllerId"];
        vc.user = self.user;
        [self.navigationController pushViewController:vc animated:YES];
        
#endif
        
#if (STANDARD_SY_VERSION) ||  (defined STANDARD_CS_VERSION)
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"WorkRecord" bundle:nil];
        WorkRecordViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"WorkRecordViewControllerId"];
        vc.user = self.user;
        
        [self.navigationController pushViewController:vc animated:YES];
        
#endif
        
    }
    //拜访计划
    if(indexPath.row == 1){
        W_VisitPlanViewController *vc = [[W_VisitPlanViewController alloc] initWithNibName:@"W_VisitPlanViewController" bundle:nil];
        vc.user = self.user;
        vc.title=@"拜访计划";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //已完成计划拜访数量
    if(indexPath.row == 2){
        AlreadyVisitPlanListViewController *vc = [[AlreadyVisitPlanListViewController alloc] initWithNibName:@"AlreadyVisitPlanListViewController" bundle:nil];
        vc.user = self.user;
        vc.title=@"拜访计划";
        [self.navigationController pushViewController:vc animated:YES];
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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
