//
//  MarketingCustomersViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-3.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "MarketingCustomerDetailsTableViewController.h"
#import "IndividualCustomerPackageTableViewCell.h"
#import "MarketingCustomersViewController.h"
//#import "SendMessageViewController.h"
#import "BusinessHandling.h"
#import "PreferentialPurchaseViewController.h"
#import "FlowBusinessProcessViewController.h"
#import "IndividualCustomerPackageTerminalTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NetworkHandling.h"

#define RECOMMENDED_PACKAGE_TABLEVIEW 30    //一般表

#define MORE_cunfeisongfei_TABLEVIEW 31   //存费送费表

#define MORE_cunfeisongli_TABLEVIEW 32   //存费送礼表

#define BUSINESS_FLOW 1   //流量业务按钮
#define BUSINESS_TERMINAL 2   //终端业务按钮
#define BUSINESS_cunfeisongli 3   //存费业务按钮

//#define RECOMMEND_SECTION 0
//#define MORE_SECTION 1

@interface MarketingCustomersViewController (){
    
    NSArray *recommendArray; //一般表数据源
    
    NSArray *moreArray; //存费送费数据源
    NSArray *cunfeisongliArray;//存费送礼数据源
    
    BOOL isLoadFlowData;
    BOOL isLoadTerminalData;
    NSArray *flowArray;
    NSArray *terminalArray;
    
    BOOL isLoadFeeData;
    
    int listSwitch;
    IndividualCustomerPackageTableViewCell *selectedCell;
    BOOL validateFlag;
    NSMutableDictionary *selectItem;
    
    
    int busType;
    
    BOOL hudFlag;
}

@end

@implementation MarketingCustomersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark 此类单独适用于长沙的精准营销,无须判断长沙还是邵阳
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
  //设置分段控制器默认索引为0
    self.markSegmentControl.selectedSegmentIndex=0;
    [ self.markSegmentControl addTarget: self
                          action: @selector(controlPressed:)
                forControlEvents: UIControlEventValueChanged
     ];
    recommendedPackageTableView.delegate=self;
    recommendedPackageTableView.dataSource=self;
    
    morePackagesTableView.delegate=self;
    morePackagesTableView.dataSource=self;
    
    cunfeisongliTableView.delegate=self;
    cunfeisongliTableView.dataSource=self;

    
    busType=BUSINESS_FLOW;
    [self load_gprs_list];
    
    morePackagesTableView.hidden=YES;
    cunfeisongliTableView.hidden=YES;
    vwCFSLTips.hidden=YES;
    vwCFSFTips.hidden=YES;
    
    if(IS_IPHONE4)
        recommendTableConstraintsHeight.constant=80;
    if(self.isGroup){
        topViewConstraintsHeight.constant=0;
        btUserDetail.hidden=YES;
    }
    
    [self initSubView];
    
}

