//
//  W_VisitPlanAddSelectGroupTableViewController.m
//  CMCCMarketing
//
//  Created by gmj on 14-11-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "W_VisitPlanAddSelectGroupTableViewController.h"

#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "VariableStore.h"

@interface W_VisitPlanAddSelectGroupTableViewController ()<MBProgressHUDDelegate,UISearchBarDelegate>{
    
    BOOL hubFlag;
    UISearchBar *searchbar;
    NSArray *fullArray;
}

@end

@implementation W_VisitPlanAddSelectGroupTableViewController

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
//    [self initSubView];
    
//    [self loadHadVisitedGroupList];
//
    
//#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
//    self.navigationItem.title=[NSString stringWithFormat:@"选择%@",[VariableStore getCustomerManagerName]];
//#endif
//#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
//    [self loadHadVisitedGroupList];
//    self.navigationItem.title = @"选择集团";
//#endif
    
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"查询按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    CGRect rect=self.view.frame;
    rect.size.height=44;
    //    rect.origin.y=;
    //    rect.origin.x=0;
    rect.origin=CGPointZero;
    searchbar=[[UISearchBar alloc] init];
    searchbar.placeholder=@"请输入搜索关键字查询";
    searchbar.frame=rect;
    searchbar.delegate=self;
    [self.view addSubview:searchbar];
    searchbar.hidden=YES;
    
    if(self.listType == 1){
        self.navigationItem.title=[NSString stringWithFormat:@"选择%@",[VariableStore getCustomerManagerName]];
        fullArray=self.tableArray;
    }
    
    if(self.listType == 0){
        [self loadHadVisitedGroupList];
        self.navigationItem.title = @"选择集团";
        fullArray=self.tableArray;
    }
    
    if(self.listType == 33){
        //获取中小集团列表
         [self getmsGrpInfo];
        self.navigationItem.title = @"选择中小集团";
        fullArray=self.tableArray;
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
    for (Group *item in fullArray) {
        
//        NSString *phoneNumber=[item objectForKey:@"vip_mngr_msisdn"];
        NSString *groupName=item.groupName;
        
        NSRange range1=[groupName rangeOfString:searchText];
        if(range1.location!= NSNotFound)
            [tmpArray addObject:item];
        
//        NSRange range2=[phoneNumber rangeOfString:searchText];
//        if(range2.location!= NSNotFound)
//            [tmpArray addObject:item];
    }
    
    self.tableArray=tmpArray;
    [self.tableView reloadData];
}

//- (void)initSubView{
//    if(self.listType == 1)
//        self.navigationItem.title=[NSString stringWithFormat:@"选择%@",[VariableStore getCustomerManagerName]];
//
//    if(self.listType == 0)
//        self.navigationItem.title = @"选择集团";
//}

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
    
    static NSString *CellIdentifier = @"W_VisitPlanAddSelectGroupTableViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    
    UILabel *t_lblGroupName = (UILabel*)[cell viewWithTag:100];
    UIImageView *t_imgChoose = (UIImageView *)[cell viewWithTag:200];
    
    
//#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    if(self.listType == 1){
    CustomerManager *customerManager=[self.tableArray objectAtIndex:indexPath.row];
    t_lblGroupName.text=customerManager.vip_mngr_name;
//    BOOL f =customerManager.vip_mngr_msisdn != self.selectedCustomerManager.vip_mngr_msisdn;
    t_imgChoose.hidden=!(customerManager.vip_mngr_msisdn == self.selectedCustomerManager.vip_mngr_msisdn);
    }
//#endif
//#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    if(self.listType == 0){
    Group *group=[self.tableArray objectAtIndex:indexPath.row];
//    UILabel *t_lblGroupName = (UILabel*)[cell viewWithTag:100];
    t_lblGroupName.text=group.groupName;
    
    for (NSString *code in self.hadVisitedTableArray ) {
        
        if([code isEqualToString:group.groupId]){
            
//            t_lblGroupName.textColor = [UIColor blueColor];
            t_lblGroupName.textColor = [UIColor colorWithRed:100/255.f green:184/255.f blue:229/255.f alpha:1];
            break;
        }else{
            
            t_lblGroupName.textColor = [UIColor darkGrayColor];
        }
        
    }
    
    
//    UIImageView *t_imgChoose = (UIImageView *)[cell viewWithTag:200];
    t_imgChoose.hidden=![self.selectGroup.groupId isEqualToString: group.groupId];
    }
    if(self.listType == 33){
          t_lblGroupName.text=[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"grp_name"];
        t_imgChoose.hidden=![[self.selectDict objectForKey:@"grp_name"] isEqualToString:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"grp_name"]];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//#if (defined MANAGER_CS_VERSION) || (defined MANAGER_SY_VERSION)
    if(self.listType == 1){
        self.selectedCustomerManager=[self.tableArray objectAtIndex:indexPath.row];
         [self.delegate visitPlanAddSelectGroupTableViewControllerDidFinished:self];
    }
    
//#endif
//#if (defined STANDARD_CS_VERSION) || (defined STANDARD_SY_VERSION)
    if(self.listType == 0){
self.selectGroup=[self.tableArray objectAtIndex:indexPath.row];
         [self.delegate visitPlanAddSelectGroupTableViewControllerDidFinished:self];
    }
    if(self.listType == 33){
       self.selectDict =[self.tableArray objectAtIndex:indexPath.row];
        [self.delegate visitPlanAddSelectLittleGroupTableViewControllerDidFinished: self.selectDict];
    }
//#endif
    
    
//    self.selectGroup=[self.tableArray objectAtIndex:indexPath.row];
   
    [self.navigationController popViewControllerAnimated:YES];
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
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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

-(void)connectToNetwork{
    
    while (hubFlag) {
        sleep(1);
    }
}


-(void)loadHadVisitedGroupList{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据刷新中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];

    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    
    [NetworkHandling sendPackageWithUrl:@"visitplan/islinkgprlist" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        hubFlag=NO;
        if(!error){
            NSLog(@"sign in success");
            
            self.hadVisitedTableArray =[result objectForKey:@"islinkgrpcodes"];
            
            if (self.hadVisitedTableArray && self.hadVisitedTableArray.count > 0) {
                [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
//                [self.tableView reloadData];
            }else{
                ;
            }
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showErrorMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        
    }];
}
-(void)refreshTableView{
    [self.tableView reloadData];
}
#pragma mark -获取中小集团信息
-(void)getmsGrpInfo{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    
    [bDict setObject:self.user.userMobile forKey:@"vip_mngr_msisdn"];
    
    NSString *url=@"";
    url=@"msgrpuserlink/getmsGrpInfo";
    
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            self.tableArray =[result objectForKey:@"Response"];
            //使用fullArray作为备份数据用搜索后的恢复显示数据
           // fullArray=tableArray;
            [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSString *errorInfo=[result valueForKey:@"errorinf"];
            if(!errorInfo)
                errorInfo=@"提交数据出错了！";
            NSLog(@"error:%d info:%@",errorCode,errorInfo);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:errorInfo waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}

@end
