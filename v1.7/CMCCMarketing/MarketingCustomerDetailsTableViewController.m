//
//  MarketingCustomerDetailsTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-30.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "MarketingCustomerDetailsTableViewCell.h"
#import "MarketingCustomerDetailsTableViewController.h"

@interface MarketingCustomerDetailsTableViewController ()

@end

@implementation MarketingCustomerDetailsTableViewController

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
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if(section == 0)
//        return 13;
//    else
//        return 6;
    
    switch (section) {
        case 0:
            return 6;
        case 1:
            return 4;
        case 2:
            return 6;//
        case 3:
            return 4;
        case 4:
            return 2;
//        case 5:
//            return 3;
            
        default:
            break;
    }
    return 0;
}
// 设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = nil;
    v = [[UIView alloc] initWithFrame:CGRectMake(0, -10, 300, 20)];
    [v setBackgroundColor:[UIColor clearColor]];
    
//    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 200.0f, 20.0f)];
    UILabel *labelTitle = [[UILabel alloc] init];
    if(section!=0)
        labelTitle.frame=CGRectMake(10.0f, -5.0f, 200.0f, 20.0f);
    else
        labelTitle.frame=CGRectMake(10.0f, 7.0f, 200.0f, 20.0f);
    
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.textColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1.0];
    labelTitle.font=[UIFont systemFontOfSize:14];
    
