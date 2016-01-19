//
//  BusinessProcessSYViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-5-11.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "BusinessProcessSYViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"

#import "FlowBusinessProcessViewController.h"
#import "FlowBusinessSendBoxViewController.h"
#import "FlowBusinessRecordViewController.h"

@interface BusinessProcessSYViewController ()<MBProgressHUDDelegate>{
    
    NSDictionary *severDic;
    MBProgressHUD *HudShow;
    MBProgressHUD *HudWait;
    int selectSection;
    int selectIndex;

//    NSDictionary *selectDict;
}

@end

@implementation BusinessProcessSYViewController

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
    
    switch (self.busType) {
        case 0:
            self.title = @"4G套餐";
            break;
        case 1:
            self.title = @"4G终端";
            break;
        case 2:
            self.title = @"4G流量";
            break;
        default:
            break;
    }
    HudShow =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudShow];
    HudShow.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HudShow.mode = MBProgressHUDModeCustomView;
    HudShow.delegate = self;
    
    HudWait =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudWait];
    HudWait.mode = MBProgressHUDModeIndeterminate;
    HudWait.delegate=self;
    HudWait.labelText=nil;
    
    selectIndex = -1;
    selectSection = -1;
    
    self.tableViewSever.dataSource=self;
    self.tableViewSever.delegate=self;
    
    [self initPage];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"发件箱" style:UIBarButtonItemStylePlain target:self action:@selector(goSendBox)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
}
-(void)goSendBox{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    FlowBusinessProcessViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"FlowBusinessSendBoxViewController"];
    controller.user=self.user;
    controller.isShaoYang=YES;
    [self.navigationController pushViewController:controller animated:YES];
}


- (void) initPage{
    NSLog(@"load_sever_list");
    if(![NetworkHandling GetCurrentNet]){
        HudShow.mode = MBProgressHUDModeCustomView;
        HudShow.labelText = @"网络未连接,请检查您的网络";
        [HudShow show:YES];
        [HudShow hide:YES afterDelay:2];
        return;
    }
    
    NSString *tempUrl = nil;
    switch (self.busType) {
        case 0:
            tempUrl = @"dimjson739/4g_disc.json";
            break;
        case 1:
            tempUrl = @"dimjson739/phone_disc.json";
            break;
        case 2:
            tempUrl = @"dimjson739/gprs_list.json";
            break;
        default:
            break;
    }
    
    HudWait.mode = MBProgressHUDModeIndeterminate;
    [HudWait show:YES];
    [NetworkHandling getJsonWithUrl:tempUrl sendBody:nil processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            severDic = result;
            [self performSelectorOnMainThread:@selector(refeshTableView:) withObject:result waitUntilDone:NO];
            
        }
        else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"sever" waitUntilDone:YES];
        }
        
        
    }];
}

-(void)showMessage:(NSString*)infomation{
    
    [HudWait hide:YES];
    [self initPage];
}

-(void) refeshTableView:(NSDictionary*)dic{
    [HudWait hide:YES];
    [self.tableViewSever reloadData];
    if (self.busType == 0 || self.busType == 2) {
        UILabel *labelNote = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320,40)];
        labelNote.textColor=[UIColor redColor];
        labelNote.backgroundColor = [UIColor clearColor];
        labelNote.text = @" ";
        labelNote.font = [UIFont systemFontOfSize:12];
        labelNote.numberOfLines = 0;
        labelNote.text = [dic objectForKey:@"note"];
        labelNote.backgroundColor = [UIColor whiteColor];
        [self.viewTitle addSubview:labelNote];
    }
    else{
        UILabel *titleLabelMobleLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160,40)];
        titleLabelMobleLeft.textColor=[UIColor grayColor];
        titleLabelMobleLeft.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        titleLabelMobleLeft.text = @"机型";
        titleLabelMobleLeft.font = [UIFont systemFontOfSize:15];
        titleLabelMobleLeft.numberOfLines = 0;
        titleLabelMobleLeft.textAlignment = NSTextAlignmentCenter;
        [self.viewTitle addSubview:titleLabelMobleLeft];
        UILabel *titleLabelMobleRight = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 160,40)];
        titleLabelMobleRight.textColor=[UIColor grayColor];
        titleLabelMobleRight.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        titleLabelMobleRight.text = @"说明";
        titleLabelMobleRight.font = [UIFont systemFontOfSize:15];
        titleLabelMobleRight.numberOfLines = 0;
        titleLabelMobleRight.textAlignment = NSTextAlignmentCenter;
        [self.viewTitle addSubview:titleLabelMobleRight];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (self.busType == 1) {
        return 230;
    }
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.busType == 1) {
        return 0;
    }
    NSArray *arry1;
    if (self.busType == 0) {
        arry1 = [severDic objectForKey:@"disc"];
    }
    else{
        arry1 = [severDic objectForKey:@"grps"];
    }
    NSDictionary* tempdic1 = [arry1 objectAtIndex:section];
    if (![tempdic1 objectForKey:@"note"]) {
        return 40;
    }
