//
//  KnowledgeBaseTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-23.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "KnowledgeBaseTableViewCell.h"
#import "KnowledgeBaseTableViewController.h"
#import "KnowledgeBaseSecondaryTableViewController.h"
//#import "KnowledgeBaseWithBusinessViewController.h"

#import "KnowledgeBaseWithBusinessTableViewController.h"

#import "MBProgressHUD.h"
@interface KnowledgeBaseTableViewController ()<MBProgressHUDDelegate>{
    NSArray *tableArray;

}

@end

@implementation KnowledgeBaseTableViewController

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
    
    tableArray=[[NSArray alloc] initWithObjects:@"最新优惠活动",@"业务知识查询",@"竞品信息查询", nil];
    
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    tableArray=[[NSArray alloc] initWithObjects:@"最新优惠活动",@"业务知识查询",@"竞品信息查询",@"产品视频介绍", nil];
#endif
    
#if (defined MANAGER_SY_VERSION) || (defined STANDARD_SY_VERSION)
    tableArray=[[NSArray alloc] initWithObjects:@"2015年主推资费",@"最新优惠活动",@"业务知识查询",@"市场信息查询", nil];
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
    KnowledgeBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KnowledgeBaseTableViewCell" forIndexPath:indexPath];
    cell.itemName.text=[tableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    #if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    if(indexPath.row == 0)
        [self performSegueWithIdentifier:@"KnowledgeBaseSecondarySegue" sender:self];
    if(indexPath.row == 1)
        [self performSegueWithIdentifier:@"KnowledgeBaseWithBusinessSegue" sender:self];
    if(indexPath.row == 2)
        [self showErrorMessage:@"正在建设中..."];
    if(indexPath.row == 3)
        [self performSegueWithIdentifier:@"ProductViedoSegue" sender:self];
#endif
    #if (defined MANAGER_SY_VERSION) || (defined STANDARD_SY_VERSION)
    if(indexPath.row == 0)
        [self performSegueWithIdentifier:@"KnowledgeBaseWithSalesSegue" sender:self];
    if(indexPath.row == 1)
        [self performSegueWithIdentifier:@"KnowledgeBaseSecondarySegue" sender:self];
    if(indexPath.row == 2)
        [self performSegueWithIdentifier:@"KnowledgeBaseWithBusinessSegue" sender:self];
    if(indexPath.row == 3)
        [self showErrorMessage:@"正在建设中..."];
    #endif
}

-(void)showErrorMessage:(NSString *)title{
    
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = title;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
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
    if([segue.identifier isEqualToString:@"KnowledgeBaseSecondarySegue"]){
        KnowledgeBaseSecondaryTableViewController *tableviewController=segue.destinationViewController;
        tableviewController.title=[tableArray objectAtIndex:0];
        tableviewController.user=self.user;
    }
    if([segue.identifier isEqualToString:@"KnowledgeBaseWithBusinessSegue"]){
        KnowledgeBaseWithBusinessTableViewController *viewController=segue.destinationViewController;
        viewController.title=[tableArray objectAtIndex:1];
        viewController.user=self.user;
    }
        
        
}


@end
