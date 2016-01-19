

#import "KeyboardHanding.h"

@implementation KeyboardHanding

-(id)initWithTextControl:(id)control adjustView:(UIView*)view{
    self = [super init];
    if (self) {
        textControl=control;
        adjustView = view;
        [self registerForKeyboardNotifications];
    }
    return self;
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillShow:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    

}
-(void)dealloc{
    if(controlView){
        [controlView removeFromSuperview];
        controlView=nil;
    }
    [self unRegisterForKeyboardNotifications];
}
-(void)unRegisterForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardWillShow:(NSNotification *)note {
    CGSize screenSize=[[UIScreen mainScreen] bounds].size;
    NSDictionary* info = [note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if(isShow){
//        CGRect rect = controlView.frame;
//        rect.origin.y = screenSize.height - kbSize.height - BAR_HIGHT;
//        controlView.frame =rect;
        return;
    }
    

    controlView=[[UIView alloc] init];
    controlView.frame = CGRectMake(0, screenSize.height - kbSize.height -  BAR_HIGHT, screenSize.width, BAR_HIGHT);
    controlView.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(screenSize.width - 106, 0, 106, BAR_HIGHT);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor darkGrayColor]];
    [doneButton addTarget:self action:@selector(doneButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:doneButton];
    
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView *keyboard;
    for(int i = 0; i < [tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        
        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) || ([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES) || ([[keyboard description] hasPrefix:@"<UIInputSetContainerView"] == YES)){
            [keyboard addSubview:controlView];
            isShow=YES;
        }
    }
    if(@selector(keyboardWillShow:))
    if(self.delegate)
        [self.delegate keyboardHandingDidLoad:kbSize];
    [self adjustViewWithkeyboardWillShow:kbRect];
    
}
-(void)adjustViewWithkeyboardWillShow:(CGRect)keyboardRect{
    if(!adjustView)
        return;
    

    isShow=YES;
    UIView *textView=textControl;

    CGRect textRect = [adjustView convertRect:textView.frame fromView:adjustView];
    CGRect kbRect = [adjustView convertRect:keyboardRect fromView:adjustView];
//    CGRect kbRect = [keyboard convertRect:keyboardRect toView:view];
    
    adjustHeight = kbRect.origin.y - textRect.origin.y + textRect.size.height;
    if(adjustHeight > 0){
        CGRect rect = adjustView.frame;
        rect.origin.y -= adjustHeight;
        adjustView.frame = rect;
    }
    
////    CGSize screenSize=[[UIScreen mainScreen] bounds].size;
////    CGRect txtRect = ((UIView*)textControl).frame;
////    
////    CGFloat h = screenSize.height - txtRect.origin.y - txtRect.size.height;
////    if(h > size.height)
////        return;
//    
//    CGRect rect = adjustView.frame;
////    rect.origin.y = h - size.height;
//    rect.origin.y -= size.height;
//    adjustView.frame = rect;
}
-(void)adjustViewWithkeyboardWillHidden:(CGRect)keyboardRect{
    if(!adjustView)
        return;
    
    isShow=NO;
//    UIView *textView=textControl;
//    
//    CGRect textRect = [adjustView convertRect:textView.frame fromView:adjustView];
//    CGRect kbRect = [adjustView convertRect:keyboardRect fromView:adjustView];
//    
//    CGRect aaRect =adjustView.frame;
//    
//    //    CGRect kbRect = [keyboard convertRect:keyboardRect toView:view];
//    
//    CGFloat height = kbRect.origin.y - BAR_HIGHT - (textRect.origin.y + textRect.size.height);
//    if(height > 0){
//        CGRect rect = adjustView.frame;
//        rect.origin.y -= height;
//        adjustView.frame = rect;
//    }
    if(adjustHeight > 0){
        CGRect rect = adjustView.frame;
        rect.origin.y += adjustHeight;
        adjustView.frame = rect;
    }
    adjustHeight=0;
////    CGSize screenSize=[[UIScreen mainScreen] bounds].size;
////    CGRect txtRect = ((UIView*)textControl).frame;
////    CGFloat h = screenSize.height - txtRect.origin.y - txtRect.size.height;
////    if(h > size.height)
////        return;
//    
//    CGRect rect = adjustView.frame;
////    rect.origin.y = size.height - h;
//    rect.origin.y += size.height;
//    
//    adjustView.frame = rect;
    
}
//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)note
{
    NSDictionary* info = [note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if(self.delegate)
        [self.delegate keyboardHandingUnload:kbSize];
    [self adjustViewWithkeyboardWillHidden:kbRect];
}
- (void)doneButtonOnclick:(id)sender {
    [textControl resignFirstResponder];
    [controlView removeFromSuperview];
    controlView=nil;
    isShow=NO;
}

@end