//    NSLog(@"heightForHeaderInSection %d",section);
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回（向系统发送）分区个数,在这里有多少键就会有多少分区。
    if (self.busType == 1) {
        return 1;
    }
    else if(self.busType == 0){
        NSArray *arry1 = [severDic objectForKey:@"disc"];
        return  [arry1 count];
    }
    NSArray *arry1 = [severDic objectForKey:@"grps"];
    return  [arry1 count];
}

//所在分区所占的行数。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arry;
    if (self.busType == 0) {
        arry = [severDic objectForKey:@"disc"];
    }
    else if(self.busType == 2){
        arry = [severDic objectForKey:@"grps"];
    }
    else{
        arry = [severDic objectForKey:@"phone"];
        return  [arry count];
    }
    NSDictionary* tempdic = [arry objectAtIndex:section];
    NSArray *arry2 = [tempdic objectForKey:@"data"];
    return  [arry2 count];
}

//向屏幕显示。
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.busType == 1) {
        static NSString *CellIdentifier = @"MarketingCustomersWithSYViewControllerCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        NSArray *arry = [severDic objectForKey:@"phone"];
        NSDictionary* tempdic = [arry objectAtIndex:indexPath.row];
        UILabel *info = (UILabel*)[cell viewWithTag:300];
        info.text = [tempdic objectForKey:@"phone_remark"];
        
        UILabel *info2 = (UILabel*)[cell viewWithTag:400];
        info2.text = [tempdic objectForKey:@"phone_contract"];
        
        UILabel *name = (UILabel*)[cell viewWithTag:600];
        name.text = [tempdic objectForKey:@"phone_mold"];
        name.textAlignment = NSTextAlignmentCenter;
        UILabel *price = (UILabel*)[cell viewWithTag:700];
        price.text = [tempdic objectForKey:@"phone_price"];
        price.textAlignment = NSTextAlignmentCenter;
        UIImageView *imageMoble =  (UIImageView*)[cell viewWithTag:200];
        imageMoble.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",[NetworkHandling getBaseUrlString],[tempdic objectForKey:@"phone_img_url"]];
        if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
            NSURL *url = [NSURL URLWithString:imageUrl];
            dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
            dispatch_async(queue, ^{
                
                NSData *resultData = [NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:resultData];
                if(img){
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        imageMoble.image = img;
                    });
                }
            });
        }
        UIImageView *image =  (UIImageView*)[cell viewWithTag:500];
        if (indexPath.row == selectIndex && indexPath.section == selectSection){
            [image setImage:[UIImage imageNamed:@"勾选"]];
        }
        return cell;
    }
    
    static NSString *CellIdentifier = @"MarketingCustomersWithSYViewControllerCell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    NSArray *arry;
    if (self.busType == 0) {
        arry = [severDic objectForKey:@"disc"];
    }
    else if (self.busType == 2) {
        arry = [severDic objectForKey:@"grps"];
    }
    NSDictionary* tempdic = [arry objectAtIndex:indexPath.section];
    NSArray *arry2 = [tempdic objectForKey:@"data"];
    NSDictionary* tempdic2 = [arry2 objectAtIndex:indexPath.row];
    UILabel *info = (UILabel*)[cell viewWithTag:300];
    info.text = [tempdic2 objectForKey:@"info"];
    if (self.busType == 2) {
        NSString *rempstr = [NSString stringWithFormat:@"%@\n%@",[tempdic2 objectForKey:@"info"],[tempdic2 objectForKey:@"deal"]];
        info.text = rempstr;
    }
    UILabel *name = (UILabel*)[cell viewWithTag:400];
    name.text = [tempdic2 objectForKey:@"name"];
    
    UIImageView *image =  (UIImageView*)[cell viewWithTag:500];
    if (indexPath.row == selectIndex && indexPath.section == selectSection){
        [image setImage:[UIImage imageNamed:@"勾选"]];
    }
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    titleLabel.textColor=[UIColor colorWithRed:39/255.0 green:137/255.0 blue:195/255.0 alpha:1.0];
    titleLabel.backgroundColor = [UIColor colorWithRed:199/255.0 green:236/255.0 blue:254/255.0 alpha:1.0];
    NSArray *arry1;
    if (self.busType == 0) {
        arry1 = [severDic objectForKey:@"disc"];
    }
    else{
        arry1 = [severDic objectForKey:@"grps"];
    }
    NSDictionary* tempdic1 = [arry1 objectAtIndex:section];
    titleLabel.text = [tempdic1 objectForKey:@"type"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [myView addSubview:titleLabel];
    if ([tempdic1 objectForKey:@"note"]) {
        UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
        titleLabel2.textColor=[UIColor colorWithRed:39/255.0 green:137/255.0 blue:195/255.0 alpha:1.0];
        titleLabel2.backgroundColor = [UIColor whiteColor];
        titleLabel2.text = [tempdic1 objectForKey:@"note"];
        titleLabel2.font = [UIFont systemFontOfSize:12];
        titleLabel2.numberOfLines = 0;
        [myView addSubview:titleLabel2];
    }
    
    NSLog(@"note %@ section %d",[tempdic1 objectForKey:@"note"],section);
    return myView;
}


