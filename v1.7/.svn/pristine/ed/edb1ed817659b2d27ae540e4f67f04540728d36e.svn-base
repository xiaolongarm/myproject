//
//  OtherRegressManagerListTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-1-13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "OtherRegressManagerListTableViewController.h"
#import "OtherRegressManagerListTableViewCell.h"
#import "Group.h"
#import "CustomerManager.h"
#import "OtherRegressManagerCustomerListViewController.h"

@interface OtherRegressManagerListTableViewController ()<UISearchBarDelegate>{
    CustomerManager *selectCustomerManager;
    UISearchBar *searchbar;
    NSArray *tableArray;
}

@end

@implementation OtherRegressManagerListTableViewController

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
    
    tableArray=self.user.customerManagerInfo;
}
-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - search delegate
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
        tableArray=self.user.customerManagerInfo;
        [self.tableView reloadData];
        return;
    }
    
    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
    for (CustomerManager *customerManager in self.user.customerManagerInfo) {
        
        NSString *phoneNumber=customerManager.vip_mngr_msisdn;
        NSString *groupName=customerManager.vip_mngr_name;
        
        NSRange range1=[groupName rangeOfString:searchText];
        if(range1.location!= NSNotFound)
            [tmpArray addObject:customerManager];
        
        NSRange range2=[phoneNumber rangeOfString:searchText];
        if(range2.location!= NSNotFound)
            [tmpArray addObject:customerManager];
    }
    
    tableArray=tmpArray;
    [self.tableView reloadData];
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
    OtherRegressManagerListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherRegressManagerListTableViewCell" forIndexPath:indexPath];
    
//    Group *group=[self.user.groupInfo objectAtIndex:indexPath.row];
    CustomerManager *manager=[tableArray objectAtIndex:indexPath.row];
    cell.itemName.text=manager.vip_mngr_name;
    cell.itemPhone.text=manager.vip_mngr_msisdn;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectCustomerManager=[self.user.customerManagerInfo objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"OtherRegressManagerCustomerListSegue" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"OtherRegressManagerCustomerListSegue"]){
        OtherRegressManagerCustomerListViewController *controller=segue.destinationViewController;
        controller.customerManager=selectCustomerManager;
        controller.user=self.user;
    }
}

@end
