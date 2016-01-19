//
//  SignInAnnotationView.m
//  CMCCMarketing
//
//  Created by kevin on 15/6/26.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "SignInAnnotationView.h"

@implementation SignInAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        //        [self setBounds:CGRectMake(0.f, 0.f, 30.f, 30.f)];
        [self setBounds:CGRectMake(0.f, 0.f, 70.f, 25.f)];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _signinAnnotationImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, 25.f)];
        _signinAnnotationImage.contentMode = UIViewContentModeScaleToFill;
        //        [self addSubview:_annotationImageView];
        
        _signinAnnotationLabel=[[UILabel alloc] initWithFrame:CGRectMake(10.f, -25.f, 70.f, 20.f)];
        //        label.text=@"张鲍勃";
        _signinAnnotationLabel.font=[UIFont systemFontOfSize:12];
        _signinAnnotationLabel.backgroundColor=[UIColor darkGrayColor];
        _signinAnnotationLabel.textColor=[UIColor whiteColor];
        _signinAnnotationLabel.textAlignment=NSTextAlignmentCenter;
        _signinAnnotationLabel.adjustsFontSizeToFitWidth=YES;
        _signinAnnotationLabel.layer.cornerRadius=2;
        _signinAnnotationLabel.layer.masksToBounds=YES;
        
        [self addSubview:_signinAnnotationLabel];
        [self addSubview:_signinAnnotationImage];
        
    }
    return self;
}


@end