//    if (section == 0) {
//        labelTitle.text = @"基础信息";
//    }
//    else{
//        labelTitle.text = @"通话情况";
//    }
    
    switch (section) {
        case 0:
            labelTitle.text = @"用户基本特征";
            break;
        case 1:
            labelTitle.text = @"业务特征";
            break;
        case 2:
            labelTitle.text = @"流量特征";
            break;
        case 3:
            labelTitle.text = @"终端特征";
            break;
        case 4:
            labelTitle.text = @"指标特征";
            break;
//        case 5:
//            labelTitle.text = @"指标特征";
//            break;
            
        default:
            break;
    }
    
    [v addSubview:labelTitle];
    return v;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketingCustomerDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketingCustomerDetailsTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                cell.itemLabel1.text=@"手机号码：";
                cell.itemLabel2.text=self.customer.customerSvcCode;
                cell.itemLabel3.text=@"县市：";
                cell.itemLabel4.text=self.customer.customerAreaName;
            }
            if(indexPath.row == 1){
                cell.itemLabel1.text=@"归属类型：";
                cell.itemLabel2.text=self.customer.customerLocnTypeName;
                cell.itemLabel3.text=@"年龄段：";
                cell.itemLabel4.text=self.customer.customerAgeTypeDesc;
            }
            if(indexPath.row == 2){
                cell.itemLabel1.text=@"客户类型：";
                cell.itemLabel2.text=self.customer.customerCustTypeDesc;
                cell.itemLabel3.text=@"VIP类型：";
                cell.itemLabel4.text=self.customer.customerVipLvlName;
            }
            if(indexPath.row == 3){
                cell.itemLabel1.text=@"集团名称：";
                cell.itemLabel2.text=self.customer.customerGrpName;
                cell.itemLabel2.adjustsFontSizeToFitWidth=YES;
                cell.itemLabel3.text=@"";
                cell.itemLabel4.text=@"";
            }
            if(indexPath.row == 4){
                cell.itemLabel1.text=@"集团编码：";
                cell.itemLabel2.text=self.customer.customerGrpCode;
                cell.itemLabel2.adjustsFontSizeToFitWidth=YES;
                cell.itemLabel3.text=@"";
                cell.itemLabel4.text=@"";
            }
            if(indexPath.row == 5){
                NSLog(@"-------enter section:%ld row:%ld cell--------",(long)indexPath.section ,(long)indexPath.row);
                cell.itemLabel1.textColor = [UIColor redColor];
                cell.itemLabel2.textColor = [UIColor redColor];
                cell.itemLabel3.textColor = [UIColor redColor];
                cell.itemLabel4.textColor = [UIColor redColor];
                
                cell.itemLabel1.text=@"abc类客户：";
                
                NSString *customerIf_abc_group = self.customer.customerIf_abc_group;
                cell.itemLabel2.text=customerIf_abc_group;
                cell.itemLabel3.text=@"是否关键人：";
                NSString *customerIf_inport_cust = self.customer.customerIf_inport_cust;
                cell.itemLabel4.text=customerIf_inport_cust;
                
            }
            break;
            
        case 1:
            if(indexPath.row == 0){
                cell.itemLabel1.text=@"产品：";
                cell.itemLabel2.text=self.customer.customerProdName;
                cell.itemLabel2.adjustsFontSizeToFitWidth=YES;
                cell.itemLabel3.text=@"";
                cell.itemLabel4.text=@"";
            }
            if(indexPath.row == 1){
                cell.itemLabel1.text=@"主套餐：";
                cell.itemLabel2.text=self.customer.customerDiscntName;
                
                cell.itemLabel2.adjustsFontSizeToFitWidth=YES;
                cell.itemLabel3.text=@"";
                cell.itemLabel4.text=@"";
            }
            if(indexPath.row == 2){
                
                cell.itemLabel3.textColor = [UIColor redColor];
                cell.itemLabel4.textColor = [UIColor redColor];
                
                cell.itemLabel1.text=@"GPRS开通：";
                cell.itemLabel2.text=self.customer.customerIfGprssvc?@"开通":@"未开通";
                cell.itemLabel3.text=@"预存类型：";
                
                NSString *customerBind_name = self.customer.customerBind_name;
                if (customerBind_name.length<=0 ) {
                    customerBind_name = @"-";
                }
                cell.itemLabel4.text=customerBind_name;
            }
            if(indexPath.row == 3){
                cell.itemLabel1.textColor = [UIColor redColor];
                cell.itemLabel2.textColor = [UIColor redColor];
                
                cell.itemLabel1.text=@"是否预存：";
                cell.itemLabel2.text=self.customer.customerIf_bind;
                cell.itemLabel3.hidden=YES;
                cell.itemLabel4.hidden=YES;
            }
            break;
            
        case 2:
            if(indexPath.row == 0){
                
                cell.itemLabel1.textColor = [UIColor redColor];
                cell.itemLabel2.textColor = [UIColor redColor];
                
                cell.itemLabel1.text=@"2g高流量客户：";
                cell.itemLabel2.text=self.customer.customerIf_2g_high_flow;

                
                cell.itemLabel3.text=@"零流量：";
                NSString *customerIfNilVol = self.customer.customerIfNilVol;
                if ([customerIfNilVol isEqualToString:@"0"]) {
                    customerIfNilVol = @"否";
                } else {
                    customerIfNilVol = @"是";
                }
                cell.itemLabel4.text=customerIfNilVol;

            }
            if(indexPath.row == 1){
                cell.itemLabel1.text=@"赠送流量：";
                
                NSString *free_vol = self.customer.customerFreeVol;

                if(free_vol == nil){
                    free_vol = @"0";
                }
                cell.itemLabel2.text= [NSString stringWithFormat:@"%@ M",free_vol];
                
                cell.itemLabel3.text=@"套餐超出流量：";
                NSString *flw_disc_pass_tol_vol = self.customer.customerFlwDiscPassTolVol;
                
                if(flw_disc_pass_tol_vol == nil){
                    flw_disc_pass_tol_vol = @"0";
                }
                cell.itemLabel4.text= [NSString stringWithFormat:@"%@ M",flw_disc_pass_tol_vol ];
            }
            if(indexPath.row == 2){
                cell.itemLabel1.text=@"订购闲时包：";
                
                NSString *customerIfIdlePak = self.customer.customerIfIdlePak;
                if ([customerIfIdlePak isEqualToString:@"0"]) {
                    customerIfIdlePak = @"否";
                } else {
                    customerIfIdlePak = @"是";
                }
                
                cell.itemLabel2.text=customerIfIdlePak;
                
                cell.itemLabel3.text=@"订购加油包：";
                
                NSString *customerIfAddPak = self.customer.customerIfAddPak;
                if ([customerIfAddPak isEqualToString:@"0"]) {
                    customerIfAddPak = @"否";
                } else {
                    customerIfAddPak = @"是";
                }
                
                cell.itemLabel4.text= customerIfAddPak;
            }
            if(indexPath.row == 3){
                cell.itemLabel1.text=@"是否3g用户：";
                cell.itemLabel2.text=self.customer.customerIf_3gUser;
                cell.itemLabel3.text=@"是否4g用户：";
                cell.itemLabel4.text=self.customer.customerIf_4gUser;
            }
            if(indexPath.row == 4){
                cell.itemLabel1.text=@"是否4g终端：";
                cell.itemLabel2.text=self.customer.customerIf_4gTerm;
                cell.itemLabel3.text=@"是否4g卡：";
                cell.itemLabel4.text=self.customer.customerIf_4gCard;
            }
            if(indexPath.row == 5){
                cell.itemLabel1.text=@"4g套餐：";
                cell.itemLabel2.text=self.customer.customerDiscnt4G;
                cell.itemLabel3.text=@"";
                cell.itemLabel4.text=@"";
            }

            break;
            
        case 3:
            if(indexPath.row == 0){
                cell.itemLabel1.text=@"终端品牌：";
                cell.itemLabel2.text=self.customer.customerTermBrnd;
                cell.itemLabel3.text=@"";
                cell.itemLabel4.text=@"";
            
            }
            if(indexPath.row == 1){
                cell.itemLabel1.text=@"终端制式：";
                cell.itemLabel2.text=self.customer.customerTermSys;
                cell.itemLabel2.adjustsFontSizeToFitWidth=YES;
                cell.itemLabel3.text=@"";
                cell.itemLabel4.text=@"";
                
            }
            if(indexPath.row == 2){
                cell.itemLabel1.text=@"终端操作系统：";
                cell.itemLabel2.text=self.customer.customerOsSys;
                
                cell.itemLabel3.text=@"智能机终端：";
                if([self.customer.customerIsZnSj isEqualToString:@"1"])
                    cell.itemLabel4.text=@"是";
                else
                    cell.itemLabel4.text=@"否";
               
                
            }
            if(indexPath.row == 3){
                
                cell.itemLabel1.textColor = [UIColor redColor];
                cell.itemLabel2.textColor = [UIColor redColor];
                
                cell.itemLabel1.text=@"更换终端月份：";
                cell.itemLabel2.text=self.customer.customerChang_term_date;
                cell.itemLabel3.hidden = YES;
                cell.itemLabel4.hidden = YES;

            }
            
            break;
            
        case 4:
            
            if(indexPath.row == 0){
                cell.itemLabel1.text=@"总消费：";
            
                cell.itemLabel2.text=[NSString stringWithFormat:@"%@ 元",self.customer.customerIncm];
                cell.itemLabel3.text=@"上网4g流量：";
                cell.itemLabel4.text=[NSString stringWithFormat:@"%@ M",self.customer.customerG4Vol];
  
            }
            if(indexPath.row == 1){
                cell.itemLabel1.text=@"上网2g流量：";
                cell.itemLabel2.text=[NSString stringWithFormat:@"%@ M",self.customer.customerG2Vol];
                cell.itemLabel3.text=@"上网3g流量：";
                cell.itemLabel4.text=[NSString stringWithFormat:@"%@ M",self.customer.customerG3Vol];
                
            }
            if(indexPath.row == 2){
                cell.itemLabel1.text=@"上网4g流量：";
                cell.itemLabel2.text=[NSString stringWithFormat:@"%@ M",self.customer.customerG4Vol];

                
                cell.itemLabel3.hidden = YES;
                cell.itemLabel4.hidden = YES;
                
            }
            
            
            
            break;
            
        case 5:
