//
//  VisitPlanManageTableViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "VisitPlanManageTableViewCell.h"
#import "VisitPlanManageTableViewController.h"

@interface VisitPlanManageTableViewController (){
    NSArray *tableArray;
}

@end

@implementation VisitPlanManageTableViewController

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
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"失访" style:UIBarButtonItemStylePlain target:self action:@selector(failureVisit)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    tableArray=[[NSArray alloc] initWithObjects:@"到达签到",@"拜访总结",@"离开签退", nil];
    
    
}
-(void)failureVisit{
    [self performSegueWithIdentifier:@"VisistPlanfailureSegue" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    VisitPlanManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitPlanManageTableViewCell" forIndexPath:indexPath];
    cell.itemName.text=[tableArray objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
        [self performSegueWithIdentifier:@"VisitPlanSignSegue" sender:self];
    if(indexPath.row == 1)
        [self failureVisit];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
