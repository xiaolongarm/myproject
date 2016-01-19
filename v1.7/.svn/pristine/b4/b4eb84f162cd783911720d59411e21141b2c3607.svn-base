//
//  ManagerBusinessProcessTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "ManagerBusinessProcessTableViewController.h"
#import "ManagerBusinessProcessTableViewCell.h"
#import "ManagerBusinessProcessWebViewController.h"
#import "NetworkHandling.h"

@interface ManagerBusinessProcessTableViewController (){
    NSArray *tableArray;
    NSString *selectTitle;
    int selectIndex;
}

@end

@implementation ManagerBusinessProcessTableViewController

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
    tableArray=[[NSArray alloc] initWithObjects:@"团队积分排名",@"个人总积分全市排名", nil];
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
    ManagerBusinessProcessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManagerBusinessProcessTableViewCell" forIndexPath:indexPath];

    NSString *itemName=[tableArray objectAtIndex:indexPath.row];
    cell.itemTitle.text=itemName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectTitle=[tableArray objectAtIndex:indexPath.row];
    selectIndex=indexPath.row;
    [self performSegueWithIdentifier:@"ManagerBusinessProcessWebSegue" sender:self];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if([segue.identifier isEqualToString:@"ManagerBusinessProcessWebSegue"]){
         ManagerBusinessProcessWebViewController *controller=segue.destinationViewController;
         controller.title=selectTitle;
         
         NSString *basestring=[NetworkHandling getBaseUrlString];
         if(selectIndex == 0)
             basestring=[basestring stringByAppendingString:@"report/csdwrjjf.html"];
         else if(selectIndex == 1){
             basestring=[basestring stringByAppendingString:@"report/csyyjf.html"];
             controller.isAutoSize=YES;
         }
//         团队积分排名：/kite/report/csdwrjjf.html
//         个人总积分全市排名：/kite/report/csyyjf.html
//         nss [NetworkHandling getBaseUrl]
//        [controller.reportWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:basestring]]];
         controller.urlString=basestring;
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
