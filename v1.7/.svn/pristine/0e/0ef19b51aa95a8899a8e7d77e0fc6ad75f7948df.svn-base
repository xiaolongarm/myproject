//
//  MarketingCustomersWithSYViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 15-5-5.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "MarketingCustomersWithSYViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "MarketingCustomerDetailsTableViewController.h"

@interface MarketingCustomersWithSYViewController ()<MBProgressHUDDelegate>{
    
    NSDictionary *severDic;
    NSDictionary *mobleDic;
    NSDictionary *flowDic;
    
    UILabel *titleLabelLeft;
    UILabel *titleLabelRight;
    UILabel *titleLabelMobleLeft;
    UILabel *titleLabelMobleRight;
    UILabel *labelNote;
    int selectSection;
    int selectIndex;
    int modFlag;
    NSString *severLeft;
    NSString *severRight;
    NSString *mobleLeft;
    NSString *mobleRight;
    NSString *flowLeft;
    NSString *flowRight;
    
    BOOL isGetSeverData;
    BOOL isGetMobleData;
    BOOL isGetFlowData;
    BOOL validateFlag;
    
    MBProgressHUD *HudShow;
    MBProgressHUD *HudWait;
}

@end

@implementation MarketingCustomersWithSYViewController

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
    NSLog(@"isGroup %d",self.isGroup);
    if (!self.isGroup) {
        severLeft = [NSString stringWithFormat:@"手机号码:%@\n是否4G套餐:%@\n当前品牌:%@",self.customer.customerSvcCode,self.customer.customerDiscnt4G,self.customer.customerBrndName];
        titleLabelLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160,70)];
        titleLabelLeft.textColor=[UIColor grayColor];
        titleLabelLeft.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        titleLabelLeft.text = severLeft;
        titleLabelLeft.font = [UIFont systemFontOfSize:12];
        titleLabelLeft.numberOfLines = 0;
        [self.viewTit addSubview:titleLabelLeft];
        
        severRight = [NSString stringWithFormat:@"是否4G卡:%@-\n上月消费:%@\n\n",self.customer.customerIf_4gCard,@"-"];
        titleLabelRight = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 160,70)];
        titleLabelRight.textColor=[UIColor grayColor];
        titleLabelRight.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        titleLabelRight.text = severRight;
        titleLabelRight.font = [UIFont systemFontOfSize:12];
        titleLabelRight.numberOfLines = 0;
        [self.viewTit addSubview:titleLabelRight];
        
        labelNote = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 320,40)];
        labelNote.textColor=[UIColor redColor];
        labelNote.backgroundColor = [UIColor clearColor];
        labelNote.text = @" ";
        labelNote.font = [UIFont systemFontOfSize:12];
        labelNote.numberOfLines = 0;
        [self.viewTit addSubview:labelNote];
        self.viewTit.frame = CGRectMake(self.viewTit.frame.origin.x,  self.viewTit.frame.origin.y,self.viewTit.frame.size.width, 120);
        mobleLeft = [NSString stringWithFormat:@"手机号码:%@\n终端品牌:%@\n终端制式:%@\n活动名称:%@\n包名称:%@",self.customer.customerSvcCode,self.customer.customerTermBrnd,self.customer.customerTermSys,self.customer.customerProdName,self.customer.customerPackageName];
        
         // 邵阳端新增字段 	@"trem_baodi_fee"  	@"trem_start_date" 	@"trem_end_date"
        mobleRight = [NSString stringWithFormat:@"更换终端月份:%@\n智能机终端:%@\n保底费用:%@\n开始时间:%@\n截止日期:%@\n",self.customer.customerChang_term_date,self.customer.customerIsZnSj,[self.dicTerm objectForKey:@"trem_baodi_fee"],[self.dicTerm objectForKey:@"trem_start_date"],[self.dicTerm objectForKey:@"trem_end_date"]];
       
        
        flowLeft = [NSString stringWithFormat:@"手机号码:%@\n是否4G流量:%@\n套餐超出流量:%@M\n订购加油包:%@",self.customer.customerSvcCode,@"-",self.customer.customerFlwDiscPassTolVol,@"-"];
        flowRight = [NSString stringWithFormat:@"是否2G高流量:%@\n是否4G卡:%@\n赠送流量:%@M\n",self.customer.customerIf_2g_high_flow,self.customer.customerIf_4gCard,self.customer.customerFreeVol];
    }
    else{
        titleLabelMobleLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160,50)];
        titleLabelMobleLeft.textColor=[UIColor grayColor];
        titleLabelMobleLeft.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        titleLabelMobleLeft.text = @"机型";
        titleLabelMobleLeft.font = [UIFont systemFontOfSize:15];
        titleLabelMobleLeft.numberOfLines = 0;
        titleLabelMobleLeft.textAlignment = NSTextAlignmentCenter;
        [self.viewTit addSubview:titleLabelMobleLeft];
        titleLabelMobleLeft.hidden = YES;
        titleLabelMobleRight = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 160,50)];
        titleLabelMobleRight.textColor=[UIColor grayColor];
        titleLabelMobleRight.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        titleLabelMobleRight.text = @"说明";
        titleLabelMobleRight.font = [UIFont systemFontOfSize:15];
        titleLabelMobleRight.numberOfLines = 0;
        titleLabelMobleRight.textAlignment = NSTextAlignmentCenter;
        [self.viewTit addSubview:titleLabelMobleRight];
        titleLabelMobleRight.hidden = YES;
        labelNote = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320,50)];
        labelNote.textColor=[UIColor redColor];
        labelNote.backgroundColor = [UIColor clearColor];
        labelNote.text = @" ";
        labelNote.font = [UIFont systemFontOfSize:12];
        labelNote.numberOfLines = 0;
        [self.viewTit addSubview:labelNote];
        self.viewTit.frame = CGRectMake(self.viewTit.frame.origin.x,  self.viewTit.frame.origin.y,self.viewTit.frame.size.width, 50);
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
    
    modFlag = 1;
    selectIndex = -1;
    selectSection = -1;
    isGetFlowData = NO;
    isGetMobleData = NO;
    isGetSeverData = NO;
    [self.btnSever setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [self.btnMoble setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [self.btnFlow setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [self load_sever_list];
    
    self.navigationItem.title = @"精准营销";
    [self.navigationController setNavigationBarHidden:NO];
    
    self.tableView4g.dataSource=self;
    self.tableView4g.delegate=self;
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"详细信息"] style:UIBarButtonItemStylePlain target:self action:@selector(goUserDetails)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
}
-(void)goUserDetails{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Marketing" bundle:nil];
    MarketingCustomerDetailsTableViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"MarketingCustomerDetailsTableViewControllerId"];
    controller.customer=self.customer;
    [self.navigationController pushViewController:controller animated:YES];

}

