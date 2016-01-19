//
//  W_VisitPlanAddSelectGroupContactUserTableViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-20.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanAddSelectGroupContactUserTableViewController.h"

@interface W_VisitPlanAddSelectGroupContactUserTableViewController ()<UISearchBarDelegate>{
    UISearchBar *searchbar;
    NSArray *fullArray;
}

@end

@implementation W_VisitPlanAddSelectGroupContactUserTableViewController

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
    [self initSubView];
    
//    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSelected)];
//    [rightButton setTintColor:[UIColor whiteColor]];
//    [self.navigationItem setRightBarButtonItem:rightButton];
}
//-(void)cancelSelected{
//    self.selectUserDict=nil;
//    [self.delegate visitPlanAddSelectGroupContactUserTableViewControllerDidCanceled];
//    [self.navigationController popViewControllerAnimated:YES];
//}
- (void)initSubView{
    
    self.navigationItem.title = @"选择联系人";
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"查询按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    CGRect rect=self.view.frame;
    rect.size.height=44;
    //    rect.origin.y=;
    //    rect.origin.x=0;
    rect.origin=CGPointZero;
    searchbar=[[UISearchBar alloc] init];
    searchbar.placeholder=@"请输入关键字查询";
    searchbar.frame=rect;
    searchbar.delegate=self;
    [self.view addSubview:searchbar];
    searchbar.hidden=YES;
    
    fullArray=self.tableArray;
    
    if (!self.selectedArray) {
        self.selectedArray = [NSMutableArray new];
    }
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
        self.tableArray=fullArray;
        [self.tableView reloadData];
        return;
    }
    
    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
    for (NSDictionary *item in fullArray) {
        
        NSString *phoneNumber=[item objectForKey:@"linkman_msisdn"];
        NSString *groupName=[item objectForKey:@"linkman"];
        NSString *jobName=[item objectForKey:@"job"];
        
        NSRange range1=[groupName rangeOfString:searchText];
        if(range1.location!= NSNotFound)
            [tmpArray addObject:item];
        
        NSRange range2=[phoneNumber rangeOfString:searchText];
        if(range2.location!= NSNotFound)
            [tmpArray addObject:item];
        
        NSRange range3=[jobName rangeOfString:searchText];
        if(range3.location!= NSNotFound)
            [tmpArray addObject:item];
    }
    
    self.tableArray=tmpArray;
    [self.tableView reloadData];
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
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    VisitPlanAddSelectGroupContactUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitPlanAddSelectGroupContactUserTableViewCell" forIndexPath:indexPath];
//    
//    NSDictionary *dict=[self.tableArray objectAtIndex:indexPath.row];
//    cell.itemPhone.text=[dict objectForKey:@"linkman_msisdn"];
//    cell.itemGroup.text=self.group.groupName;
//    cell.itemName.text=[dict objectForKey:@"linkman"];
//    cell.itemJob.text=[dict objectForKey:@"job"];
//    
//    
//    if(self.selectUserDict)
//        cell.itemImageViewWithSelected.hidden=![[self.selectUserDict objectForKey:@"linkman_msisdn"] isEqualToString:[dict objectForKey:@"linkman_msisdn"]];
//    else
//        cell.itemImageViewWithSelected.hidden=YES;
//    
//    
//    return cell;
    
//    W_VisitPlanAddSelectGroupContactUserTableViewControllerCell
    
    static NSString *CellIdentifier = @"W_VisitPlanAddSelectGroupContactUserTableViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    NSDictionary *dict = [self.tableArray objectAtIndex:indexPath.row];
    UILabel *lblPhone = (UILabel *)[cell viewWithTag:200];
    lblPhone.text =[dict objectForKey:@"linkman_msisdn"];
    UILabel *lblGroup = (UILabel *)[cell viewWithTag:600];
    lblGroup.text =self.group.groupName;
    UILabel *lblName = (UILabel *)[cell viewWithTag:300];
    lblName.text =[dict objectForKey:@"linkman"];
    UILabel *lblJob = (UILabel *)[cell viewWithTag:400];
    lblJob.text =[dict objectForKey:@"job"];
    
    UIImageView *t_imgChoose = (UIImageView *)[cell viewWithTag:500];
    
    
//    if(self.selectUserDict){
//        
//        t_imgChoose.hidden=![[self.selectUserDict objectForKey:@"linkman_msisdn"] isEqualToString:[dict objectForKey:@"linkman_msisdn"]];
//    }else{
//        
//        t_imgChoose.hidden=YES;
//    }
    t_imgChoose.hidden=YES;
    if([self.selectedArray count] > 0){
        NSString *msisdn =[dict objectForKey:@"linkman_msisdn"];
        BOOL isExist=NO;
        for (NSDictionary *d in self.selectedArray) {
            NSString *linkmanMsisdn =[d objectForKey:@"linkman_msisdn"];
            if([msisdn isEqualToString:linkmanMsisdn]){
                isExist=YES;
                break;
            }
        }
        
        t_imgChoose.hidden=!isExist;
    }
    
    
    UIImageView *userImageView=(UIImageView*)[cell viewWithTag:100];
    NSString *imageUrl=[dict objectForKey:@"userimg"];
    if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
        NSURL *url = [NSURL URLWithString:imageUrl];
        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        dispatch_async(queue, ^{
            
            NSData *resultData = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:resultData];
            if(img){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    userImageView.image = img;
                });
            }
        });
    }

    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *selectedDict =[self.tableArray objectAtIndex:indexPath.row];
//    int row_id=[[selectedDict objectForKey:@"row_id"] intValue];
    NSString *msisdn =[selectedDict objectForKey:@"linkman_msisdn"];
    BOOL isExist=NO;
    NSDictionary *existDict;
    for (NSDictionary *dict in self.selectedArray) {
//        int rowid =[[dict objectForKey:@"row_id"] intValue];
//        if(row_id == rowid){
        NSString *linkmanMsisdn =[dict objectForKey:@"linkman_msisdn"];
        if([msisdn isEqualToString:linkmanMsisdn]){
            isExist=YES;
            existDict=dict;
            break;
        }
    }
    
    if(isExist){
        [self.selectedArray removeObject:existDict];
    }
    else{
        if([self.selectedArray count] <3){
            [self.selectedArray addObject:selectedDict];
        }
    }

    
    [self.tableView reloadData];
    
    [self.delegate visitPlanAddSelectGroupContactUserTableViewControllerDidFinished:self];
//    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