-(void)initSubView{
    
    if (self.isGroup) {
        
        lbCustomerTelephone.text = [NSString stringWithFormat:@"名字:%@",self.group.groupName];
        lbCustomerTelephone.adjustsFontSizeToFitWidth=YES;
        lbCustomerName.text = [NSString stringWithFormat:@"地址:%@",self.group.groupAddress];
        lbCustomerName.adjustsFontSizeToFitWidth=YES;
        lbDgxsb.text = @"";
        
        lb2ggllkh.text = [NSString stringWithFormat:@"手机:%@",self.group.groupContactPhone];
    
        
        lbZsll.text = [NSString stringWithFormat:@"联系人:%@",self.group.groupContactname];
        
        lbDgllb.text = @"";
        
        return;
    }
    
//    if (busType == BUSINESS_FLOW) {
    if(self.markSegmentControl.selectedSegmentIndex==0){
        NSString *customerSvcCode = self.customer.customerSvcCode;
        lbCustomerTelephone.text=[NSString stringWithFormat:@"手机号码:%@",customerSvcCode];
        
        NSString *flw_disc_pass_tol_vol = self.customer.customerFlwDiscPassTolVol;
        if(flw_disc_pass_tol_vol == nil){
            flw_disc_pass_tol_vol = @"0";
        }
        lbCustomerName.text = [NSString stringWithFormat:@"超出标准流量套餐:%@ M",flw_disc_pass_tol_vol ];
        
        NSString *customerIfIdlePak = self.customer.customerIfIdlePak;
        if ([customerIfIdlePak isEqualToString:@"0"]) {
            customerIfIdlePak = @"否";
        } else {
            customerIfIdlePak = @"是";
        }
        lbDgxsb.text = [NSString stringWithFormat:@"订购闲时包:%@",customerIfIdlePak];
        lb2ggllkh.text = [NSString stringWithFormat:@"2g高流量客户:%@",self.customer.customerIf_2g_high_flow];
        
        NSString *free_vol = self.customer.customerFreeVol;
        if(free_vol == nil){
            free_vol = @"0";
        }
        lbZsll.text = [NSString stringWithFormat:@"赠送流量:%@ M",free_vol];
        
        NSString *ifAddPak = self.customer.customerIfAddPak;
        if ([ifAddPak isEqualToString:@"0"]) {
            ifAddPak = @"否";
        } else {
            ifAddPak = @"是";
        }
        
        lbDgllb.text = [NSString stringWithFormat:@"订购流量包:%@",ifAddPak];
        
        if (self.dicFlow && self.dicFlow.count > 0 ) {
            
            NSString *t_flow_type_name = [self.dicFlow objectForKey:@"flow_type_name"];//流量种类
            lblLlzl.text = [NSString stringWithFormat:@"流量种类:%@",t_flow_type_name];
            
            NSString *t_discnt_name = [self.dicFlow objectForKey:@"discnt_name"];//优惠名称
            lblYhmc.text = [NSString stringWithFormat:@"优惠名称:%@",t_discnt_name];
            
        } else {
            
            NSString *t_flow_type_name = @"";//流量种类
            lblLlzl.text = [NSString stringWithFormat:@"流量种类:%@",t_flow_type_name];
            
            NSString *t_discnt_name = @"";//优惠名称
            lblYhmc.text = [NSString stringWithFormat:@"优惠名称:%@",t_discnt_name];
        }
        
    //新增字段 套餐内使用状态 套餐内流量使用量 套餐流量
        NSString *packagesStu=[self.dicFlow objectForKey:@"flow_sts"];
        lbNewChar9.text=[NSString stringWithFormat:@"套餐内使用状态:%@",packagesStu];
        
        NSString *packagesFlowStu=[self.dicFlow objectForKey:@"use_flow_in"];
        lbNewChar10.text=[NSString stringWithFormat:@"套餐内流量使用量:%@",packagesFlowStu];
        
        NSString *packagesFlow=[self.dicFlow objectForKey:@"flow_in"];
        lbNewChar11.text=[NSString stringWithFormat:@"套餐流量:%@",packagesFlow];
        
    }
//    else if(busType == BUSINESS_TERMINAL) {
    else if(self.markSegmentControl.selectedSegmentIndex== 1){
        NSString *customerSvcCode = self.customer.customerSvcCode;
        lbCustomerTelephone.text=[NSString stringWithFormat:@"手机号码:%@",customerSvcCode];
        
        NSString *customerChang_term_date = self.customer.customerChang_term_date;//更换终端月份：user.chang_term_date
        lbCustomerName.text = [NSString stringWithFormat:@"更换终端月份:%@ M",customerChang_term_date ];
        
        NSString *customerTermBrnd = self.customer.customerTermBrnd;//终端品牌：user.term_brnd
        lbDgxsb.text = [NSString stringWithFormat:@"终端品牌:%@",customerTermBrnd];
        
        NSString *is_zn_sj = self.customer.customerIsZnSj;//智能机终端：user.is_zn_sj
        if ([is_zn_sj isEqualToString:@"0"]) {
            is_zn_sj = @"否";
        } else {
            is_zn_sj = @"是";
        }
        lb2ggllkh.text = [NSString stringWithFormat:@"智能机终端:%@",is_zn_sj];
        
        NSString *customerTermSys = self.customer.customerTermSys;
        //终端制式：user.term_sys
        lbZsll.text = [NSString stringWithFormat:@"终端制式:%@ M",customerTermSys];
        
        //设置不使用标签为空顺数第6个
        lbDgllb.text=[NSString stringWithFormat:@""];
        //新增字段”保底费用“顺数第8个
        lblYhmc.text = [NSString stringWithFormat:@"保底费用:%@",[self.dicTerm objectForKey:@"trem_baodi_fee"]];

        // “活动名称”和“包名称" 字串过长放在第一竖排（7，9）
        if (self.dicTerm && self.dicTerm.count > 0 ) {
            
            NSString *prod_name = [self.dicTerm objectForKey:@"prod_name"];
            //活动名称：prod_name放在顺数第7个
            lblLlzl.text = [NSString stringWithFormat:@"活动名称:%@",prod_name];
            
            NSString *package_name = [self.dicTerm objectForKey:@"package_name"];
            //包名称：package_name放在顺数第9个
            lbNewChar9.text = [NSString stringWithFormat:@"包名称:%@",package_name];
            
        } else {
            
            NSString *prod_name = @"";
            //活动名称：prod_name放在顺数第7个
            lblLlzl.text = [NSString stringWithFormat:@"活动名称:%@",prod_name];
            
            NSString *package_name = @"";
            //包名称：package_name放在顺数第9个
            lbNewChar9.text = [NSString stringWithFormat:@"包名称:%@",package_name];
            
                    }
        //新增字段”开始日期“顺数第10个
        lbNewChar10.text= [NSString stringWithFormat:@"开始日期:%@",[self.dicTerm objectForKey:@"trem_start_date"]];
        //新增字段”截止日期“顺数第11个
        lbNewChar11.text=[NSString stringWithFormat:@"截止日期:%@",[self.dicTerm objectForKey:@"trem_end_date"]];
        
    }
//    else if(busType == BUSINESS_cunfeisongli) {
      else if(self.markSegmentControl.selectedSegmentIndex== 2){
    
        NSString *customerSvcCode = self.customer.customerSvcCode;
        lbCustomerTelephone.text=[NSString stringWithFormat:@"手机号码:%@",customerSvcCode];
        
    
        if (self.dicTerm && self.dicTerm.count > 0 ) {
            
            NSString *customerSale_active = self.customer.customerSale_active;
            //促销活动：sale_active 放在顺数第2个
            lb2ggllkh.text = [NSString stringWithFormat:@"促销活动:%@ M",customerSale_active ];
            
            NSString *customerActive_name = self.customer.customerActive_name;
            //活动名称：active_name放在顺数第3个
            lbCustomerName.text = [NSString stringWithFormat:@"活动名称:%@",customerActive_name];
            //设置为空顺数第4个
             lbZsll.text = @"";
            
            NSString *customerProdName = self.customer.customerProdName;
            //产品名称：prod_name放在顺数第5个
            lbDgxsb.text = [NSString stringWithFormat:@"产品名称:%@",customerProdName];
            //设置为空顺数第6个
            lbDgllb.text = @"";
            
            NSString *customerDiscntName = self.customer.customerDiscntName;
            //优惠名称：discnt_name放在顺数第7个
            lblLlzl.text = [NSString stringWithFormat:@"优惠名称:%@ M",customerDiscntName];
            
            //新增字段'资费档次'放在顺数第8个
            lblYhmc.text = [NSString stringWithFormat:@"资费档次:%@",[self.dicBind objectForKey:@"bind_sts_fee"]];
            //新增字段'保底费用'放在顺数第9个
            lbNewChar9.text = [NSString stringWithFormat:@"保底费用:%@",[self.dicBind objectForKey:@"bind_baodi_fee"]];
            //新增字段”开始日期“顺数第10个
            lbNewChar10.text= [NSString stringWithFormat:@"开始日期:%@",[self.dicBind objectForKey:@"bind_start_date"]];
            //新增字段”截止日期“顺数第11个
            lbNewChar11.text=[NSString stringWithFormat:@"截止日期:%@",[self.dicBind objectForKey:@"bind_end_date"]];
            
        } else {
            
//            NSString *customerSale_active = self.customer.customerSale_active;//促销活动：sale_active
            lbCustomerName.text = @"";
            
//            NSString *customerActive_name = self.customer.customerActive_name;//活动名称：active_name
            lbDgxsb.text = @"";
            
//            NSString *customerProdName = self.customer.customerProdName;//产品名称：prod_name
            lb2ggllkh.text = @"";
            
//            NSString *customerDiscntName = self.customer.customerDiscntName;//优惠名称：discnt_name
            lbZsll.text = @"";
            
            
            lbDgllb.text = @"";
            
            lblLlzl.text = @"";
            
            lblYhmc.text = [NSString stringWithFormat:@""];
             lbNewChar9.text =@"";
            lbNewChar10.text =@"";
            lbNewChar11.text =@"";


            

        }
        
        
    }
    
    
}


