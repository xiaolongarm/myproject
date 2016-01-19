//
//  OnlineTestCheckAnswerViewController.m
//  CMCCMarketing
//
//  Created by Talkweb on 15/4/24.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "OnlineTestCheckAnswerViewController.h"
#import "OnlineTestResultViewController.h"
#import "OnlineTestViewController.h"

@interface OnlineTestCheckAnswerViewController ()
{
    int currentpage;
    UILabel *questionLabel;
    UILabel *answerLabelShow;
}
@end

@implementation OnlineTestCheckAnswerViewController
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
        [self downPageClick:nil];
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self upPageClick:nil];
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
    [self initSubPage];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSDictionary *key;
    
    if (self.fromMyDoWrong)
    {
        key = [key objectForKey:@"error_content"];
    }
    else{
        key = [self.testQuestionDetails objectAtIndex:0];
    }
    
    UIFont *fontOne = [UIFont systemFontOfSize:14];//设置字体大小
    NSString *titleOne = [NSString stringWithFormat:@"%@",[key objectForKey:@"question"]];//要显示的内容
    CGSize maximumLabelSizeOne = CGSizeMake(315,MAXFLOAT);//315为我需要的UILabel的长度
    CGSize expectedLabelSizeOne = [titleOne sizeWithFont:fontOne
                                       constrainedToSize:maximumLabelSizeOne
                                           lineBreakMode:NSLineBreakByWordWrapping];
    CGRect pointValueRect = CGRectMake(5, 20 ,315, expectedLabelSizeOne.height);
    
    questionLabel = [[UILabel alloc] initWithFrame:pointValueRect];
    questionLabel.text = titleOne;
    questionLabel.backgroundColor = [UIColor clearColor];
    questionLabel.textColor = [UIColor grayColor];
    questionLabel.textAlignment = NSTextAlignmentLeft;
    questionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    questionLabel.numberOfLines = 0;
    questionLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:questionLabel];
    questionLabel.hidden = YES;
    
    answerLabelShow = [[UILabel alloc] initWithFrame:CGRectMake(5 , 0 ,260, 50)];
    answerLabelShow.backgroundColor = [UIColor clearColor];
    answerLabelShow.textColor = [UIColor colorWithRed:255/255.0 green:100/255.0 blue:0/255.0 alpha:1.0];
    answerLabelShow.textAlignment = NSTextAlignmentLeft;
    answerLabelShow.lineBreakMode = NSLineBreakByWordWrapping;
    answerLabelShow.numberOfLines = 0;
    answerLabelShow.font = [UIFont systemFontOfSize:14];
    [self.viewAnswer addSubview:answerLabelShow];
    
    
    self.pageUpImage.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    [self performSelector:@selector(startLoad:) withObject:nil afterDelay:0];
    
    
    [self loadData:nil];
    
}


-(void)startLoad:(NSDictionary*)dict{
    
    self.labelPage.textAlignment = NSTextAlignmentCenter;
    self.labelPage.text = [NSString stringWithFormat:@"1/%d",[self.testQuestionDetails count]];
    currentpage = 1;
    [self showQuestion:currentpage - 1];
    
    [self showAnswer:currentpage - 1];
}


-(void)loadData:(NSString *)visit_sta{
    
}

- (IBAction)upPageClick:(id)sender {
    if ( currentpage > 1)
    {
        currentpage --;
        self.labelPage.text = [NSString stringWithFormat:@"%d/%d",currentpage,[self.testQuestionDetails count]];
        [self showQuestion:currentpage - 1];
        [self showAnswer:currentpage - 1];
    }
}

- (IBAction)downPageClick:(id)sender {
    if (currentpage < [self.testQuestionDetails count])
    {
        currentpage ++;
        self.labelPage.text = [NSString stringWithFormat:@"%d/%d",currentpage,[self.testQuestionDetails count]];
        [self showQuestion:currentpage - 1];
        [self showAnswer:currentpage - 1];
    }
}