//            if(indexPath.row == 0){
//                cell.itemLabel1.text=@"总消费：";
//                cell.itemLabel2.text=[NSString stringWithFormat:@"%@元",self.customer.customerIncm];
//                cell.itemLabel3.text=@"手机上网消费：";
//                cell.itemLabel4.text=[NSString stringWithFormat:@"%@ 元",self.customer.customerSjGprsFee];
//                
////                cell.itemLabel1Rect=cell.itemLabel1.frame;
////                cell.itemLabel2Rect=cell.itemLabel2.frame;
////                cell.itemLabel3Rect=cell.itemLabel3.frame;
////                cell.itemLabel4Rect=cell.itemLabel4.frame;
//            }
//            if(indexPath.row == 1){
//                cell.itemLabel1.text=@"上网2g流量：";
//                cell.itemLabel2.text=[NSString stringWithFormat:@"%@ 元",self.customer.customerG2Vol];
//                cell.itemLabel3.text=@"上网3g流量：";
//                cell.itemLabel4.text=[NSString stringWithFormat:@"%@ 元",self.customer.customerG3Vol];
//                
////                cell.itemLabel1Rect=cell.itemLabel1.frame;
////                cell.itemLabel2Rect=cell.itemLabel2.frame;
////                cell.itemLabel3Rect=cell.itemLabel3.frame;
////                cell.itemLabel4Rect=cell.itemLabel4.frame;
//            }
//            if(indexPath.row == 2){
//                cell.itemLabel1.text=@"上网4g流量：";
//                cell.itemLabel2.text=[NSString stringWithFormat:@"%@ 元",self.customer.customerG4Vol];
//                cell.itemLabel3.text=@"上网平均时长：";
//                cell.itemLabel4.text=@"未知";
//                
////                cell.itemLabel1Rect=cell.itemLabel1.frame;
////                cell.itemLabel2Rect=cell.itemLabel2.frame;
////                cell.itemLabel3Rect=cell.itemLabel3.frame;
////                cell.itemLabel4Rect=cell.itemLabel4.frame;
//            }
//            
//            break;
            
        default:
            break;
    }
    
    
    return cell;
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

@end
