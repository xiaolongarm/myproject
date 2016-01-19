//
//  SignAnnotationView.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "SignAnnotationView.h"

@implementation SignAnnotationView

@synthesize annotationImageView = _annotationImageView;
@synthesize annotationLabel = _annotationLabel;

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        //        [self setBounds:CGRectMake(0.f, 0.f, 30.f, 30.f)];
        [self setBounds:CGRectMake(0.f, 0.f, 70.f, 25.f)];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _annotationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, 25.f)];
        _annotationImageView.contentMode = UIViewContentModeScaleToFill;
        //        [self addSubview:_annotationImageView];
        
        _annotationLabel=[[UILabel alloc] initWithFrame:CGRectMake(25.f, 0.f, 70.f, 20.f)];
//        label.text=@"张鲍勃";
        _annotationLabel.font=[UIFont systemFontOfSize:12];
        _annotationLabel.backgroundColor=[UIColor darkGrayColor];
        _annotationLabel.textColor=[UIColor whiteColor];
        _annotationLabel.textAlignment=NSTextAlignmentCenter;
        _annotationLabel.adjustsFontSizeToFitWidth=YES;
        _annotationLabel.layer.cornerRadius=2;
        _annotationLabel.layer.masksToBounds=YES;
        
        [self addSubview:_annotationLabel];
        [self addSubview:_annotationImageView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
