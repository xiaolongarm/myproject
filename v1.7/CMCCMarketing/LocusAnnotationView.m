//
//  LocusAnnotationView.m
//  CMCCMarketing
//
//  Created by talkweb on 14-12-24.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "LocusAnnotationView.h"
#import "LocusAnnotation.h"
@implementation LocusAnnotationView

@synthesize annotationImageView = _annotationImageView;
//@synthesize annotationLabel = _annotationLabel;

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        //        [self setBounds:CGRectMake(0.f, 0.f, 30.f, 30.f)];
        [self setBounds:CGRectMake(0.f, 0.f, 25.f, 25.f)];
        
        [self setBackgroundColor:[UIColor clearColor]];
        LocusAnnotation *anno=annotation;
        

        _annotationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, 25.f)];

        _annotationImageView.contentMode = UIViewContentModeScaleToFill;
        //        [self addSubview:_annotationImageView];
        
        
        if(anno.isBegin)
            _annotationLabel=[[UILabel alloc] initWithFrame:CGRectMake(25.f, 0.f, 50.f, 20.f)];
        else
            _annotationLabel=[[UILabel alloc] initWithFrame:CGRectMake(-50.f, 0.f, 50.f, 20.f)];
        //        label.text=@"张鲍勃";
        _annotationLabel.font=[UIFont systemFontOfSize:12];
        _annotationLabel.backgroundColor=[UIColor clearColor];
        _annotationLabel.textColor=[UIColor blueColor];
        _annotationLabel.textAlignment=NSTextAlignmentCenter;
        
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
