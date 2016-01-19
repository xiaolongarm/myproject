//
//  WorkRecordAddViewController.h
//  CMCCMarketing
//
//  Created by gmj on 15-1-26.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"
#import "PlaceholderTextView.h"
@interface WorkRecordAddViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)User *user;

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;
- (IBAction)btnDateOnClick:(id)sender;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *txtViewContent;

@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
- (IBAction)btnCameraOnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
//允许上传3张图片。

- (IBAction)btnAddWorkRecordOnClick:(id)sender;

@property(nonatomic,strong)NSDictionary *selectedWorkRecord;
@property(nonatomic,strong)UIImage *uploadImage1;
@property(nonatomic,strong)UIImage *uploadImage2;
@property(nonatomic,strong)UIImage *uploadImage3;

@property(nonatomic,strong)NSArray *timesArray;

@end
