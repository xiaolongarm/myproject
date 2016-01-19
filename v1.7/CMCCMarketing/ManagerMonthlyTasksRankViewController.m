//
//  ManagerMonthlyTasksRankViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-18.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "ManagerMonthlyTasksRankViewController.h"
#import "ManagerMonthlyTasksRankTableViewCell.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"
#import "ManagerMonthlyTasksDetailsViewController.h"
#import "ManagerMonthlyTasksCreatorTableViewController.h"

@interface ManagerMonthlyTasksRankViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
    BOOL hubFlag;
    NSArray *timesArray;
    NSArray *currentMonthArray;
    NSArray *nextMonthArray;
    
    NSDictionary *selectDict;
}

@end

@implementation ManagerMonthlyTasksRankViewController

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
    
    taskRankTableView.delegate=self;
    taskRankTableView.dataSource=self;

//    NSDate *now=[NSDate date];
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy年MM月"];
//    
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setMonth:1];
//    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDate *mDate = [calender dateByAddingComponents:comps toDate:now options:0];
//    
//    [dateSegment setTitle:[dateFormatter stringFromDate:now] forSegmentAtIndex:0];
//    [dateSegment setTitle:[dateFormatter stringFromDate:mDate] forSegmentAtIndex:1];
//    [dateSegment addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
//    dateSegment.selectedSegmentIndex=0;
//    [self segmentSelected:dateSegment];
    
    
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pencil2"] style:UIBarButtonItemStylePlain target:self action:@selector(goCreator)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"数据查询中，请稍后...";
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    [self loadTasksData];
}
-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}

-(void)loadTasksData{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"userID"];
    [bDict setObject:[NSNumber numberWithInt:self.user.userEnterprise] forKey:@"enterprise"];
    [bDict setObject:[NSNumber numberWithInt:self.typeId] forKey:@"type_id"];
    
    [NetworkHandling sendPackageWithUrl:@"monthlyplay/LeaderMonthlyPlay" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            NSLog(@"sign in success");
            timesArray =[result objectForKey:@"times"];
            nextMonthArray =[result objectForKey:@"nextMonth"];
            currentMonthArray =[result objectForKey:@"currentMonth"];
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
    
    lbDatetime.text=[timesArray objectAtIndex:0];
//    [dateSegment setTitle:[timesArray objectAtIndex:0] forSegmentAtIndex:0];
//    [dateSegment setTitle:[timesArray objectAtIndex:1] forSegmentAtIndex:1];
//    [dateSegment addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
//    dateSegment.selectedSegmentIndex=0;
//    [self segmentSelected:dateSegment];
    
    [taskRankTableView reloadData];
}
-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud=nil;
}
//-(void)segmentSelected:(id)sender{
//    UISegmentedControl* control = (UISegmentedControl*)sender;
//    int index=control.selectedSegmentIndex;
//    
//    if(index){
//        [self performSegueWithIdentifier:@"ManagerMonthlyTasksCreatorSegue" sender:self];
//    }
//        
////    [taskRankTableView reloadData];
//}
-(void)goCreator{
    [self performSegueWithIdentifier:@"ManagerMonthlyTasksCreatorSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ManagerMonthlyTasksDetailsSegue"]){
        ManagerMonthlyTasksDetailsViewController *controller=segue.destinationViewController;
        controller.title=self.title;
        controller.detailsDict=selectDict;
        controller.date=lbDatetime.text;
//        controller.date = [dateSegment titleForSegmentAtIndex:dateSegment.selectedSegmentIndex];
    }
    if([segue.identifier isEqualToString:@"ManagerMonthlyTasksCreatorSegue"]){
        ManagerMonthlyTasksCreatorTableViewController *controller=segue.destinationViewController;
        controller.title=[timesArray objectAtIndex:1];
        controller.currentMonthArray=nextMonthArray;
        controller.lastMonthArray=currentMonthArray;
        controller.user=self.user;
        controller.typeId=self.typeId;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if(dateSegment.selectedSegmentIndex == 0)
//        return [currentMonthArray count];
//    if(dateSegment.selectedSegmentIndex == 1)
//        return [nextMonthArray count];
//    return 0;
    return [currentMonthArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagerMonthlyTasksRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManagerMonthlyTasksRankTableViewCell" forIndexPath:indexPath];
    
//    cell.itemTitle.text=[tableArray objectAtIndex:indexPath.row];
    NSDictionary *dict=[currentMonthArray objectAtIndex:indexPath.row];

//    if(dateSegment.selectedSegmentIndex == 0)
//        dict=[currentMonthArray objectAtIndex:indexPath.row];
//    if(dateSegment.selectedSegmentIndex == 1)
//        dict=[nextMonthArray objectAtIndex:indexPath.row];
    
        
    cell.itemIndex.text=[NSString stringWithFormat:@"%d",[[dict objectForKey:@"rank"] intValue]];
    cell.itemName.text=[dict objectForKey:@"name"];
    int totalNumber=[[dict objectForKey:@"target"] intValue];
    int finishedNumber=[[dict objectForKey:@"finish"] intValue];
    float percentage=totalNumber?(float)finishedNumber/totalNumber:0.0;
//    NSLog(@" %d / %d = %f",finishedNumber,totalNumber,percentage);
    cell.itemTotalNumber.text=[NSString stringWithFormat:@"%d",totalNumber];
    cell.itemFinishedContent.text=[NSString stringWithFormat:@"已完成%d%@",finishedNumber,[dict objectForKey:@"unit"]];
    cell.itemPercentage.text=[NSString stringWithFormat:@"%.f%%",percentage*100];
    [cell.itemProgressBar setProgress:percentage];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //ManagerMonthlyTasksDetailsSegue
    
//    if(dateSegment.selectedSegmentIndex == 0)
//        selectDict=[currentMonthArray objectAtIndex:indexPath.row];
//    if(dateSegment.selectedSegmentIndex == 1)
//        selectDict=[nextMonthArray objectAtIndex:indexPath.row];
    selectDict=[currentMonthArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ManagerMonthlyTasksDetailsSegue" sender:self];
}

@end
