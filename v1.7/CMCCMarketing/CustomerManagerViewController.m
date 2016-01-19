//
//  CustomerManagerViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-22.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "CustomerManagerTableViewCell.h"
#import "CustomerManagerViewController.h"
#import "CustomerManagerBodyViewController.h"
#import "Group.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "CustomerManagerMessageTableViewController.h"
#import "CustomerManagerMessageWithManageTableViewController.h"
#import "BuildingDetailViewController.h"
#import "AddSigleLittleGrounpViewController.h"
@interface CustomerManagerViewController ()<MBProgressHUDDelegate>{
//    NSString *selectedTitle;
    
    BOOL hubFlag;
    NSString *marketname;
    Group *selectGroup;
    Channels *selectChannels;
    NSDictionary *selectBuilding;
    NSDictionary *selectLittleGrounp;
    NSMutableArray *tableArray;
    NSMutableArray *fullArray;
}

@end

@implementation CustomerManagerViewController

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
    //listTyp为判别为集团信息还是渠道信息,中小集团客户,楼宇信息
    switch (self.listType) {
        case 0:
            self.title=@"集团客户";
            break;
        case 1:
            self.title=@"渠道信息";
            break;
        case 2:
            self.title=@"中小集团客户";
            break;
        case 3:
            self.title=@"楼宇信息";
            break;

        default:
            break;
    }

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

    
    customerTableView.delegate=self;
    customerTableView.dataSource=self;
    
    remindButton.hidden=YES;
    marketname=@"";

    searchbar.delegate=self;
  
    
    
#ifdef MANAGER_CS_VERSION
    if (self.listType == 0){
    fullArray=[[NSMutableArray alloc] init];
    for (CustomerManager *customer in self.user.customerManagerInfo)
        for (Group *g in customer.groupList)
            [fullArray addObject:g];
        tableArray = fullArray;
    }
   else if(self.listType == 2){
        [self getmsGrpInfo];
    }
    else if (self.listType == 3) {
        [self getBuildingInfo];
    }

#endif
    
    
#ifdef STANDARD_CS_VERSION
    if(self.listType == 2){
        UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"加号"] style:UIBarButtonItemStylePlain target:self action:@selector(goAddSingleLittleGrounp)];
        [rightButton setTintColor:[UIColor whiteColor]];
        [self.navigationItem setRightBarButtonItem:rightButton];
        [self getmsGrpInfo];
    }
   else if (self.listType == 3) {
        [self getBuildingInfo];
    }
    else if (self.listType == 0){
       fullArray=[[NSMutableArray alloc] initWithArray:self.user.groupInfo];
        tableArray = fullArray;
   }
    

#endif
    
    
#ifdef MANAGER_SY_VERSION
    if(self.listType == 0){
        fullArray=[[NSMutableArray alloc] init];
    for (CustomerManager *customer in self.user.customerManagerInfo)
        for (Group *g in customer.groupList)
            [fullArray addObject:g];
        tableArray = fullArray;

    }
    else if(self.listType == 1){
        fullArray=[[NSMutableArray alloc] init];
        for (ChannelsManager *customer in self.user.channelManagerInfo)
            for (Channels *g in customer.channelList)
                [fullArray addObject:g];
        tableArray = fullArray;
    }
    
#endif
#ifdef STANDARD_SY_VERSION
    if(self.listType == 0)
        fullArray=[[NSMutableArray alloc] initWithArray:self.user.groupInfo];
    if(self.listType == 1)
        fullArray=[[NSMutableArray alloc] initWithArray:self.user.chnlInfo];
    tableArray = fullArray;

#endif
    
    
   }

-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    hubFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
   // [self loadRemindData];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}
-(void)goBack{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goMessageCenter{
    [self performSegueWithIdentifier:@"CustomerManagerMessageId" sender:self];
}

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
             tableArray =[result objectForKey:@"Response"];
            //使用fullArray作为备份数据用搜索后的恢复显示数据
            fullArray=tableArray;
            [self performSelectorOnMainThread:@selector(refreshTableview) withObject:nil waitUntilDone:YES];
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
-(void)refreshTableview
{
   
    [customerTableView reloadData];

}
-(void)getBuildingInfo{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据提交中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userLvl] forKey:@"user_lvl"];
    marketname=searchbar.text;
    [bDict setObject:marketname forKey:@"market_name"];
    
    NSString *url=@"";
    url=@"msgrpuserlink/getBuildingInfo";
    
    [NetworkHandling sendPackageWithUrl:url sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray =[result objectForKey:@"Response"];
            //使用fullArray作为备份数据用搜索后的恢复显示数据
            fullArray=tableArray;
            [self performSelectorOnMainThread:@selector(refreshTableview) withObject:nil waitUntilDone:YES];
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
-(void)remindLoadFinished{
//    remindButton.hidden=YES;
//    remindTableArray=nil;
//    [self goMessageCenter];
}
- (IBAction)remingButtonOnclick:(id)sender {
#if (defined MANAGER_CS_VERSION) //|| (defined MANAGER_SY_VERSION)
    [self performSegueWithIdentifier:@"CustomerManagerMessageCenter" sender:self];
#endif
    
    

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
    CustomerManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerManagerTableViewCell" forIndexPath:indexPath];
    if(self.listType == 0){
        Group *group=[tableArray objectAtIndex:indexPath.row];
        cell.itemName.text=group.groupName;
    }
    if(self.listType == 1){
        Channels *channel=[tableArray objectAtIndex:indexPath.row];
        cell.itemName.text=channel.chnl_name;
    }
    if(self.listType == 2){
        cell.itemName.text=[[tableArray objectAtIndex:indexPath.row] objectForKey:@"grp_name"];
    }
    if(self.listType == 3){
        cell.itemName.text=[[tableArray objectAtIndex:indexPath.row] objectForKey:@"market_name"];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.listType == 0)
    {
        selectGroup=[tableArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"CustomerManagerSegue" sender:self];
    }
    if(self.listType == 1){
        selectChannels=[tableArray objectAtIndex:indexPath.row];
         [self performSegueWithIdentifier:@"CustomerManagerSegue" sender:self];
    }
    if(self.listType == 2){
        selectLittleGrounp=[tableArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"CustomerManagerSegue" sender:self];
    }

    if(self.listType == 3){
        selectBuilding =[tableArray objectAtIndex:indexPath.row] ;

        [self performSegueWithIdentifier:@"BuildingDetailSegue" sender:self];
    }

}
//点击删除时调用
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
    if (self.listType==2) {
        [self DelectLittleGrounpContact:dict];
        
    }
}
//选编辑的模式（删除，增加）
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
   // NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];
