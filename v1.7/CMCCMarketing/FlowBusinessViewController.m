//
//  FlowBusinessViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-9-15.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//
#import "FlowBusinessTableViewCell.h"
#import "FlowBusinessViewController.h"
#import "NetworkHandling.h"
#import "BusinessHandling.h"
#import "FlowBusinessProcessViewController.h"
#import "FlowBusinessRecordViewController.h"
#import "FlowBusinessSendBoxViewController.h"

@interface FlowBusinessViewController (){
    int flowBusinessButtonSelected;
    
    NSArray *flowArrayWithMonthly;
    NSArray *flowArrayWith4G;
    NSArray *flowArrayWithHalfOfYear;
    NSArray *flowArrayWithPackYear;
    
    FlowBusinessTableViewCell *selectedCell;
}

@end

@implementation FlowBusinessViewController

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
    flowBusinessTableView.delegate=self;
    flowBusinessTableView.dataSource=self;
    flowBusinessButtonSelected=0;
    
    [BusinessHandling getFlowBizData:^(NSArray *recommendArray, NSArray *moreArray, NSArray *monthArray, NSArray *fourgArray, NSArray *halfyearArray, NSArray *yearArray, NSError *error) {
        flowArrayWithMonthly=monthArray;
        flowArrayWith4G=fourgArray;
        flowArrayWithHalfOfYear=halfyearArray;
        flowArrayWithPackYear=yearArray;
    }];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"发件箱" style:UIBarButtonItemStylePlain target:self action:@selector(goSendBox)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
}
-(void)goSendBox{
    [self performSegueWithIdentifier:@"flowBusinessSendBoxSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"FlowBusinessProcessSegue"]){
        FlowBusinessProcessViewController *controller=segue.destinationViewController;
        controller.flowName=selectedCell.itemName.text;
        controller.flowDesc=selectedCell.itemMemo.text;
        controller.flowPrice=selectedCell.itemFee.text;
        
        controller.user=self.user;
    }
    if([segue.identifier isEqualToString:@"FlowBusinessRecordSegue"]){
        FlowBusinessRecordViewController *recordViewController=segue.destinationViewController;
        recordViewController.user=self.user;
    }
    if([segue.identifier isEqualToString:@"flowBusinessSendBoxSegue"]){
        FlowBusinessSendBoxViewController *sendBoxViewController=segue.destinationViewController;
        sendBoxViewController.user=self.user;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int i=0;
    switch (flowBusinessButtonSelected) {
        case 0:
            i=(int)[flowArrayWithMonthly count];
            break;
        case 1:
            i=(int)[flowArrayWith4G count];
            break;
        case 2:
            i=(int)[flowArrayWithHalfOfYear count];
            break;
        case 3:
            i=(int)[flowArrayWithPackYear count];
            break;
        default:
            break;
    }
    return i;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FlowBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlowBusinessTableViewCell"];
    
    NSDictionary *item;
    switch (flowBusinessButtonSelected) {
        case 0:
            item=[flowArrayWithMonthly objectAtIndex:indexPath.row];
            break;
        case 1:
            item=[flowArrayWith4G objectAtIndex:indexPath.row];
            break;
        case 2:
            item=[flowArrayWithHalfOfYear objectAtIndex:indexPath.row];
            break;
        case 3:
            item=[flowArrayWithPackYear objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    cell.itemName.text=[item objectForKey:@"name"];
    cell.itemFee.text=[item objectForKey:@"price"];
    cell.itemMemo.text=[item objectForKey:@"flow"];
    cell.itemSelected.tag=0;
    [cell.itemSelected setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedCell){
        [selectedCell.itemSelected setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
    }
    
    selectedCell=(FlowBusinessTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [selectedCell.itemSelected setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
}

- (IBAction)flowBusinessMonthlyButtonOnclick:(id)sender {
    [flowBusinessMonthlyButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [flowBusiness4GButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [flowBusinessHalfOfYearButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [flowBusinessPackYearsButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    flowBusinessButtonSelected=0;
    [flowBusinessTableView reloadData];
}
- (IBAction)flowBusiness4GButtonOnclick:(id)sender {
    [flowBusinessMonthlyButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [flowBusiness4GButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [flowBusinessHalfOfYearButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [flowBusinessPackYearsButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    flowBusinessButtonSelected=1;
    [flowBusinessTableView reloadData];
}
- (IBAction)flowBusinessHalfOfYearButtonOnclick:(id)sender {
    [flowBusinessMonthlyButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [flowBusiness4GButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [flowBusinessHalfOfYearButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    [flowBusinessPackYearsButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    
    flowBusinessButtonSelected=2;
    [flowBusinessTableView reloadData];
}
- (IBAction)flowBusinessPackYearsButtonOnclick:(id)sender {
    [flowBusinessMonthlyButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [flowBusiness4GButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [flowBusinessHalfOfYearButton setBackgroundImage:[UIImage imageNamed:@"按钮框（无）"] forState:UIControlStateNormal];
    [flowBusinessPackYearsButton setBackgroundImage:[UIImage imageNamed:@"按钮带框"] forState:UIControlStateNormal];
    
    flowBusinessButtonSelected=3;
    [flowBusinessTableView reloadData];
}
- (IBAction)goBusinessRecord:(id)sender {
    [self performSegueWithIdentifier:@"FlowBusinessRecordSegue" sender:self];
}


@end