-(void)connectToNetwork{
    while (hudFlag) {
        //        usleep(100000);
        sleep(1);
    }
}

-(void)load_gprs_list{
        hudFlag=YES;
        MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate=self;
        HUD.labelText=@"数据查询中，请稍后...";
      [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlString=@"dimjson/gprs_list.json";
       NSString *baseUrlString=[NetworkHandling getBaseUrlString];
        urlString = [baseUrlString stringByAppendingString:urlString];
        // 其实这就是一个GET请求
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSLog(@"%d", data.length);
        //当属性只有为NSJSONReadingMutableContainers才修改返回的dic,NSJSONReadingAllowFragments NSJSONReadingMutableLeaves都不能
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
         //打印json字典
        NSArray *grpsObject=[dic objectForKey:@"grps"];
        flowArray=grpsObject;
        recommendArray = flowArray;
        isLoadFlowData=YES;
        for (NSMutableDictionary *dicObj in grpsObject) {

            [dicObj setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
        }
        // [self refeshrecommendedPackageTableView];
        [self performSelectorOnMainThread:@selector(refeshrecommendedPackageTableView) withObject:nil waitUntilDone:NO];
       hudFlag=NO;
    });
   

    
//    hudFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
//    
 //   [NetworkHandling getJsonWithUrl:@"dimjson/gprs_list.json" sendBody:nil processHandler:^(NSDictionary *result, NSError *error) {
//
//        if(!error){
//            NSArray *grpsObject=[result objectForKey:@"grps"];
//            flowArray=grpsObject;
//            recommendArray = flowArray;
//            isLoadFlowData=YES;
//            for (NSMutableDictionary *dicObj in grpsObject) {
//                
//                [dicObj setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
//            }
//  
//            [self performSelectorOnMainThread:@selector(refeshrecommendedPackageTableView) withObject:nil waitUntilDone:NO];
//            
//        }
//        else{
//     
//            [self load_gprs_list];
//        }
//        hudFlag=NO;
//        
//        
//    }];
}

