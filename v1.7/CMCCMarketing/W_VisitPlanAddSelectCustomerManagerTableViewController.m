//
//  W_VisitPlanAddSelectCustomerManagerTableViewController.m
//  CMCCMarketing
//
//  Created by gmj on 15-1-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "W_VisitPlanAddSelectCustomerManagerTableViewController.h"
#import "VariableStore.h"

@interface W_VisitPlanAddSelectCustomerManagerTableViewController ()<UISearchBarDelegate>{
    UISearchBar *searchbar;
     NSArray *fullArray;
}

@end

@implementation W_VisitPlanAddSelectCustomerManagerTableViewController


- (void)initSubView{
    
    self.navigationItem.title = [NSString stringWithFormat:@"选择%@",[VariableStore getCustomerManagerName]];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"查询按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    CGRect rect=self.view.frame;
    rect.size.height=44;
    rect.origin=CGPointZero;
    searchbar=[[UISearchBar alloc] init];
    searchbar.placeholder=@"请输入关键字查询";
    searchbar.frame=rect;
    searchbar.delegate=self;
    [self.view addSubview:searchbar];
    searchbar.hidden=YES;
    
    fullArray=self.tableArray;
}
-(void)goSearch{
    searchbar.hidden=!searchbar.hidden;
    if(searchbar.hidden)
        [searchbar resignFirstResponder];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)sBar{
    [sBar resignFirstResponder];
    [self searchBar:sBar textDidChange:sBar.text];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        self.tableArray=fullArray;
        [self.tableView reloadData];
        return;
    }
    
    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
    for (CustomerManager *customerManager in fullArray) {
        
        NSString *phoneNumber=customerManager.vip_mngr_msisdn;
        NSString *groupName=customerManager.vip_mngr_name;
        
        NSRange range1=[groupName rangeOfString:searchText];
        if(range1.location!= NSNotFound)
            [tmpArray addObject:customerManager];
        
        NSRange range2=[phoneNumber rangeOfString:searchText];
        if(range2.location!= NSNotFound)
            [tmpArray addObject:customerManager];
    }
    
    self.tableArray=tmpArray;
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.tableArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"W_VisitPlanAddSelectCustomerManagerTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    CustomerManager *c = [self.tableArray objectAtIndex:indexPath.row];
    UILabel *t_lblName = (UILabel*)[cell viewWithTag:100];
    t_lblName.text=c.vip_mngr_name;

    UIImageView *t_imgChoose = (UIImageView *)[cell viewWithTag:200];
    t_imgChoose.hidden=![self.selectCustomerManager.vip_mngr_msisdn isEqualToString: c.vip_mngr_msisdn];
    
    UILabel *t_lblPhone=(UILabel*)[cell viewWithTag:300];
    t_lblPhone.text=c.vip_mngr_msisdn;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectCustomerManager = [self.tableArray objectAtIndex:indexPath.row];
    [self.delegate w_VisitPlanAddSelectCustomerManagerTableViewControllerDidFinished:self];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