//把每个分区打上标记key
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"额艾尔飞a";
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectIndex = indexPath.row;
    selectSection = indexPath.section;
    NSInteger sections = tableView.numberOfSections;
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [tableView numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath1];
            UIImageView *image =  (UIImageView*)[cell viewWithTag:500];
            [image setImage:[UIImage imageNamed:@"未勾选"]];
        }
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *image =  (UIImageView*)[cell viewWithTag:500];
    [image setImage:[UIImage imageNamed:@"勾选"]];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
//    NSArray *arry;
//
//    if (self.busType == 0) {
//        arry = [severDic objectForKey:@"disc"];
//        NSDictionary* tempdic = [arry objectAtIndex:indexPath.section];
//        NSArray *arry2 = [tempdic objectForKey:@"data"];
//        NSDictionary *selectDict = [arry2 objectAtIndex:indexPath.row];
//    }
//    else if(self.busType == 2){
//        arry = [severDic objectForKey:@"grps"];
//        NSDictionary* tempdic = [arry objectAtIndex:indexPath.section];
//        NSArray *arry2 = [tempdic objectForKey:@"data"];
//        NSDictionary *selectDict = [arry2 objectAtIndex:indexPath.row];
//    }
//    else{
//        arry = [severDic objectForKey:@"phone"];
//        NSDictionary *selectDict = [arry objectAtIndex:indexPath.row];
//    }
    
    
}
/**
 *  @brief  受理记录
 *
 *  @param sender button
 */
- (IBAction)checkRecord:(id)sender {

    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    FlowBusinessRecordViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"FlowBusinessRecordViewController"];
    controller.user=self.user;
    controller.isShaoYang=YES;
    
    switch (self.busType) {
        case 0:
            controller.bussType=@"10";
            break;
        case 1:
            controller.bussType=@"11";
            break;
        case 2:
            controller.bussType=@"12";
            break;
        default:
            break;
    }
    controller.bussName=@"";
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
-(void)showTips:(NSString*)msg{
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
}
/**
 *  @brief  业务办理
 *
 *  @param sender button
 */
- (IBAction)preManage:(id)sender {
    
    if(selectIndex == -1 || selectSection == -1){
        [self showTips:@"你还没有选择办理业务！"];
        return;
    }
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
    FlowBusinessProcessViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"FlowBusinessProcessViewControllerId"];
    controller.user=self.user;
    controller.busType=self.busType;
    NSArray *arry;
    switch (self.busType) {
        case 0:
        {
            
            arry = [severDic objectForKey:@"disc"];
            NSDictionary* tempdic = [arry objectAtIndex:selectSection];
            NSArray *arry2 = [tempdic objectForKey:@"data"];
            NSDictionary *selectDict = [arry2 objectAtIndex:selectIndex];
            controller.flowName=[NSString stringWithFormat:@"%@(%@)",[tempdic objectForKey:@"type"],[selectDict objectForKey:@"name"]];
            
            controller.flowPrice=[selectDict objectForKey:@"info"];
            break;
        }
        case 1:{
            arry = [severDic objectForKey:@"phone"];
            NSDictionary *selectDict = [arry objectAtIndex:selectIndex];
            controller.flowPrice=[NSString stringWithFormat:@"%@ %@",[selectDict objectForKey:@"phone_mold"],[selectDict objectForKey:@"phone_price"]];
            
            controller.flowName=[selectDict objectForKey:@"phone_mold"];
            break;
        }
        case 2:{
            arry = [severDic objectForKey:@"grps"];
            NSDictionary* tempdic = [arry objectAtIndex:selectSection];
            NSArray *arry2 = [tempdic objectForKey:@"data"];
            NSDictionary *selectDict = [arry2 objectAtIndex:selectIndex];
            controller.flowName=[NSString stringWithFormat:@"%@(%@)",[tempdic objectForKey:@"type"],[selectDict objectForKey:@"name"]];
            
            controller.flowPrice=[selectDict objectForKey:@"info"];
            break;
        }
        default:
            break;
    }
    controller.isShaoYang=YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