-(void) refeshrecommendedPackageTableView{
    
    [recommendedPackageTableView reloadData];
    
    //刷新顶部信息
    [self initSubView];
    
}

-(void)load_phone_disc{
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlString=@"dimjson/phone_disc.json";
        NSString *baseUrlString=[NetworkHandling getBaseUrlString];
        urlString = [baseUrlString stringByAppendingString:urlString];

        // 其实这就是一个GET请求
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSLog(@"%d", data.length);
        //当属性只有为NSJSONReadingMutableContainers才修改返回的dic,NSJSONReadingAllowFragments NSJSONReadingMutableLeaves都不能
        NSMutableDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        //打印json字典
        NSArray *phoneObject=[dic objectForKey:@"phone"];
                    terminalArray=phoneObject;
                    recommendArray = terminalArray;
                    isLoadTerminalData=YES;
                    [self performSelectorOnMainThread:@selector(refeshrecommendedPackageTableView) withObject:nil waitUntilDone:NO];
        hudFlag=NO;
    });

    
//    hudFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
//    
//    [NetworkHandling getJsonWithUrl:@"dimjson/phone_disc.json" sendBody:nil processHandler:^(NSDictionary *result, NSError *error) {
//        
//        if(!error){
//            NSArray *phoneObject=[result objectForKey:@"phone"];
//            terminalArray=phoneObject;
//            recommendArray = terminalArray;
//            isLoadTerminalData=YES;
//            [self performSelectorOnMainThread:@selector(refeshrecommendedPackageTableView) withObject:nil waitUntilDone:NO];
//            
//        }
//        else{
//
//            [self load_phone_disc];
//        }
//        hudFlag=NO;
//        
//
//    }];
}
-(void)load_cunfeisongli{
    hudFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlString=@"dimjson/cunfeisongli.json";
        NSString *baseUrlString=[NetworkHandling getBaseUrlString];
        urlString = [baseUrlString stringByAppendingString:urlString];
        // 其实这就是一个GET请求
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSLog(@"%d", data.length);
        //当属性只有为NSJSONReadingMutableContainers才修改返回的dic,NSJSONReadingAllowFragments NSJSONReadingMutableLeaves都不能
        NSMutableDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        //打印json字典
        moreArray = [dic objectForKey:@"cunfeisongfei"];
                    cunfeisongliArray = [dic objectForKey:@"cunfeisongli"];
                    isLoadFeeData=YES;
                    [self performSelectorOnMainThread:@selector(refeshcunfeiTable) withObject:nil waitUntilDone:NO];

        hudFlag=NO;
    });

    
//    hudFlag=YES;
//    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.delegate=self;
//    HUD.labelText=@"数据查询中，请稍后...";
//    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
//    
//    [NetworkHandling getJsonWithUrl:@"dimjson/cunfeisongli.json" sendBody:nil processHandler:^(NSDictionary *result, NSError *error) {
//        
//        if(!error){
//            moreArray = [result objectForKey:@"cunfeisongfei"];
//            cunfeisongliArray = [result objectForKey:@"cunfeisongli"];
//            isLoadFeeData=YES;
//            [self performSelectorOnMainThread:@selector(refeshcunfeiTable) withObject:nil waitUntilDone:NO];
//        }
//        else{
//
//            [self load_cunfeisongli];
//        }
//        hudFlag=NO;
//    }];
}
-(void)loadDataErrorProcess{
    UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"没有获取到数据，再试一次？" delegate:self cancelButtonTitle:@"取 消" otherButtonTitles:@"确 定", nil];
    [alertview show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex){
        switch (busType) {
            case BUSINESS_FLOW:
                [self load_gprs_list];
                break;
            case BUSINESS_TERMINAL:
                [self load_phone_disc];
                break;
            case BUSINESS_cunfeisongli:
                [self load_cunfeisongli];
                break;
                
            default:
                break;
        }
    }
}
-(void) refeshcunfeiTable{
    
    [cunfeisongliTableView reloadData];
    [morePackagesTableView reloadData];
    
    //刷新顶部信息
    [self initSubView];
    
}


