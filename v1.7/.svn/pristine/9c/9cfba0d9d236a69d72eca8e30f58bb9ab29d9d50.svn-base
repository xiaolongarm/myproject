//
//  OnlineTestMakeViewController.m
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/23.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "OnlineTestMakeViewController.h"
#import "OnlineTestResultViewController.h"
#import "NetworkHandling.h"
#import "MBProgressHUD.h"

@interface OnlineTestMakeViewController ()<MBProgressHUDDelegate>
{
    BOOL hubFlag;
    int topage;
    int papers_time;
    int start_time;
    int papers_code;
    int currentpage;
    NSArray *questionDetails;
    UILabel *questionLabel;
    
    NSDictionary *testDetails;
    NSMutableArray *boolAnswerA;
    NSMutableArray *boolAnswerB;
    NSMutableArray *boolAnswerC;
    NSMutableArray *boolAnswerD;
    NSMutableArray *lastAnswer;
    UIAlertView *alerViewQuit;
    UIAlertView *alerViewHand1;
    UIAlertView *alerViewHand2;
    MBProgressHUD *HudShow;
}
@end

@implementation OnlineTestMakeViewController

@synthesize leftSwipeGestureRecognizer,rightSwipeGestureRecognizer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self questionDown:nil];
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self questionUP:nil];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    HudShow =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HudShow];
    HudShow.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HudShow.mode = MBProgressHUDModeCustomView;
    HudShow.delegate = self;

    alerViewQuit =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"退出系统",NULL)
                                                        message:NSLocalizedString(@" ",NULL)
                                                       delegate:self  cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    alerViewHand1 =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"交卷提醒",NULL)
                                                        message:NSLocalizedString(@" ",NULL)
                                                       delegate:self  cancelButtonTitle:@"查看未做"
                                              otherButtonTitles:@"确认交卷", nil];
    alerViewHand2 =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"交卷提醒",NULL)
                                                        message:NSLocalizedString(@" ",NULL)
                                                       delegate:self  cancelButtonTitle:@"返回查看"
                                              otherButtonTitles:@"确认交卷", nil];

    
    [self initSubPage];
    boolAnswerA=[[NSMutableArray alloc] init];
    boolAnswerB=[[NSMutableArray alloc] init];
    boolAnswerC=[[NSMutableArray alloc] init];
    boolAnswerD=[[NSMutableArray alloc] init];
    lastAnswer = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadTestData];
    
    
}


-(void)loadTestData{
    hubFlag=YES;
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=nil;
    [HUD showWhileExecuting:@selector(connectToNetwork) onTarget:self withObject:nil animated:YES];
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    
    [NetworkHandling sendPackageWithUrl:@"question/GetExamInf" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            //TODO erro code
            testDetails = [result objectForKey:@"exam"];
            [self getPapers:testDetails];
//            self.recordList =[result objectForKey:@"exam"];
            if( 0){
                //                [self.onlineTestTableView reloadData];
//                [self performSelectorOnMainThread:@selector(refreshvisitPlanTableView) withObject:nil waitUntilDone:YES];
                //                [self reloadKesData:visit_sta];
                
            }else{
                
                ;
            }
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
        }
//        hubFlag=NO;
    }];
}

-(void)getPapers:(NSDictionary*)dic{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    [bDict setValue:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setValue:[dic objectForKey:@"exam_batch"] forKey:@"exam_batch"];
    [bDict setValue:[dic objectForKey:@"question_cnt"] forKey:@"question_cnt"];
    [bDict setValue:[dic objectForKey:@"question_buss_type"] forKey:@"question_buss_type"];
    [bDict setValue:[dic objectForKey:@"exam_end_time"] forKey:@"exam_end_time"];
    [NetworkHandling sendPackageWithUrl:@"question/GetPapersInf" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            //TODO erro code
            [self performSelectorOnMainThread:@selector(startTest:) withObject:result waitUntilDone:YES];
            [self performSelectorOnMainThread:@selector(addPapersUserInf:) withObject:testDetails waitUntilDone:YES];

            //            self.recordList =[result objectForKey:@"exam"];
            if( 0){
                
            }else{
                
                ;
            }
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
}

-(void)addPapersUserInf:(NSDictionary*)dict{
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    
    [bDict setValue:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setValue:[dict objectForKey:@"exam_batch"] forKey:@"exam_batch"];
    [NetworkHandling sendPackageWithUrl:@"question/AddPapersUserInf" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            //TODO erro code
            if( 0){
                
            }else{
                
                ;
            }
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
        }
        hubFlag=NO;
    }];
}

