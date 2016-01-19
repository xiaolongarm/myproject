//
//  OnlineTestResultViewController.m
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/24.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "OnlineTestResultViewController.h"
#import "OnlineTestViewController.h"
#import "OnlineTestCheckAnswerViewController.h"
#import "OnlineTestMakeViewController.h"
@interface OnlineTestResultViewController ()

@end

@implementation OnlineTestResultViewController

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
    [self initSubPage];
    // Do any additional setup after loading the view from its nib.
    self.backgroundView.layer.borderColor = [UIColor colorWithRed:252/255.0 green:205/255.0 blue:50/255.0 alpha:1.0].CGColor;
    self.backgroundView.layer.borderWidth=5;
    self.backgroundView.layer.masksToBounds=YES;
    self.backgroundView.layer.cornerRadius=11;
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
//    [self performSelector:@selector(startLoad:) withObject:nil afterDelay:0.5];
    [self performSelectorOnMainThread:@selector(startLoad:) withObject:nil waitUntilDone:YES];
    
}


-(void)startLoad:(NSDictionary*)dict{
    
    self.descResult.textAlignment = NSTextAlignmentCenter;
    
    int score=[[self.addPapersInfresult valueForKey:@"exam_result"] intValue];
    if (score <= 60)
    { 
        self.descResult.text = @"要多学习哦!考试很简单嘀!";
    }
    else if (score > 60 && score < 90)
    {
        self.descResult.text = @"很棒哦!继续加油!";
    }
    else
    {
        self.descResult.text = @"恭喜您!取得了很好的成绩!";
    }
    [self.lvlResult setImage:[UIImage imageNamed:[self.addPapersInfresult valueForKey:@"result_lvl"]]];
    NSString *scorevalue = [NSString stringWithFormat:@"%d分",score];
    self.scoreResult.text = scorevalue;
    NSString *timevalue = [self.addPapersInfresult valueForKey:@"time"];
    self.timeResult.text = timevalue;
}

- (void) initSubPage{
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"考试结果";
//    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"查看答案" style:UIBarButtonItemStylePlain target:self action:@selector(checkAnswer)];
    [rightButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightButton];

    
}
- (void)checkAnswer{
    OnlineTestCheckAnswerViewController *vc = [[OnlineTestCheckAnswerViewController alloc] initWithNibName:@"OnlineTestCheckAnswerViewController" bundle:nil];
    vc.user = self.user;
    vc.testQuestionDetails = self.testQuestionDetails;
    vc.addPapersInfresult = self.addPapersInfresult;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBack{
    
    OnlineTestViewController *vc = [[OnlineTestViewController alloc] initWithNibName:@"OnlineTestViewController" bundle:nil];
    vc.user = self.user;
    [self.navigationController pushViewController:vc animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}

@end