-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"MarketingCustomerDetailsSegue"]){
        MarketingCustomerDetailsTableViewController *controller=segue.destinationViewController;
        controller.customer=self.customer;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //if(tableView.tag == RECOMMENDED_PACKAGE_TABLEVIEW)
    /*当segmentcontrol为流量推荐或者终端推荐时*/
    if(self.markSegmentControl.selectedSegmentIndex== 0||self.markSegmentControl.selectedSegmentIndex== 1)
        return [recommendArray count];
    if(tableView.tag == MORE_cunfeisongfei_TABLEVIEW)
        return [moreArray count];
    if(tableView.tag == MORE_cunfeisongli_TABLEVIEW)
        return [cunfeisongliArray count];
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if(busType == BUSINESS_TERMINAL)
    if(self.markSegmentControl.selectedSegmentIndex== 1)
        return 100;
//    if(busType == BUSINESS_cunfeisongli)
        return 60;
//    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{//IndividualCustomerPackageTerminalTableViewCell
    IndividualCustomerPackageTableViewCell *cell;
    
//    UITableViewCell *cell;
    
//    if(busType == BUSINESS_FLOW)
        //流量业务
    if(self.markSegmentControl.selectedSegmentIndex== 0)
        cell = [tableView dequeueReusableCellWithIdentifier:@"IndividualCustomerPackageTableViewCell"];
//    if(busType == BUSINESS_cunfeisongli)
    if(self.markSegmentControl.selectedSegmentIndex== 2)
        //存费业务
        cell = [tableView dequeueReusableCellWithIdentifier:@"IndividualCustomerPackageTableViewCell"];
//    if(busType == BUSINESS_TERMINAL){
    if(self.markSegmentControl.selectedSegmentIndex== 1)
    {
        //终端业务IndividualCustomerPackageTerminalTableViewCell
        cell = [tableView dequeueReusableCellWithIdentifier:@"IndividualCustomerPackageTerminalTableViewCell"];
//        ((IndividualCustomerPackageTerminalTableViewCell*)cell).itemImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"phone-s%d",indexPath.row+1]];
        
        IndividualCustomerPackageTerminalTableViewCell *individualCell=(IndividualCustomerPackageTerminalTableViewCell*)cell;
        NSDictionary *item=[recommendArray objectAtIndex:indexPath.row];
        NSString *phone_img_url =[item objectForKey:@"phone_img_url"];
        NSString *imageUrl =[NetworkHandling getBaseUrlString];
        imageUrl=[imageUrl stringByAppendingString:phone_img_url];
//        if(![sumPicString isEqualToString:@""])
//        {
            NSURL *sumurl = [NSURL URLWithString:imageUrl];
            [ individualCell.itemImageView sd_setImageWithURL:sumurl placeholderImage:[UIImage imageNamed:@"null_Image"]];

//        if(imageUrl && (NSNull*)imageUrl != [NSNull null] && imageUrl.length > 0){
//            NSURL *url = [NSURL URLWithString:imageUrl];
//            dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
//            dispatch_async(queue, ^{
//                
//                NSData *resultData = [NSData dataWithContentsOfURL:url];
//                UIImage *img = [UIImage imageWithData:resultData];
//                if(img){
//                    dispatch_sync(dispatch_get_main_queue(), ^{
//                        
//                        individualCell.itemImageView.image = img;
//                    });
//                }
//            });
//        }
    }
    
//    if(tableView.tag == RECOMMENDED_PACKAGE_TABLEVIEW)
    if(self.markSegmentControl.selectedSegmentIndex== 0||self.markSegmentControl.selectedSegmentIndex== 1)
    {
        //流量表和终端表
        
        NSDictionary *item=[recommendArray objectAtIndex:indexPath.row];
        BOOL selected = [[item objectForKey:@"selected"] boolValue];
        if(selected){
            
            [cell.itemSelectedButton setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
            
        }else{
            
            [cell.itemSelectedButton setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
            
        }
        
        
//        if(busType == BUSINESS_FLOW)
        if(self.markSegmentControl.selectedSegmentIndex== 0)
        {
            
            cell.itemName.text=[item objectForKey:@"gprs_name"];
            cell.itemPrice=[item objectForKey:@"gprs_fee"];
            cell.itemDetails.text=[item objectForKey:@"gprs_inf"];
        }
//        if(busType == BUSINESS_TERMINAL)
        if(self.markSegmentControl.selectedSegmentIndex== 1)
        {
            
            cell.itemName.text=[item objectForKey:@"phone_mold"];
            cell.itemPrice=[item objectForKey:@"phone_price"];
            cell.itemDetails.text=[item objectForKey:@"phone_remark"];
        }

    }
    
    if(tableView.tag == MORE_cunfeisongfei_TABLEVIEW){
        //存费送费表
        
        NSDictionary *item=[moreArray objectAtIndex:indexPath.row];
        
        BOOL selected = [[item objectForKey:@"selected"] boolValue];
        if(selected){
            
            [cell.itemSelectedButton setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
            
        }else{
            
            [cell.itemSelectedButton setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
            
        }
        
            cell.itemName.text=[item objectForKey:@"save_fee"];//预存话费
            //            cell.itemPrice=[item objectForKey:@"phone_price"];
            //            赠送话费<%=v.give_fee%>元，自由消费<%=v.free_fee%>元，协议月保底<%=v.baodi_fee%>元，分月数<%=v.month_cnt%>个月，月返还<%=v.month_give_fee%>元
            NSString *give_fee = [item objectForKey:@"give_fee"];
            NSString *free_fee = [item objectForKey:@"free_fee"];
            NSString *baodi_fee = [item objectForKey:@"baodi_fee"];
            NSString *month_cnt = [item objectForKey:@"month_cnt"];
            NSString *month_give_fee = [item objectForKey:@"month_give_fee"];
            
            NSString *sm = [NSString stringWithFormat:@"赠送话费%@元，自由消费%@元，协议月保底%@元，分月数%@个月，月返还%@元",give_fee,free_fee,baodi_fee,month_cnt,month_give_fee];
            cell.itemDetails.text=sm;
//        }
    }
    
    if(tableView.tag == MORE_cunfeisongli_TABLEVIEW){//存费送礼表
        NSDictionary *item=[cunfeisongliArray objectAtIndex:indexPath.row];
        
        BOOL selected = [[item objectForKey:@"selected"] boolValue];
        if(selected){
            
            [cell.itemSelectedButton setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
            
        }else{
            
            [cell.itemSelectedButton setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
            
        }
      
            cell.itemName.text=[item objectForKey:@"save_fee"];
//            cell.itemPrice=[item objectForKey:@"price"];
            
//            合约期<%=v.treaty_cnt%>个月，每月返还费用<%=v.month_give_fee%>元，赠送电子券<%=v.give_dianzijuan%>元
            NSString *treaty_cnt = [item objectForKey:@"treaty_cnt"];
            NSString *month_give_fee = [item objectForKey:@"month_give_fee"];
            NSString *give_dianzijuan = [item objectForKey:@"give_dianzijuan"];
            
            NSString *sm = [NSString stringWithFormat:@"合约期%@个月，每月返还费用%@元，赠送电子券%@元",treaty_cnt,month_give_fee,give_dianzijuan];
            
            cell.itemDetails.text=sm;
   
    }
    

    
    cell.itemName.numberOfLines=0;
    cell.itemDetails.numberOfLines=0;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(selectedCell){
//        [selectedCell.itemSelectedButton setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    }
    
    selectedCell = (IndividualCustomerPackageTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
//    if(tableView.tag == RECOMMENDED_PACKAGE_TABLEVIEW)
    if(self.markSegmentControl.selectedSegmentIndex== 0||self.markSegmentControl.selectedSegmentIndex== 1)
    {
        
        //设置为初始状态
        for (NSMutableDictionary *dicO in recommendArray) {
            
            [dicO setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
        }
        
        selectItem=[recommendArray objectAtIndex:indexPath.row];//
        BOOL selected=[[selectItem objectForKey:@"selected"] boolValue];
        [selectedCell.itemSelectedButton setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
        [selectItem setObject:[NSNumber numberWithBool:!selected] forKey:@"selected"];
        
        [recommendedPackageTableView reloadData];

    }
    if(tableView.tag == MORE_cunfeisongfei_TABLEVIEW){
        
        //设置为初始状态
        for (NSMutableDictionary *dicO in moreArray) {
            
            [dicO setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
        }
        
        selectItem=[moreArray objectAtIndex:indexPath.row];
        BOOL selected=[[selectItem objectForKey:@"selected"] boolValue];
        [selectedCell.itemSelectedButton setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
        [selectItem setObject:[NSNumber numberWithBool:!selected] forKey:@"selected"];
        [morePackagesTableView reloadData];
        
        //
        //清空存费送礼表选择状态
        for (NSMutableDictionary *dicO in cunfeisongliArray) {
            
            [dicO setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
        }
        [cunfeisongliTableView reloadData];
    }
    if(tableView.tag == MORE_cunfeisongli_TABLEVIEW){
        
        //设置为初始状态
        for (NSMutableDictionary *dicO in cunfeisongliArray) {
            
            [dicO setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
        }
        
        selectItem=[cunfeisongliArray objectAtIndex:indexPath.row];
        BOOL selected=[[selectItem objectForKey:@"selected"] boolValue];
        [selectedCell.itemSelectedButton setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
        [selectItem setObject:[NSNumber numberWithBool:!selected] forKey:@"selected"];
        [cunfeisongliTableView reloadData];
        
        //
        //清空存费送费表选择状态
        for (NSMutableDictionary *dicO in moreArray) {
            
            [dicO setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
        }
        [morePackagesTableView reloadData];
        
        
    }

    
}

#pragma mark 修改三个button为segmentcontrol

- (void) controlPressed:(id)sender {
    int selectedIndex = [ self.markSegmentControl selectedSegmentIndex ];
     NSLog(@"Segment %d selected\n", selectedIndex);
    //流量推荐
    if (selectedIndex==0) {
        [self initSubView];
        recommendedPackageTableView.hidden = NO;
        
        morePackagesTableView.hidden=YES;
        cunfeisongliTableView.hidden=YES;
        vwCFSLTips.hidden=YES;
        vwCFSFTips.hidden=YES;
        
        busType=BUSINESS_FLOW;
        //    if(!flowArray)
        //        [self load_gprs_list];
        //    else{
        //        recommendArray=nil;
        //        recommendArray=flowArray;
        //        [self refeshrecommendedPackageTableView];
        //    }
        
        if(!isLoadFlowData)
            [self load_gprs_list];
        else{
            recommendArray=flowArray;
            [recommendedPackageTableView reloadData];
        }
    }
    //终端推荐
    if (selectedIndex==1) {
        [self initSubView];
        recommendedPackageTableView.hidden = NO;
        
        morePackagesTableView.hidden=YES;
        cunfeisongliTableView.hidden=YES;
        vwCFSLTips.hidden=YES;
        vwCFSFTips.hidden=YES;
        
        busType=BUSINESS_TERMINAL;
        //    if(!terminalArray)
        //        [self load_phone_disc];
        //    else{
        //        recommendArray=nil;
        //        recommendArray=terminalArray;
        //        [self refeshrecommendedPackageTableView];
        //    }
        
        if(!isLoadTerminalData)
            [self load_phone_disc];
        else{
            recommendArray=terminalArray;
            [recommendedPackageTableView reloadData];
        }

    }
    //存费送礼
     if (selectedIndex==2) {
         [self initSubView];
         recommendedPackageTableView.hidden = YES;
         
         morePackagesTableView.hidden=NO;
         cunfeisongliTableView.hidden=NO;
         vwCFSLTips.hidden=NO;
         vwCFSFTips.hidden=NO;
         
         busType=BUSINESS_cunfeisongli;
         if(!isLoadFeeData)
             [self load_cunfeisongli];
     }
    
    /* 添加代码,处理值的变化 */
}

- (IBAction)btnCunfeisongliOnClick:(id)sender {//存费送礼
    
    [btnCunfeisongli setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [flowPackageButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [phoneTerminalButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    recommendedPackageTableView.hidden = YES;
    
    morePackagesTableView.hidden=NO;
    cunfeisongliTableView.hidden=NO;
    vwCFSLTips.hidden=NO;
    vwCFSFTips.hidden=NO;
    
    busType=BUSINESS_cunfeisongli;
    if(!isLoadFeeData)
        [self load_cunfeisongli];

}

- (IBAction)phoneTerminalButtonOnclick:(id)sender { //终端推荐
    
    [phoneTerminalButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [flowPackageButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [btnCunfeisongli setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    recommendedPackageTableView.hidden = NO;

    morePackagesTableView.hidden=YES;
    cunfeisongliTableView.hidden=YES;
    vwCFSLTips.hidden=YES;
    vwCFSFTips.hidden=YES;
    
    busType=BUSINESS_TERMINAL;
//    if(!terminalArray)
//        [self load_phone_disc];
//    else{
//        recommendArray=nil;
//        recommendArray=terminalArray;
//        [self refeshrecommendedPackageTableView];
//    }
    
    if(!isLoadTerminalData)
        [self load_phone_disc];
    else{
        recommendArray=terminalArray;
        [recommendedPackageTableView reloadData];
    }

}

- (IBAction)flowPackageButtonOnclick:(id)sender {//流量推荐
    
    [flowPackageButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [phoneTerminalButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [btnCunfeisongli setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    recommendedPackageTableView.hidden = NO;
    
    morePackagesTableView.hidden=YES;
    cunfeisongliTableView.hidden=YES;
    vwCFSLTips.hidden=YES;
    vwCFSFTips.hidden=YES;
    
    busType=BUSINESS_FLOW;
//    if(!flowArray)
//        [self load_gprs_list];
//    else{
//        recommendArray=nil;
//        recommendArray=flowArray;
//        [self refeshrecommendedPackageTableView];
//    }
    
    if(!isLoadFlowData)
        [self load_gprs_list];
    else{
        recommendArray=flowArray;
        [recommendedPackageTableView reloadData];
    }
}



- (IBAction)sendSMS:(id)sender {

    if(!selectedCell){
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
    
    
#if (defined MANAGER_CS_VERSION) || (defined STANDARD_CS_VERSION)
    msg=@"尊敬的长沙移动集团客户：向您推荐【%@】%@,%@，详询集团客户经理%@（%@）";
#endif
    
#if (defined MANAGER_SY_VERSION) || (defined STANDARD_SY_VERSION)
    msg=@"尊敬的邵阳移动集团客户：向您推荐【%@】%@,%@，详询集团营销经理%@（%@）";
#endif
    
    picker.recipients=contactArray;
    picker.body=[NSString stringWithFormat:msg,selectedCell.itemName.text,selectedCell.itemDetails.text,selectedCell.itemPrice,self.user.userName,self.user.userMobile];
    
    validateFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在组织短信发送数据...";
    [HUD showWhileExecuting:@selector(idleForSegue) onTarget:self withObject:nil animated:YES];
    
    [self presentViewController:picker animated:YES completion:^{
        validateFlag=NO;
    }];
    
}
-(void)idleForSegue{
    while (validateFlag) {
        usleep(100000);
    }
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
- (IBAction)goBusinessProcess:(id)sender {
    if(!selectedCell){
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您还没有选择发送信息！" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
        [myAlertView show];
        return;
    }
    NSString *tel=lbCustomerTelephone.text;
    if(self.isGroup){
        int i=0;
        for (NSDictionary *dict in self.groupUserList) {
            BOOL selected=[[dict objectForKey:@"selected"] boolValue];
            if(selected){
                tel = [dict objectForKey:@"svc_code"];
                i++;
            }
        }
        
        if(i > 1){
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"业务办理只能选择一个用户！" delegate:nil cancelButtonTitle:nil  otherButtonTitles:@"确定", nil];
            [myAlertView show];
            return;
        }
    }
    
    //FlowBusinessProcessViewControllerId
    
//    if(busType == BUSINESS_TERMINAL)
    if(self.markSegmentControl.selectedSegmentIndex== 1)
    {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
        PreferentialPurchaseViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"PreferentialPurchaseViewControllerId"];
        controller.user=self.user;
//        controller.isSelected=YES;
//        controller.selectedItem=selectItem;
        
        controller.selectedCustomerPhone=tel;
        controller.selectedCustomerGroup=self.group;
        controller.groupName=self.customer.customerGrpName;
        controller.isSelected=YES;
        controller.terminalName =[selectItem objectForKey:@"name"];
        controller.terminalDesc=[selectItem objectForKey:@"desc"];
        controller.terminalPrice=[selectItem objectForKey:@"price"];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
//    cell.itemName.text=[item objectForKey:@"name"];
//    cell.itemPrice=[item objectForKey:@"price"];
//    if(listSwitch==0){
//        cell.itemDetails.text=[item objectForKey:@"flow"];
//    }
//    if(listSwitch==1){
//        cell.itemDetails.text=[item objectForKey:@"desc"];
//    }
    
//    else if(busType == BUSINESS_FLOW){
    else if(self.markSegmentControl.selectedSegmentIndex== 0)
    {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BusinessProcess" bundle:nil];
        FlowBusinessProcessViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"FlowBusinessProcessViewControllerId"];
        controller.user=self.user;
//        controller.isSelected=YES;
        controller.flowName=[selectItem objectForKey:@"name"];
        controller.flowDesc=[selectItem objectForKey:@"flow"];
        controller.flowPrice=[selectItem objectForKey:@"price"];
        controller.customerTel=lbCustomerTelephone.text;
        
        [self.navigationController pushViewController:controller animated:YES];
//        [controller loadCustomerData];
    }
}


@end
