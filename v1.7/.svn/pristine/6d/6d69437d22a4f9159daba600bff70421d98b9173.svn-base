//
//  SignViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-4.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "SignMapViewController.h"
#import "SignViewController.h"

@interface SignViewController ()

@end

@implementation SignViewController

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
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBar *navBar=[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    UINavigationItem *navItem=[[UINavigationItem alloc] initWithTitle:@"考勤打卡"];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    [navItem setLeftBarButtonItem:leftButton];
    [navBar pushNavigationItem:navItem animated:NO];
    
    if(IOS7)
        [navBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [navBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    [self.view addSubview:navBar];
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [navBar setTitleTextAttributes:dict];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
}
-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SignMapViewController *controller=segue.destinationViewController;
    controller.user=self.user;
    if([segue.identifier isEqualToString:@"signInMapSegue"]){
        controller.isSignIn=YES;
    }
    if([segue.identifier isEqualToString:@"signOutMapSegue"]){
        controller.isSignIn=NO;
    }
}


@end
