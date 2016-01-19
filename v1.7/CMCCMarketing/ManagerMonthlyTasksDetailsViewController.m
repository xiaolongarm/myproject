//
//  ManagerMonthlyTasksDetailsViewController.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-19.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "ManagerMonthlyTasksDetailsViewController.h"

@interface ManagerMonthlyTasksDetailsViewController ()

@end

@implementation ManagerMonthlyTasksDetailsViewController

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
    
    lbDate.text=self.date;
    lbRank.text=[NSString stringWithFormat:@"%d",[[self.detailsDict objectForKey:@"rank"] intValue]];
    lbName.text=[self.detailsDict objectForKey:@"name"];
    int totalNumber=[[self.detailsDict objectForKey:@"target"] intValue];
    int finishedNumber=[[self.detailsDict objectForKey:@"finish"] intValue];
    float percentage=totalNumber?(float)finishedNumber/totalNumber:0.0;
    NSString *unit=[self.detailsDict objectForKey:@"unit"];
    lbTaskCNT.text=[NSString stringWithFormat:@"%d %@",totalNumber,unit];
    lbFinishCNT.text=[NSString stringWithFormat:@"已完成%d%@",finishedNumber,unit];
    lbPercentage.text=[NSString stringWithFormat:@"%.f%%",percentage*100];
    [lbProgress setProgress:percentage];
    
    [self drawCalendar:[self.detailsDict objectForKey:@"detail"] unit:unit];
}
-(void)drawCalendar:(NSArray*)detailsArray unit:(NSString*)unit{
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy年MM月"];
    NSDate *dd=[dateformatter dateFromString:self.date];
    
    NSDateFormatter *dateformatter2=[[NSDateFormatter alloc] init];
    [dateformatter2 setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:dd];
    NSUInteger numberOfDaysInMonth = range.length;
    
    int w=calendarBodyView.frame.size.width/7;
    
    for (int i=0; i<numberOfDaysInMonth; i++) {
        UIView *cell=[[UIView alloc] init];
        int y=i/7;
        int x=i%7;
        cell.frame=CGRectMake(x*w, y*w, w, w);
//        NSLog(@"x:%d,y:%d",x,y);
        cell.layer.borderWidth=0.5;
        cell.layer.borderColor=[UIColor whiteColor].CGColor;
        cell.backgroundColor=[UIColor lightGrayColor];
        
        UILabel *lbDay=[[UILabel alloc] init];
        lbDay.frame=CGRectMake(0, 0, w, w/2);
        lbDay.text=[NSString stringWithFormat:@"%d",i+1];
        lbDay.textColor=[UIColor whiteColor];
        lbDay.textAlignment=NSTextAlignmentCenter;
        lbDay.font=[UIFont systemFontOfSize:14];
        
        
        UILabel *lbCNT=[[UILabel alloc] init];
        lbCNT.frame=CGRectMake(0, w/2, w, w/2);
        
        lbCNT.text=[NSString stringWithFormat:@"%d%@",0,unit];
        for (NSDictionary *item in detailsArray) {
            NSString *dealDateString=[item objectForKey:@"dealDate"];
            NSDate *dealDate=[dateformatter2 dateFromString:dealDateString];
            NSDateComponents *comps=[[NSDateComponents alloc] init];
            comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dealDate];
//            NSLog(@"%d",[comps day]);
            if([comps day] == i+1)
                lbCNT.text=[NSString stringWithFormat:@"%d%@",[comps day],unit];
            
        }
        
        lbCNT.textColor=[UIColor colorWithRed:178.0f/255 green:232.0f/255 blue:255.0f/255 alpha:1];
//        lbCNT.textColor=[UIColor colorWithRed:193.0f/255 green:236.0f/255 blue:254.0f/255 alpha:1];
//        lbCNT.textColor=[UIColor colorWithRed:209.0f/255 green:241.0f/255 blue:254.0f/255 alpha:1];
        lbCNT.textAlignment=NSTextAlignmentCenter;
        lbCNT.font=[UIFont systemFontOfSize:12];
        
        [cell addSubview:lbDay];
        [cell addSubview:lbCNT];
        
        [calendarBodyView addSubview:cell];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
