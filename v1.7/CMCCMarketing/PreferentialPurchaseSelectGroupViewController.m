//
//  PreferentialPurchaseSelectGroupViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-10-16.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "MarketingGroupUserFilterTableViewCell.h"
#import "PreferentialPurchaseSelectGroupViewController.h"


@interface PreferentialPurchaseSelectGroupViewController (){
//    NSMutableArray *filterArray;
//    MarketingGroupUserFilterTableViewCell *selectCell;
    NSArray *tableArray;
}

@end

@implementation PreferentialPurchaseSelectGroupViewController
//@synthesize _filterArray=filterArray;

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
    self.filterOfTimePeriod=0;
    filterTableView.dataSource=self;
    filterTableView.delegate=self;
    
    
#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    NSMutableArray *tmpArray=[NSMutableArray new];
    for (CustomerManager *customerManager in self.user.customerManagerInfo) {
        for (Group *group in customerManager.groupList) {
            [tmpArray addObject:group];
        }
    }
    tableArray=tmpArray;
#endif
    
#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    tableArray=self.user.groupInfo;
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketingGroupUserFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketingGroupUserFilterTableViewCell"];
    
    Group *group=[tableArray objectAtIndex:indexPath.row];
    cell.itemName.text = group.groupName;
//    CustomerManager *customerGrounp=[self.user.customerManagerInfo objectAtIndex:indexPath.row];
//    cell.itemName.text =customerGrounp.groupList ob
//
    if(self.group && [self.group.groupId isEqualToString:group.groupId]){
        [cell.itemSelected setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    }
    else{
        [cell.itemSelected setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketingGroupUserFilterTableViewCell *cell=(MarketingGroupUserFilterTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.itemSelected setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
    self.group=[tableArray objectAtIndex:indexPath.row];
    [self.delegate preferentialPurchaseSelectGroupViewControllerDidFinished:self];

    
}

- (IBAction)cancelOnclick:(id)sender {
    self.group=nil;
    [self.delegate preferentialPurchaseSelectGroupViewControllerDidCanceled];
}
- (IBAction)submitOnclick:(id)sender {
    [self.delegate preferentialPurchaseSelectGroupViewControllerDidFinished:self];
}

@end

