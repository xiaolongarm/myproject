//
//  KeyboardHanding.h
//  CMCCMarketing
//
//  Created by talkweb on 15-4-30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BAR_HIGHT 35

@protocol KeyboardHandingDelegate <NSObject>
-(void)keyboardHandingDidLoad:(CGSize)size;
-(void)keyboardHandingUnload:(CGSize)size;
@end

@interface KeyboardHanding : NSObject{
    BOOL isShow;
    UIView *controlView;
    id textControl;
    UIView *adjustView;
    
    CGFloat adjustHeight;
}
/** 初始化键盘侦听
 * control 编辑控件
 * view 调整的视图
 */
-(id)initWithTextControl:(id)control adjustView:(UIView*)view;
@property(nonatomic,strong)id<KeyboardHandingDelegate> delegate;
@end