- (void) initSubPage{
    
    if(IOS7)
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X64"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"320X44"] forBarMetrics:UIBarMetricsDefault];
    if (self.fromMyDoWrong)
    {
        self.navigationItem.title = @"我的错题";
    }
    else{
        self.navigationItem.title = @"查看答案";
    }
    
//    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回1"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//    [leftButton setTintColor:[UIColor whiteColor]];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
}

-(void)showQuestion:(int)page{
    NSDictionary *key;
    if (self.fromMyDoWrong)
    {
        
        NSString *temp = [[self.testQuestionDetails objectAtIndex:page] objectForKey:@"error_content"] ;
        NSData *tempdate = [temp    dataUsingEncoding : NSUTF8StringEncoding ];
        key = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:tempdate options:NSJSONReadingAllowFragments error:nil];
    }
    else{
        key = [self.testQuestionDetails objectAtIndex:page];
    }
    UIFont *fontOne = [UIFont systemFontOfSize:14];//设置字体大小
    NSString *titleOne = [NSString stringWithFormat:@"%@",[key objectForKey:@"question"]];//要显示的内容
    
    CGSize maximumLabelSizeOne = CGSizeMake(315,MAXFLOAT);//315为我需要的UILabel的长度
    CGSize expectedLabelSizeOne = [titleOne sizeWithFont:fontOne
                                       constrainedToSize:maximumLabelSizeOne
                                           lineBreakMode:NSLineBreakByWordWrapping]; //expectedLabelSizeOne.height 就是内容的高度
    
    //初始化UILabel
    CGRect pointValueRect = CGRectMake(5, 20 ,315, expectedLabelSizeOne.height + 40);
    
    questionLabel.frame  = pointValueRect;
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
    NSDictionary *key;
    if (self.fromMyDoWrong)
    {
        
        NSString *temp = [[self.testQuestionDetails objectAtIndex:page] objectForKey:@"error_content"] ;
        NSData *tempdate = [temp    dataUsingEncoding : NSUTF8StringEncoding ];
        key = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:tempdate options:NSJSONReadingAllowFragments error:nil];
    }
    else{
        key = [self.testQuestionDetails objectAtIndex:page];
    }
    int type = [[key objectForKey:@"question_type"]intValue];

    self.cutLine.frame = CGRectMake(self.cutLine.frame.origin.x, -3 + questionLabel.frame.origin.y + questionLabel.frame.size.height ,self.cutLine.frame.size.width, self.cutLine.frame.size.height);
    
    self.imageAnswerA.frame = CGRectMake(5, 20 + questionLabel.frame.origin.y + questionLabel.frame.size.height ,self.imageAnswerA.frame.size.width, self.imageAnswerA.frame.size.height);
    
    NSDictionary * chose = [key objectForKey:@"chose"];
    
    NSString *answer = [NSString stringWithFormat:@"答案:\n%@",[key objectForKey:@"answer"]];//[key objectForKey:@"answer"];

    NSString *answera = [chose objectForKey:@"A"];
    
    NSString *answerb = [chose objectForKey:@"B"];
    NSString *titleOneA = [NSString stringWithFormat:@"A、%@",answera];
    NSString *titleOneB = [NSString stringWithFormat:@"B、%@",answerb];
    CGSize maximumLabelSizeOne = CGSizeMake(260,MAXFLOAT);
    CGSize expectedLabelSizeOneA = [titleOneA sizeWithFont:[UIFont systemFontOfSize:14]
                                         constrainedToSize:maximumLabelSizeOne
                                             lineBreakMode:NSLineBreakByWordWrapping];
    CGSize expectedLabelSizeOneB = [titleOneB sizeWithFont:[UIFont systemFontOfSize:14]
                                         constrainedToSize:maximumLabelSizeOne
                                             lineBreakMode:NSLineBreakByWordWrapping];
    
    
    self.labelAnswerA.frame = CGRectMake(5 + self.imageAnswerA.frame.size.width, self.imageAnswerA.frame.origin.y - 17,260, expectedLabelSizeOneA.height + 40);
    self.labelAnswerA.text = titleOneA;
    self.imageAnswerB.frame = CGRectMake(5,  self.labelAnswerA.frame.origin.y + self.labelAnswerA.frame.size.height ,self.imageAnswerB.frame.size.width, self.imageAnswerB.frame.size.height);
    
    self.labelAnswerB.frame = CGRectMake(5 + self.imageAnswerB.frame.size.width, self.imageAnswerB.frame.origin.y - 17,260, expectedLabelSizeOneB.height + 40);
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
            CGSize expectedLabelSizeOneC = [titleOneC sizeWithFont:[UIFont systemFontOfSize:14]
                                                 constrainedToSize:maximumLabelSizeOne
                                                     lineBreakMode:NSLineBreakByWordWrapping];
            CGSize expectedLabelSizeOneD = [titleOneD sizeWithFont:[UIFont systemFontOfSize:14]
                                                 constrainedToSize:maximumLabelSizeOne
                                                     lineBreakMode:NSLineBreakByWordWrapping];
            self.imageAnswerC.frame = CGRectMake(5,  self.labelAnswerB.frame.origin.y + self.labelAnswerB.frame.size.height ,self.imageAnswerC.frame.size.width, self.imageAnswerC.frame.size.height);
            self.labelAnswerC.frame = CGRectMake(5 + self.imageAnswerC.frame.size.width, self.imageAnswerC.frame.origin.y - 17,260, expectedLabelSizeOneC.height + 40);
            //            questionLabel.lineBreakMode = UILineBreakModeWordWrap;
            self.labelAnswerC.text = titleOneC;
            
            self.imageAnswerD.frame = CGRectMake(5,  self.labelAnswerC.frame.origin.y + self.labelAnswerC.frame.size.height ,self.imageAnswerD.frame.size.width, self.imageAnswerD.frame.size.height);
            self.labelAnswerD.frame = CGRectMake(5 + self.imageAnswerD.frame.size.width, self.imageAnswerD.frame.origin.y - 17,260, expectedLabelSizeOneD.height + 40);
            self.labelAnswerD.text = titleOneD;
            self.viewAnswer.frame = CGRectMake(0, 5 + self.labelAnswerD.frame.origin.y + self.labelAnswerD.frame.size.height,320, 50);
            self.viewAnswer.backgroundColor = [UIColor colorWithRed:255/255.0 green:241/255.0 blue:186/255.0 alpha:1.0];