-(void)showMessage:(NSString*)infomation{
    
    [HudWait hide:YES];
    if ([infomation isEqualToString:@"sever"]) {
        NSLog(@"again1");
        [self load_sever_list];
    }
    else if([infomation isEqualToString:@"moble"]){
        NSLog(@"again2");
        [self load_moble_list];
    }
    else if([infomation isEqualToString:@"flow"]){
        NSLog(@"again3");
        [self load_flow_list];
    }
}

-(void)load_sever_list{
    
    if (isGetSeverData) {
        [self performSelectorOnMainThread:@selector(refeshTableView:) withObject:severDic waitUntilDone:NO];
    }
    else{
        NSLog(@"load_sever_list");
        if(![NetworkHandling GetCurrentNet]){
            HudShow.mode = MBProgressHUDModeCustomView;
            HudShow.labelText = @"网络未连接,请检查您的网络";
            [HudShow show:YES];
            [HudShow hide:YES afterDelay:2];
            return;
        }
        HudWait.mode = MBProgressHUDModeIndeterminate;
        [HudWait show:YES];
        [NetworkHandling getJsonWithUrl:@"dimjson739/4g_disc.json" sendBody:nil processHandler:^(NSDictionary *result, NSError *error) {
            
            if(!error){
                isGetSeverData = YES;
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
    
}

-(void)load_moble_list{
    if (isGetMobleData) {
        [self performSelectorOnMainThread:@selector(refeshTableView:) withObject:mobleDic waitUntilDone:NO];
    }
    else{
        if(![NetworkHandling GetCurrentNet]){
            HudShow.mode = MBProgressHUDModeCustomView;
            HudShow.labelText = @"网络未连接,请检查您的网络";
            [HudShow show:YES];
            [HudShow hide:YES afterDelay:2];
            return;
        }
        HudWait.mode = MBProgressHUDModeIndeterminate;
        [HudWait show:YES];
        [NetworkHandling getJsonWithUrl:@"dimjson739/phone_disc.json" sendBody:nil processHandler:^(NSDictionary *result, NSError *error) {
            
            if(!error){
                isGetMobleData = YES;
                mobleDic = result;
                [self performSelectorOnMainThread:@selector(refeshTableView:) withObject:result waitUntilDone:NO];
                
            }
            else{
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"moble" waitUntilDone:YES];
            }
            
            
        }];
    }
    
}

-(void)load_flow_list{
    if (isGetFlowData) {
        [self performSelectorOnMainThread:@selector(refeshTableView:) withObject:flowDic waitUntilDone:NO];
    }
    else{
        if(![NetworkHandling GetCurrentNet]){
            HudShow.mode = MBProgressHUDModeCustomView;
            HudShow.labelText = @"网络未连接,请检查您的网络";
            [HudShow show:YES];
            [HudShow hide:YES afterDelay:2];
            return;
        }
        HudWait.mode = MBProgressHUDModeIndeterminate;
        [HudWait show:YES];
        [NetworkHandling getJsonWithUrl:@"dimjson739/gprs_list.json" sendBody:nil processHandler:^(NSDictionary *result, NSError *error) {
            
            if(!error){
                isGetFlowData = YES;
                flowDic = result;
                [self performSelectorOnMainThread:@selector(refeshTableView:) withObject:result waitUntilDone:NO];
                
            }
            else{
                [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"flow" waitUntilDone:YES];
            }
            
            
        }];
    }
    
}


-(void) refeshTableView:(NSDictionary*)dic{
    [HudWait hide:YES];
    [self.tableView4g reloadData];
    if (modFlag == 1 || modFlag == 3) {
        labelNote.hidden = NO;
    }
    labelNote.text = [dic objectForKey:@"note"];
    labelNote.backgroundColor = [UIColor whiteColor];
}

- (IBAction)btnSeverOnClick:(id)sender {
    if (modFlag == 1) {
        return;
    }
    titleLabelMobleLeft.hidden = YES;
    titleLabelMobleRight.hidden = YES;
    modFlag = 1;
    selectIndex = -1;
    selectSection = -1;
    if (!self.isGroup){
        titleLabelLeft.text = severLeft;
        titleLabelLeft.frame = CGRectMake(titleLabelLeft.frame.origin.x,  titleLabelLeft.frame.origin.y,titleLabelLeft.frame.size.width, 70);
        titleLabelRight.text = severRight;
        titleLabelRight.frame = CGRectMake(titleLabelRight.frame.origin.x,  titleLabelRight.frame.origin.y,titleLabelRight.frame.size.width, 70);
//        labelNote.hidden = YES;
    }
    
//    self.viewTit.frame = CGRectMake(self.viewTit.frame.origin.x,  self.viewTit.frame.origin.y,self.viewTit.frame.size.width, 110);
    [self.btnSever setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [self.btnMoble setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [self.btnFlow setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [self load_sever_list];
}

- (IBAction)btnMobleOnClick:(id)sender {
    if (modFlag == 2) {
        return;
    }
    modFlag = 2;
    selectIndex = -1;
    selectSection = -1;
    if (!self.isGroup){
        titleLabelLeft.text = mobleLeft;
        titleLabelLeft.frame = CGRectMake(titleLabelLeft.frame.origin.x,  titleLabelLeft.frame.origin.y,titleLabelLeft.frame.size.width, 118);
        titleLabelRight.text = mobleRight;
        titleLabelRight.frame = CGRectMake(titleLabelRight.frame.origin.x,  titleLabelRight.frame.origin.y,titleLabelRight.frame.size.width, 118);
    }
    else{
        titleLabelMobleLeft.hidden = NO;
        titleLabelMobleRight.hidden = NO;
    }
    labelNote.hidden = YES;
    [self.btnMoble setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [self.btnSever setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [self.btnFlow setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [self load_moble_list];
}


- (IBAction)btnFlowOnClick:(id)sender {
    if (modFlag == 3) {
        return;
    }
    titleLabelMobleLeft.hidden = YES;
    titleLabelMobleRight.hidden = YES;
    modFlag = 3;
    selectIndex = -1;
    selectSection = -1;
    if (!self.isGroup){
        titleLabelLeft.text = flowLeft;
        titleLabelLeft.frame = CGRectMake(titleLabelLeft.frame.origin.x,  titleLabelLeft.frame.origin.y,titleLabelLeft.frame.size.width, 70);
        titleLabelRight.text = flowRight;
        titleLabelRight.frame = CGRectMake(titleLabelRight.frame.origin.x,  titleLabelRight.frame.origin.y,titleLabelRight.frame.size.width, 70);
    }
    [self.btnFlow setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [self.btnMoble setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [self.btnSever setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [self load_flow_list];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (modFlag == 2) {
        return 230;
    }
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (modFlag == 2 && !self.group) {
        return 40;
    }
    if (modFlag == 2 && self.group) {
        return 0;
    }
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回（向系统发送）分区个数,在这里有多少键就会有多少分区。
    if (modFlag == 2) {
        return 1;
    }
    else if(modFlag == 1){
        NSArray *arry1 = [severDic objectForKey:@"disc"];
        return  [arry1 count];
    }
    NSArray *arry1 = [flowDic objectForKey:@"grps"];
    return  [arry1 count];
}

//所在分区所占的行数。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    NSArray *arry;
    if (modFlag == 1) {
        arry = [severDic objectForKey:@"disc"];
    }
    else if(modFlag == 3){
        arry = [flowDic objectForKey:@"grps"];
    }
    else{
        arry = [mobleDic objectForKey:@"phone"];
        return  [arry count];
    }
    NSDictionary* tempdic = [arry objectAtIndex:section];
    NSArray *arry2 = [tempdic objectForKey:@"data"];
    return  [arry2 count];
}

//向屏幕显示。
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (modFlag == 2) {
        static NSString *CellIdentifier = @"MarketingCustomersWithSYViewControllerCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        NSArray *arry = [mobleDic objectForKey:@"phone"];
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
    if (modFlag == 1) {
        arry = [severDic objectForKey:@"disc"];
    }
    else if (modFlag == 3) {
        arry = [flowDic objectForKey:@"grps"];
    }
    NSDictionary* tempdic = [arry objectAtIndex:indexPath.section];
    NSArray *arry2 = [tempdic objectForKey:@"data"];
    NSDictionary* tempdic2 = [arry2 objectAtIndex:indexPath.row];
    UILabel *info = (UILabel*)[cell viewWithTag:300];
    info.text = [tempdic2 objectForKey:@"info"];
    if (modFlag == 3) {
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
    if (modFlag == 2) {
        UIView* myView = [[UIView alloc] init];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 160, 40)];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.text = @"机型";
        titleLabel.font = [UIFont systemFontOfSize:15];
        [myView addSubview:titleLabel];
        
        UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 160, 40)];
        titleLabel2.textColor=[UIColor grayColor];
        titleLabel2.text = @"说明";
        titleLabel2.font = [UIFont systemFontOfSize:15];
        [myView addSubview:titleLabel2];
        return myView;
    }
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -10, 320, 40)];
    titleLabel.textColor=[UIColor colorWithRed:39/255.0 green:137/255.0 blue:195/255.0 alpha:1.0];
    titleLabel.backgroundColor = [UIColor colorWithRed:199/255.0 green:236/255.0 blue:254/255.0 alpha:1.0];
    NSArray *arry1;
    if (modFlag == 1) {
        arry1 = [severDic objectForKey:@"disc"];
    }
    else{
        arry1 = [flowDic objectForKey:@"grps"];
    }
    NSDictionary* tempdic1 = [arry1 objectAtIndex:section];
    titleLabel.text = [tempdic1 objectForKey:@"type"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [myView addSubview:titleLabel];
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 50)];
    titleLabel2.textColor=[UIColor colorWithRed:39/255.0 green:137/255.0 blue:195/255.0 alpha:1.0];
    titleLabel2.backgroundColor = [UIColor whiteColor];
    titleLabel2.text = [tempdic1 objectForKey:@"note"];
    titleLabel2.font = [UIFont systemFontOfSize:12];
    titleLabel2.numberOfLines = 0;
    [myView addSubview:titleLabel2];
    
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
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    UIAlertView *myAlertView;
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
            NSLog(@"Result: SMS sent");
            break;
        case MessageComposeResultFailed:
            myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"短信发送失败!" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"关闭", nil];
            [myAlertView show];
            break;
        default:
            NSLog(@"Result: SMS not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendSMS:(id)sender {
    NSLog(@"sendSMS");
    if(selectIndex == selectSection && selectSection == -1){
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您还没有选择发送信息！" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
        [myAlertView show];
        return;
    }
    
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            
            [self displaySMSComposerSheet];
        }
        else {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备没有短信功能" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
            [myAlertView show];
            
        }
    }
    else {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"iOS版本过低,iOS4.0以上才支持程序内发送短信" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
        [myAlertView show];
    }
}

-(void)displaySMSComposerSheet{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    
    NSMutableArray *contactArray=[[NSMutableArray alloc] init];
    if(self.isGroup){
        for (NSDictionary *dict in self.groupUserList) {
            BOOL selected=[[dict objectForKey:@"selected"] boolValue];
            if(selected)
                [contactArray addObject:[dict objectForKey:@"svc_code"]];
        }
    }
    else{
        [contactArray addObject:self.customer.customerSvcCode];
    }
    
    [picker setEditing:YES];
    
    NSString *msg=@"";
    NSArray *arry;
    if (modFlag == 1) {
        arry = [severDic objectForKey:@"disc"];
        NSDictionary* tempdic = [arry objectAtIndex:selectSection];
        NSArray *arry2 = [tempdic objectForKey:@"data"];
        NSDictionary* tempdic2 = [arry2 objectAtIndex:selectIndex];
        msg = [NSString stringWithFormat:@"尊敬的邵阳移动集团客户:向您推荐【%@】%@,详询集团营销经理%@(%@)",[tempdic2 objectForKey:@"name"],[tempdic2 objectForKey:@"info"],self.user.userName,self.user.userMobile];
    }
    if (modFlag == 2) {
        arry = [mobleDic objectForKey:@"phone"];
        NSDictionary* tempdic2 = [arry objectAtIndex:selectIndex];
        msg = [NSString stringWithFormat:@"尊敬的邵阳移动集团客户:向您推荐【%@】%@,合约价%@,详询集团营销经理%@(%@)",[tempdic2 objectForKey:@"phone_mold"],[tempdic2 objectForKey:@"phone_contract"],[tempdic2 objectForKey:@"phone_price"],self.user.userName,self.user.userMobile];
    }
    else if (modFlag == 3) {
        arry = [flowDic objectForKey:@"grps"];
        NSDictionary* tempdic = [arry objectAtIndex:selectSection];
        NSArray *arry2 = [tempdic objectForKey:@"data"];
        NSDictionary* tempdic2 = [arry2 objectAtIndex:selectIndex];
        msg = [NSString stringWithFormat:@"尊敬的邵阳移动集团客户:向您推荐【%@】%@,%@,详询集团营销经理%@(%@)",[tempdic2 objectForKey:@"name"],[tempdic2 objectForKey:@"info"],[tempdic2 objectForKey:@"deal"],self.user.userName,self.user.userMobile];
    }

    picker.recipients=contactArray;
    picker.body = msg;
    HudWait.mode = MBProgressHUDModeIndeterminate;
    [HudWait show:YES];
    validateFlag =NO ;
    [self presentViewController:picker animated:YES completion:^{
        [HudWait hide:YES];
    }];
    
}

@end
