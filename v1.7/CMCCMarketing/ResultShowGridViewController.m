//
//  ResultShowGridViewController.m
//  CMCCMarketing
//
//  Created by Talkweb on 15/5/4.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "ResultShowGridViewController.h"
#import "DataGridComponent.h"

@interface ResultShowGridViewController ()

@end

@implementation ResultShowGridViewController

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
}


- (void) initSubPage{
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"营销经理成绩通报";
//    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//    [leftButton setTintColor:[UIColor whiteColor]];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSMutableArray *data[[self.resultList count]];
    for (int i = 0; i < [self.resultList count]; i++) {
        data[i] = [[NSMutableArray alloc] init];
    }
    for (int i = 0; i < [self.resultList count]; i++) {
        NSDictionary *dicObj = [self.resultList objectAtIndex:i];
        [data[i] addObject:[dicObj objectForKey:@"user_name"]];
        [data[i] addObject:[dicObj objectForKey:@"cnty_name"]];
        [data[i] addObject:[dicObj objectForKey:@"position"]];
        [data[i] addObject:[dicObj objectForKey:@"exam_result"]];
        [data[i] addObject:[dicObj objectForKey:@"result_lvl"]];
        [data[i] addObject:[NSString stringWithFormat:@"%@",[dicObj objectForKey:@"rank"]]];
    }
    
    DataGridComponentDataSource *ds = [[DataGridComponentDataSource alloc] init];
	ds.data = [[NSMutableArray alloc] init];
	ds.columnWidth = [NSMutableArray arrayWithObjects:@"70",@"100",@"50",@"50",@"50",@"50",nil];
	ds.titles = [NSMutableArray arrayWithObjects:@"姓名",@"县市",@"岗位",@"成绩",@"等级",@"排名",nil];
    for (int i = 0; i < [self.resultList count]; i++) {
        [ds.data addObject:data[i]];
    }
	DataGridComponent *grid = [[DataGridComponent alloc] initWithFrame:CGRectMake(0, 0, 320, 504) data:ds];
	[self.view addSubview:grid];
    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    NSLog(@"%f %f",viewWidth,viewHeight);

}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