-(void)startTest:(NSDictionary*)dict{
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    papers_time = [[dict objectForKey:@"papers_time"]intValue];
    start_time = [[dict objectForKey:@"papers_time"]intValue];
    papers_code = [[dict objectForKey:@"papers_code"]intValue];
    questionDetails = [dict objectForKey:@"questions"];
    self.testQuestionDetails = [dict objectForKey:@"questions"];
//    papers_time=[[dict objectForKey:@"papers_time"]intValue];
    
    self.pageLabel.textAlignment = NSTextAlignmentCenter;
    self.pageLabel.text = [NSString stringWithFormat:@"1/%d",[questionDetails count]];
    currentpage = 1;
    [self showQuestion:currentpage - 1];

    [self showAnswer:currentpage - 1];
    for (int i = 0; i < [questionDetails count]; i++)
    {
        [boolAnswerA addObject:[NSNumber numberWithInt:0]];
        [boolAnswerB addObject:[NSNumber numberWithInt:0]];
        [boolAnswerC addObject:[NSNumber numberWithInt:0]];
        [boolAnswerD addObject:[NSNumber numberWithInt:0]];
    }
    
     [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];//使用timer定时，每秒触发一次
    
    
}

- (IBAction)clickAnswerA:(id)sender {
    NSDictionary *key = [questionDetails objectAtIndex:currentpage - 1];
    int type = [[key objectForKey:@"question_type"]intValue];
    if (type == 1 || type == 3)
    {
        [self.imageAnswerA setImage:[UIImage imageNamed:@"勾选"]];
//        [boolAnswerA insertObject:[NSNumber numberWithInt:1] atIndex:currentpage - 1];
        [boolAnswerA replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:1]];
        
        if ([(NSNumber*)[boolAnswerB objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerB setImage:[UIImage imageNamed:@"未勾选"]];
//            [boolAnswerB insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
            [boolAnswerB replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
        }
        if ([(NSNumber*)[boolAnswerC objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerC setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerC replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerC insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        if ([(NSNumber*)[boolAnswerD objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerD setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerD replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerD insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
    }
    else{
        if ([(NSNumber*)[boolAnswerA objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerA setImage:[UIImage imageNamed:@"未勾选"]];
            
            [boolAnswerA replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
            
//            [boolAnswerA insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        else{
            [self.imageAnswerA setImage:[UIImage imageNamed:@"勾选"]];
            
            [boolAnswerA replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:1]];
//            [boolAnswerA insertObject:[NSNumber numberWithInt:1] atIndex:currentpage - 1];
        }
    }
    
}

- (IBAction)clickAnswerB:(id)sender {
    
    NSDictionary *key = [questionDetails objectAtIndex:currentpage - 1];
    int type = [[key objectForKey:@"question_type"]intValue];
    if (type == 1 || type == 3)
    {
        [self.imageAnswerB setImage:[UIImage imageNamed:@"勾选"]];
//        [boolAnswerB insertObject:[NSNumber numberWithInt:1] atIndex:currentpage - 1];
        [boolAnswerB replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:1]];
        if ([(NSNumber*)[boolAnswerA objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerA setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerA replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerA insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        if ([(NSNumber*)[boolAnswerC objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerC setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerC replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerC insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        if ([(NSNumber*)[boolAnswerD objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerD setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerD replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerD insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
    }
    else{
        if ([(NSNumber*)[boolAnswerB objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerB setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerB replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerB insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        else{
            [self.imageAnswerB setImage:[UIImage imageNamed:@"勾选"]];
            [boolAnswerB replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:1]];
//            [boolAnswerB insertObject:[NSNumber numberWithInt:1] atIndex:currentpage - 1];
        }
        
    }
    
}

- (IBAction)clickAnswerC:(id)sender {
    NSDictionary *key = [questionDetails objectAtIndex:currentpage - 1];
    int type = [[key objectForKey:@"question_type"]intValue];
    if (type == 3)
    {
        return;
    }
    if (type == 1 || type == 3)
    {
        [self.imageAnswerC setImage:[UIImage imageNamed:@"勾选"]];
        [boolAnswerC replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:1]];
//        [boolAnswerC insertObject:[NSNumber numberWithInt:1] atIndex:currentpage - 1];
        
        if ([(NSNumber*)[boolAnswerB objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerB setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerB replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerB insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        if ([(NSNumber*)[boolAnswerA objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerA setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerA replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerA insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        if ([(NSNumber*)[boolAnswerD objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerD setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerD replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerD insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
    }
    else{
        if ([(NSNumber*)[boolAnswerC objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerC setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerC replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerC insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        else{
            [self.imageAnswerC setImage:[UIImage imageNamed:@"勾选"]];
            [boolAnswerC replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:1]];
//            [boolAnswerC insertObject:[NSNumber numberWithInt:1] atIndex:currentpage - 1];
        }
        
    }

}

- (IBAction)clickAnswerD:(id)sender {
    NSDictionary *key = [questionDetails objectAtIndex:currentpage - 1];
    int type = [[key objectForKey:@"question_type"]intValue];

    if (type == 3)
    {
        return;
    }
    if (type == 1 || type == 3)
    {
        [self.imageAnswerD setImage:[UIImage imageNamed:@"勾选"]];
        [boolAnswerD replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:1]];
//        [boolAnswerD insertObject:[NSNumber numberWithInt:1] atIndex:currentpage - 1];
        if ([(NSNumber*)[boolAnswerB objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerB setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerB replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerB insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        if ([(NSNumber*)[boolAnswerC objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerC setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerC replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerC insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        if ([(NSNumber*)[boolAnswerA objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerA setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerA replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerA insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
    }
    else{
        if ([(NSNumber*)[boolAnswerD objectAtIndex:currentpage - 1]boolValue]) {
            [self.imageAnswerD setImage:[UIImage imageNamed:@"未勾选"]];
            [boolAnswerD replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:0]];
//            [boolAnswerD insertObject:[NSNumber numberWithInt:0] atIndex:currentpage - 1];
        }
        else{
            [self.imageAnswerD setImage:[UIImage imageNamed:@"勾选"]];
            [boolAnswerD replaceObjectAtIndex:currentpage - 1 withObject:[NSNumber numberWithInt:1]];
//            [boolAnswerD insertObject:[NSNumber numberWithInt:1] atIndex:currentpage - 1];
        }
        
    }
}


-(void)showQuestion:(int)page{

    NSDictionary *key = [questionDetails objectAtIndex:page];
    UIFont *fontOne = [UIFont systemFontOfSize:14.0];//设置字体大小
    NSString *titleOne = [NSString stringWithFormat:@"%@",[key objectForKey:@"question"]];//要显示的内容
// 
    CGSize maximumLabelSizeOne = CGSizeMake(315,MAXFLOAT);//315为我需要的UILabel的长度
    CGSize expectedLabelSizeOne = [titleOne sizeWithFont:fontOne
                                       constrainedToSize:maximumLabelSizeOne
                                           lineBreakMode:NSLineBreakByWordWrapping]; //expectedLabelSizeOne.height 就是内容的高度
    
    //初始化UILabel
    CGRect pointValueRect = CGRectMake(5, 60 ,315, expectedLabelSizeOne.height + 40);
    
    questionLabel.frame  = pointValueRect;
    
    //questionLabel.constraints=
    questionLabel.hidden = NO;
   
    questionLabel.text = titleOne;
    int type = [[key objectForKey:@"question_type"]intValue];
    switch (type) {
        case 1:
            self.labelType.text = @"单选题";
            break;
        case 2:
            self.labelType.text = @"多选题";
            break;
        case 3:
            self.labelType.text = @"判断题";
            break;
        default:
            break;
    }

}

-(void)showAnswer:(int)page{
    NSDictionary *key = [questionDetails objectAtIndex:page];
    int type = [[key objectForKey:@"question_type"]intValue];
    
    self.cutLine.frame = CGRectMake(self.cutLine.frame.origin.x, -3 + questionLabel.frame.origin.y + questionLabel.frame.size.height ,self.cutLine.frame.size.width, self.cutLine.frame.size.height);
    
    self.imageAnswerA.frame = CGRectMake(5, 22 + questionLabel.frame.origin.y + questionLabel.frame.size.height ,self.imageAnswerA.frame.size.width, self.imageAnswerA.frame.size.height);
    self.btnAnswerA.frame = CGRectMake(0, 22 + questionLabel.frame.origin.y + questionLabel.frame.size.height ,self.btnAnswerA.frame.size.width, self.btnAnswerA.frame.size.height);
    
    NSDictionary * chose = [key objectForKey:@"chose"];
    NSString *answera = [chose objectForKey:@"A"];
    NSString *answerb = [chose objectForKey:@"B"];
    NSString *titleOneA = [NSString stringWithFormat:@"A、%@",answera];
    NSString *titleOneB = [NSString stringWithFormat:@"B、%@",answerb];
    CGSize maximumLabelSizeOne = CGSizeMake(260,MAXFLOAT);
    CGSize expectedLabelSizeOneA = [titleOneA sizeWithFont:[UIFont systemFontOfSize:14.0]
                                       constrainedToSize:maximumLabelSizeOne
                                           lineBreakMode:NSLineBreakByWordWrapping];
    CGSize expectedLabelSizeOneB = [titleOneB sizeWithFont:[UIFont systemFontOfSize:14.0]
                                         constrainedToSize:maximumLabelSizeOne
                                             lineBreakMode:NSLineBreakByWordWrapping];
    
    
    self.labelAnswerA.frame = CGRectMake(5 + self.imageAnswerA.frame.size.width, self.btnAnswerA.frame.origin.y - 17,260, expectedLabelSizeOneA.height + 40);
    self.labelAnswerA.text = titleOneA;
    
    self.imageAnswerB.frame = CGRectMake(5, 5 + self.labelAnswerA.frame.origin.y + self.labelAnswerA.frame.size.height ,self.imageAnswerB.frame.size.width, self.imageAnswerB.frame.size.height);
    self.btnAnswerB.frame = CGRectMake(0, self.imageAnswerB.frame.origin.y  ,self.btnAnswerB.frame.size.width, self.btnAnswerB.frame.size.height);
    
    self.labelAnswerB.frame = CGRectMake(5 + self.imageAnswerA.frame.size.width, self.btnAnswerB.frame.origin.y - 17,260, expectedLabelSizeOneB.height + 40);
    self.labelAnswerB.text = titleOneB;
    
    
    self.labelAnswerA.backgroundColor = [UIColor clearColor];
    self.labelAnswerB.backgroundColor = [UIColor clearColor];
    self.labelAnswerC.backgroundColor = [UIColor clearColor];
    self.labelAnswerD.backgroundColor = [UIColor clearColor];
    
    switch (type) {
        case 1:
        case 2:
        {
            self.imageAnswerC.hidden = NO;
            self.imageAnswerD.hidden = NO;
            self.labelAnswerC.hidden = NO;
            self.labelAnswerD.hidden = NO;
            NSString *answerc = [chose objectForKey:@"C"];
            NSString *answerd = [chose objectForKey:@"D"];
            NSString *titleOneC = [NSString stringWithFormat:@"C、%@",answerc];
            NSString *titleOneD = [NSString stringWithFormat:@"D、%@",answerd];
            CGSize maximumLabelSizeOne = CGSizeMake(260,MAXFLOAT);
            CGSize expectedLabelSizeOneC = [titleOneC sizeWithFont:[UIFont systemFontOfSize:14.0]
                                                 constrainedToSize:maximumLabelSizeOne
                                                     lineBreakMode:NSLineBreakByWordWrapping];
            CGSize expectedLabelSizeOneD = [titleOneD sizeWithFont:[UIFont systemFontOfSize:14.0]
                                                 constrainedToSize:maximumLabelSizeOne
                                                     lineBreakMode:NSLineBreakByWordWrapping];
            self.imageAnswerC.frame = CGRectMake(5, 5 + self.labelAnswerB.frame.origin.y + self.labelAnswerB.frame.size.height ,self.imageAnswerC.frame.size.width, self.imageAnswerC.frame.size.height);
            self.btnAnswerC.frame = CGRectMake(0, self.imageAnswerC.frame.origin.y  ,self.btnAnswerC.frame.size.width, self.btnAnswerC.frame.size.height);
            self.labelAnswerC.frame = CGRectMake(5 + self.imageAnswerC.frame.size.width, self.btnAnswerC.frame.origin.y - 17,260, expectedLabelSizeOneC.height + 40);
//            questionLabel.lineBreakMode = UILineBreakModeWordWrap;
            self.labelAnswerC.text = titleOneC;
            
            self.imageAnswerD.frame = CGRectMake(5, 5 + self.labelAnswerC.frame.origin.y + self.labelAnswerC.frame.size.height ,self.imageAnswerD.frame.size.width, self.imageAnswerD.frame.size.height);
            self.btnAnswerD.frame = CGRectMake(0, self.imageAnswerD.frame.origin.y  ,self.btnAnswerD.frame.size.width, self.btnAnswerD.frame.size.height);
            self.labelAnswerD.frame = CGRectMake(5 + self.imageAnswerD.frame.size.width, self.btnAnswerD.frame.origin.y - 17,260, expectedLabelSizeOneD.height + 40);
            self.labelAnswerD.text = titleOneD;
            
            break;
        }
        case 3:
            self.imageAnswerC.hidden = YES;
            self.imageAnswerD.hidden = YES;
            self.labelAnswerC.hidden = YES;
            self.labelAnswerD.hidden = YES;
            break;
            
        default:
            break;
    }
    questionLabel.hidden = NO;
    questionLabel.text = [NSString stringWithFormat:@"%@",[key objectForKey:@"question"]];
    
}

-(void)showMyAnswer{
    if ([(NSNumber*)[boolAnswerA objectAtIndex:currentpage - 1]boolValue]) {
        [self.imageAnswerA setImage:[UIImage imageNamed:@"勾选"]];
    }
    else{
        [self.imageAnswerA setImage:[UIImage imageNamed:@"未勾选"]];
    }
    if ([(NSNumber*)[boolAnswerB objectAtIndex:currentpage - 1]boolValue]) {
        [self.imageAnswerB setImage:[UIImage imageNamed:@"勾选"]];
    }
    else{
        [self.imageAnswerB setImage:[UIImage imageNamed:@"未勾选"]];
    }
    if ([(NSNumber*)[boolAnswerC objectAtIndex:currentpage - 1]boolValue]) {
        [self.imageAnswerC setImage:[UIImage imageNamed:@"勾选"]];
    }
    else{
        [self.imageAnswerC setImage:[UIImage imageNamed:@"未勾选"]];
    }
    if ([(NSNumber*)[boolAnswerD objectAtIndex:currentpage - 1]boolValue]) {
        [self.imageAnswerD setImage:[UIImage imageNamed:@"勾选"]];
    }
    else{
        [self.imageAnswerD setImage:[UIImage imageNamed:@"未勾选"]];
    }
}


- (IBAction)questionUP:(id)sender {
    if ( currentpage > 1)
    {
        currentpage --;
        self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",currentpage,[questionDetails count]];
        [self showQuestion:currentpage - 1];
        [self showAnswer:currentpage - 1];
    }
    [self showMyAnswer];

}
- (IBAction)questionDown:(id)sender {
    
    if (currentpage < [questionDetails count])
    {
        currentpage ++;
        self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",currentpage,[questionDetails count]];
        [self showQuestion:currentpage - 1];
        [self showAnswer:currentpage - 1];
    }
    else{
        HudShow.labelText = @"已是最后一题";
        [HudShow show:YES];
        [HudShow hide:YES afterDelay:1];
    }
    
    [self showMyAnswer];
}

-(void)connectToNetwork{
    while (hubFlag) {
        usleep(100000);
    }
}


- (void)timerFireMethod:(NSTimer*)theTimer{

    papers_time --;
    if (papers_time <= 0) {
        if (papers_time == 0) {
            [alerViewQuit dismissWithClickedButtonIndex:0 animated:YES];
            [alerViewHand1 dismissWithClickedButtonIndex:0 animated:YES];
            [alerViewHand2 dismissWithClickedButtonIndex:0 animated:YES];
            self.timeLabel.text = [NSString stringWithFormat:@"00:00:00"];
            HudShow.labelText = @"时间到,考试结束";
            [HudShow show:YES];
            [HudShow hide:YES afterDelay:2];
            
            [lastAnswer removeAllObjects];
            NSString *temp = nil;
            topage = -1;
            int unfinish = 0;
            for (int i = 0; i < [questionDetails count]; i++)
            {
                temp = nil;
                if ([(NSNumber*)[boolAnswerA objectAtIndex:i]boolValue]) {
                    temp = [NSString stringWithFormat:@"%@",@"A"];
                }
                if ([(NSNumber*)[boolAnswerB objectAtIndex:i]boolValue]) {
                    if (temp){
                        temp = [NSString stringWithFormat:@"%@%@",temp,@"B"];
                    }
                    else{
                        temp = [NSString stringWithFormat:@"%@",@"B"];
                    }
                    
                }
                if ([(NSNumber*)[boolAnswerC objectAtIndex:i]boolValue]) {
                    if (temp){
                        temp = [NSString stringWithFormat:@"%@%@",temp,@"C"];
                    }
                    else{
                        temp = [NSString stringWithFormat:@"%@",@"C"];
                    }
                    
                }
                if ([(NSNumber*)[boolAnswerD objectAtIndex:i]boolValue]) {
                    if (temp) {
                        temp = [NSString stringWithFormat:@"%@%@",temp,@"D"];
                    }
                    else{
                        temp = [NSString stringWithFormat:@"%@",@"D"];
                    }
                    
                }
                if (temp) {
                    [lastAnswer addObject:temp];
                }
                else{
                    [lastAnswer addObject:[NSNumber numberWithInt:0]];
                    unfinish ++;
                    if (topage == -1)
                    {
                        topage = i;
                    }
                }
                
            }
            [self didAddPapersInf];
        }
        return;
    }
    int seconds = papers_time % 60;
    int minutes = (papers_time / 60) % 60;
    int hours = papers_time / 3600;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
//    self.timeLabel.text = [NSString stringWithFormat:@"%d:%d:%d",[d hour], [d minute], [d second]];
}

-(void)showMessage:(NSString*)infomation{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"信息提示" message:infomation delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

- (void) initSubPage{
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"在线考试";
//    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"交卷" style:UIBarButtonItemStylePlain target:self action:@selector(handinPaper)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    
    UIFont *fontOne = [UIFont systemFontOfSize:14.0];//设置字体大小
    NSString *titleOne =@" ";//要显示的内容
    CGSize maximumLabelSizeOne = CGSizeMake(315,MAXFLOAT);//315为我需要的UILabel的长度
    CGSize expectedLabelSizeOne = [titleOne sizeWithFont:fontOne
                                       constrainedToSize:maximumLabelSizeOne
                                           lineBreakMode:NSLineBreakByWordWrapping]; //expectedLabelSizeOne.height 就是内容的高度
    
    //初始化UILabel
    CGRect pointValueRect = CGRectMake(5, 60 ,315, expectedLabelSizeOne.height);
    
    questionLabel = [[UILabel alloc] initWithFrame:pointValueRect];
    questionLabel.text = [NSString stringWithFormat:@"%@",@" "];
    questionLabel.backgroundColor = [UIColor clearColor];
    questionLabel.textColor = [UIColor grayColor];
    questionLabel.textAlignment = NSTextAlignmentLeft;
    questionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    questionLabel.font = [UIFont systemFontOfSize:14];
    questionLabel.numberOfLines = 0;
    
    [self.view addSubview:questionLabel];
    questionLabel.hidden = YES;
    self.pageUpImage.transform = CGAffineTransformMakeScale(-1.0, 1.0);
}

-(void)goBack{
    
//    NSString *starttime = [testDetails objectForKey:@"exam_start_time"];
//    NSString *endtime = [testDetails objectForKey:@"exam_end_time"];
    NSString *remind = nil;
    
    NSString* timeStr = [NSString stringWithFormat:@"%@", [testDetails objectForKey:@"exam_start_time"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
    //    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH:mm"];
    NSString *currentDateStr1 = [dateFormatter1 stringFromDate:date];
    
    NSString* timeStr2 = [NSString stringWithFormat:@"%@", [testDetails objectForKey:@"exam_end_time"]];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init] ;
    [formatter2 setDateStyle:NSDateFormatterMediumStyle];
    [formatter2 setTimeStyle:NSDateFormatterShortStyle];
    [formatter2 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date2 = [formatter dateFromString:timeStr2];
    //    NSString *timeSp2 = [NSString stringWithFormat:@"%ld", (long)[date2 timeIntervalSince1970]];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm"];
    NSString *currentDateStr2 = [dateFormatter2 stringFromDate:date2];
    
    if (papers_code == 0) {
        remind = [NSString stringWithFormat:@"您还未完成考试哦!如果退出,今天%@到%@还有一次机会参与考试,未在规定时间内完成考试,当月考试成绩为零分,您确定要退出吗?",currentDateStr1,currentDateStr2];
    }
    else if(papers_code == 3){
        remind = [NSString stringWithFormat:@"您还未完成考试哦!如果退出,则不能再次参与考试,未在规定时间内完成考试,当月考试成绩为零分,您确定要退出吗?"];
    }
//    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"退出系统",NULL)
//                                                        message:NSLocalizedString(remind,NULL)
//                                                       delegate:self  cancelButtonTitle:@"取消"
//                                              otherButtonTitles:@"确定", nil];
    alerViewQuit.title = @"退出系统";
    alerViewQuit.message = remind;
    alerViewQuit.tag = 13;  // tag 13 为退出试卷提醒弹出框
    [alerViewQuit show];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 11){  // 已完成所有题目交卷
        if (buttonIndex == 0)
        {
            
        }
        else
        {
            [self didAddPapersInf];
            
        }
    }
    else if (alertView.tag == 12){  // 未完成题目交卷
        if (buttonIndex == 0)
        {
            currentpage = topage + 1;
            self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",currentpage,[questionDetails count]];
            [self showQuestion:currentpage - 1];
            [self showAnswer:currentpage - 1];
            
            [self showMyAnswer];
        }
        else
        {
            [self didAddPapersInf];
            
        }
    }
    else if(alertView.tag == 13){  //退出试卷 放弃考试
        if (buttonIndex == 0)
        {
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)handinPaper{
    
    [lastAnswer removeAllObjects];
    NSString *temp = nil;
    topage = -1;
    int unfinish = 0;
    for (int i = 0; i < [questionDetails count]; i++)
    {
        temp = nil;
        if ([(NSNumber*)[boolAnswerA objectAtIndex:i]boolValue]) {
            temp = [NSString stringWithFormat:@"%@",@"A"];
        }
        if ([(NSNumber*)[boolAnswerB objectAtIndex:i]boolValue]) {
            if (temp){
                temp = [NSString stringWithFormat:@"%@%@",temp,@"B"];
            }
            else{
                temp = [NSString stringWithFormat:@"%@",@"B"];
            }
            
        }
        if ([(NSNumber*)[boolAnswerC objectAtIndex:i]boolValue]) {
            if (temp){
                temp = [NSString stringWithFormat:@"%@%@",temp,@"C"];
            }
            else{
                temp = [NSString stringWithFormat:@"%@",@"C"];
            }
            
        }
        if ([(NSNumber*)[boolAnswerD objectAtIndex:i]boolValue]) {
            if (temp) {
                temp = [NSString stringWithFormat:@"%@%@",temp,@"D"];
            }
            else{
                temp = [NSString stringWithFormat:@"%@",@"D"];
            }
            
        }
        if (temp) {
            [lastAnswer addObject:temp];
        }
        else{
            [lastAnswer addObject:[NSNumber numberWithInt:0]];
            unfinish ++;
            if (topage == -1)
            {
                topage = i;
            }
        }
        
    }

    if (unfinish > 0)
    {
        NSString *description = [NSString stringWithFormat:@"您还有%d道题未完成,确认交卷吗?",unfinish];
        alerViewHand1.title = @"交卷提醒";
        alerViewHand1.message = description;
        alerViewHand1.tag = 12;  // tag 12 为未完成题目交卷提醒弹出框
        [alerViewHand1 show];
    }
    else{
        NSString *description = [NSString stringWithFormat:@"您已完成试卷,确认交卷吗?"];
        alerViewHand2.title = @"交卷提醒";
        alerViewHand2.message = description;
        
        alerViewHand2.tag = 11;  // tag 11 为完成所有题目交卷提醒弹出框
        [alerViewHand2 show];
//        [self didAddPapersInf];
    }
    
}

- (void)didAddPapersInf
{
    NSString *content = nil;
    for (int i = 0; i < [questionDetails count]; i++)
    {
        if ([lastAnswer objectAtIndex:i])
        {
            if (i == [questionDetails count] - 1)
            {
                if (content) {
                    content = [NSString stringWithFormat:@"%@%@",content,[lastAnswer objectAtIndex:i]];
                }
                else{
                    content = [NSString stringWithFormat:@"%@",[lastAnswer objectAtIndex:i]];
                }
            }
            else
            {
                if (content) {
                    content = [NSString stringWithFormat:@"%@%@,",content,[lastAnswer objectAtIndex:i]];
                }
                else{
                    content = [NSString stringWithFormat:@"%@,",[lastAnswer objectAtIndex:i]];
                }
            }
        }
        else{
            if (i == [questionDetails count] - 1)
            {
                if (content) {
                    content = [NSString stringWithFormat:@"%@%@",content,nil];
                }
                else{
                    content = [NSString stringWithFormat:@"%@",nil];
                }
            }
            else{
                if (content){
                    content = [NSString stringWithFormat:@"%@%@,",content,nil];
                }
                else{
                    content = [NSString stringWithFormat:@"%@,",nil];
                }
            }
        }
    }
    
    NSMutableDictionary *bDict=[[NSMutableDictionary alloc] init];
    [bDict setObject:[NSNumber numberWithInt:self.user.userID] forKey:@"user_id"];
    [bDict setValue:[testDetails objectForKey:@"exam_batch"] forKey:@"exam_batch"];//questionDetails
    [bDict setValue:questionDetails forKey:@"papers_content"];
    
    int seconds = (start_time - papers_time)% 60;
    int minutes = ((start_time - papers_time) / 60) % 60;
    int hours = (start_time - papers_time) / 3600;
    
    NSString *tempTime = [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    if (hours == 0) {
        tempTime = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }
    [bDict setValue:tempTime forKey:@"time"];
    [bDict setValue:content forKey:@"exam_content"];
    [bDict setValue:[NSNumber numberWithInt:[questionDetails count]] forKey:@"question_cnt"];
    
    [NetworkHandling sendPackageWithUrl:@"question/AddPapersInf" sendBody:bDict processHandler:^(NSDictionary *result, NSError *error) {
        
        if(!error){
            [self performSelectorOnMainThread:@selector(startCheckResut:) withObject:result waitUntilDone:YES];
            
            
            //            self.recordList =[result objectForKey:@"exam"];
            if( 0){
                
            }else{
                
                ;
            }
        }else{
            int errorCode=[[result valueForKey:@"errorcode"] intValue];
            NSLog(@"error:%d error:%@",errorCode,[error localizedDescription]);
            [self performSelectorOnMainThread:@selector(showMessage:) withObject:[error localizedDescription] waitUntilDone:YES];
        }
    }];
}

-(void)startCheckResut:(NSDictionary*)dict{
    
    OnlineTestResultViewController *vc = [[OnlineTestResultViewController alloc] initWithNibName:@"OnlineTestResultViewController" bundle:nil];
    vc.testQuestionDetails = self.testQuestionDetails;
    vc.addPapersInfresult = dict;
    vc.user = self.user;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