//            self.labelAnswer.frame = CGRectMake(5 , 0 ,260, 50);
            answerLabelShow.text = answer;
            
            break;
        }
        case 3:
            self.imageAnswerC.hidden = YES;
            self.imageAnswerD.hidden = YES;
            self.labelAnswerC.hidden = YES;
            self.labelAnswerD.hidden = YES;
            self.viewAnswer.frame = CGRectMake(0, 5 + self.labelAnswerB.frame.origin.y + self.labelAnswerB.frame.size.height,320, 50);
            self.viewAnswer.backgroundColor = [UIColor colorWithRed:255/255.0 green:241/255.0 blue:186/255.0 alpha:1.0];
//            self.labelAnswer.frame = CGRectMake(5 , 0 ,260, 50);
            answerLabelShow.text = answer;
            break;
            
        default:
            break;
    }
    questionLabel.hidden = NO;
    questionLabel.text = [NSString stringWithFormat:@"%@",[key objectForKey:@"question"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goBack{
//    if (self.fromMyDoWrong)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
//    else{
//        OnlineTestResultViewController *vc = [[OnlineTestResultViewController alloc] initWithNibName:@"OnlineTestResultViewController" bundle:nil];
//        vc.testQuestionDetails = self.testQuestionDetails;
//        vc.addPapersInfresult = self.addPapersInfresult;
//        vc.user = self.user;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

@end