//    int row_id = [[dict objectForKey:@"row_id"] intValue];
//    if(row_id == -999)
//        return UITableViewCellEditingStyleNone;
     if (self.listType==2) {
    return UITableViewCellEditingStyleDelete;
     }
     else{
          return UITableViewCellEditingStyleNone;
     }
}

-(void)DelectLittleGrounpContact:(NSDictionary*)dict{
    /**
     //删除中小集团信息
     //接口：changsha\v1_7\msgrpuserlink\delmsGrpInfo
     //必传参数
     //grp_code
     //返回参数
     //flag true/false

     */
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在提交数据，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[dict objectForKey:@"grp_code"] forKey:@"grp_code"];
    //    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    //    [bDict setValue:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    //
    [NetworkHandling sendPackageWithUrl:@"msgrpuserlink/delmsGrpInfo" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            BOOL flag=[[result objectForKey:@"flag"] boolValue];
            if(flag){
                [self performSelectorOnMainThread:@selector(submitSuccess:) withObject:dict waitUntilDone:YES];
            }
            else{
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"删除中小集团失败！" waitUntilDone:YES];
            }
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
-(void)submitSuccess:(NSDictionary*)dict{
    [tableArray removeObject:dict];
    [customerTableView reloadData];
}

-(void)goAddSingleLittleGrounp{
    [self performSegueWithIdentifier:@"addSigleLittleGrounpsegue" sender:self];
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CustomerManagerSegue"]){
        CustomerManagerBodyViewController *controller=segue.destinationViewController;
        if(self.listType == 0)
        {
            controller.group = selectGroup;
        }
        if(self.listType == 1)
        {
            controller.channels=selectChannels;

        }
        if(self.listType == 2)
        {              //中小集团
        controller.reDict=selectLittleGrounp;
        }
        controller.user=self.user;
        controller.listType=self.listType;
    }
    if([segue.identifier isEqualToString:@"BuildingDetailSegue"]){
        BuildingDetailViewController *controller=segue.destinationViewController;
        controller.user=self.user;
        controller.recipeDict=selectBuilding;
    }
    if([segue.identifier isEqualToString:@"addSigleLittleGrounpsegue"]){
        AddSigleLittleGrounpViewController *controller=segue.destinationViewController;
        controller.user=self.user;
         controller.whereFrom=9;
        //controller.Dict=[tableArray objectAtIndex:0] ;
    }

    if([segue.identifier isEqualToString:@"CustomerManagerMessageId"]){
        CustomerManagerMessageTableViewController *controller=segue.destinationViewController;
        controller.user=self.user;
    }
}


- (IBAction)goSearchOnclick:(id)sender {
    searchbar.hidden=NO;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchbar resignFirstResponder];
    searchbar.hidden=YES;
    [self searchBar:searchBar textDidChange:searchBar.text];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        tableArray=fullArray;
        [customerTableView reloadData];
        return;
    }
    
    NSMutableArray *tmpArray=[[NSMutableArray alloc] init];
    
    if(self.listType == 0){
        for (Group *group in fullArray) {
            NSString *groupName= group.groupName;
            NSRange range=[groupName rangeOfString:searchText];
            if(range.location!= NSNotFound)
                [tmpArray addObject:group];
        }
    }
    if(self.listType == 1){
        for (Channels *channel in fullArray) {
            NSString *channelName= channel.chnl_name;
            NSRange range=[channelName rangeOfString:searchText];
            if(range.location!= NSNotFound)
                [tmpArray addObject:channel];
        }
    }
    if(self.listType == 2){
        for (NSDictionary *dict in tableArray) {
            NSString *littleGrounp= [dict objectForKey:@"grp_name"];
            NSRange range=[littleGrounp rangeOfString:searchText];
            if(range.location!= NSNotFound)
                [tmpArray addObject:dict];
        }
        
    }
    if(self.listType == 3){
        for (NSDictionary *dict in tableArray) {
            NSString *building= [dict objectForKey:@"market_name"];
            NSRange range=[building rangeOfString:searchText];
            if(range.location!= NSNotFound)
                [tmpArray addObject:dict];
        }

    }

    
    tableArray=tmpArray;
    [customerTableView reloadData];
}
@end
