
#import "OtherRegressCustomerTableViewCell.h"
#import "OtherRegressCustomerViewController.h"
#import "MBProgressHUD.h"
#import "NetworkHandling.h"
#import "OtherRegressCustomerDetailsTableViewController.h"
#import "VariableStore.h"
#import "OtherRegressFeedbackController.h"

@interface OtherRegressCustomerViewController ()<MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *tableArray;
    
    NSDictionary *customerDetials;
    BOOL validateFlag;
}

@end

@implementation OtherRegressCustomerViewController

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
    customerTableView.delegate=self;
    customerTableView.dataSource=self;
    
    customerName.text=[self.diffUserDict objectForKey:@"diff_user_name"];
    customerPhone.text=[self.diffUserDict objectForKey:@"diff_svc_code"];
//    customerLvl.text=@"";
    NSString *isHighUser=[self.diffUserDict objectForKey:@"is_high_user"];
    customerLvl.hidden=![isHighUser isEqualToString:@"是"];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"客户资料" style:UIBarButtonItemStylePlain target:self action:@selector(goDetails)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
}
-(void)goDetails{
    [self performSegueWithIdentifier:@"OtherRegressCustomerDetailsSegue" sender:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadTableData];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)loadTableData{
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:self.user.userMobile forKey:@"grp_svc_code"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:[self.diffUserDict objectForKey:@"diff_svc_code"] forKey:@"diff_svc_code"];
    
    [NetworkHandling sendPackageWithUrl:@"diffuserback/linkList" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            tableArray =[result objectForKey:@"linkUser"];
            if(tableArray && [tableArray count]>0){
                NSDictionary *dict=[tableArray objectAtIndex:0];
                
                NSString *isHighUser=[dict objectForKey:@"is_high_user"];
                if([isHighUser isEqualToString:@"是"]){
                    customerLvl.text=@"高端用户";
                    customerLvl.textColor=[UIColor colorWithRed:55/255.0 green:132/255.0 blue:173/255.0 alpha:1];
                }
                
                BOOL isSensitiveUserFlag=[[dict objectForKey:@"is_sensitive_user"] boolValue];
                if(isSensitiveUserFlag){
                    customerLvl.text=@"敏感";
                    customerLvl.textColor=[UIColor orangeColor];
                }
            }
            
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

-(void)refreshTableView{
    [customerTableView reloadData];
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
//OtherRegressCustomerDetailsSegue
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"OtherRegressCustomerDetailsSegue"]){
        OtherRegressCustomerDetailsTableViewController *detialsController=segue.destinationViewController;
        detialsController.user=self.user;
        detialsController.diffUserDict=self.diffUserDict;
  
        
    }else if ([segue.identifier isEqualToString:@"OtherRegressFeedbackControllerCallPhoneSegue"]){
        
        OtherRegressFeedbackController *detialsController=segue.destinationViewController;
        detialsController.linkType=1;
        detialsController.user=self.user;
        detialsController.diffUserDict=self.diffUserDict;
        
    }else if([segue.identifier isEqualToString:@"OtherRegressFeedbackControllerSmsSegue"]){
        
        OtherRegressFeedbackController *detialsController=segue.destinationViewController;
        detialsController.linkType=0;//短信
        detialsController.user=self.user;
        detialsController.diffUserDict=self.diffUserDict;
        
    }
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
    OtherRegressCustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherRegressCustomerTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict=[tableArray objectAtIndex:indexPath.row];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *linkDate=[dateFormatter dateFromString:[dict objectForKey:@"link_date"]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yy-MM-dd"];
    
    cell.itemDate.text=[dateFormatter1 stringFromDate:linkDate];

    cell.itemContent.text=[dict objectForKey:@"link_remark"];
    BOOL linkType=[[dict objectForKey:@"link_type"] boolValue]; //0:短信/1;电话
    if(linkType)
        cell.itemTypeImage.image=[UIImage imageNamed:@"电话"];
    else
        cell.itemTypeImage.image=[UIImage imageNamed:@"短信"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (IBAction)callPhone:(id)sender {
    [self performSegueWithIdentifier:@"OtherRegressFeedbackControllerCallPhoneSegue" sender:self];
}
- (IBAction)callSMS:(id)sender {
    [self performSegueWithIdentifier:@"OtherRegressFeedbackControllerSmsSegue" sender:self];
}


@end
