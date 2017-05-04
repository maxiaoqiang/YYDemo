//
//  MXQTextAttachmentExample.m
//  YYDemo
//
//  Created by 深圳市泥巴装网络科技有限公司 on 2017/4/26.
//  Copyright © 2017年 马晓强. All rights reserved.
//

#import "MXQTextAttachmentExample.h"

@interface MXQTextAttachmentExample ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) YYLabel *label;

@end

@implementation MXQTextAttachmentExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    UIFont *font = [UIFont systemFontOfSize:16];
    
    {
        NSString *title = @"This is UIImage attachment";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
        UIImage *image = [UIImage imageNamed:@"dribbble64_imageio"];
        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString  attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    
        [text appendAttributedString:attachText];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    {
        NSString *title = @"This is Uiview attachment";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
        UISwitch *switcher = [UISwitch new];
        [switcher sizeToFit];
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:switcher contentMode:UIViewContentModeCenter attachmentSize:switcher.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    {
        NSString *title = @"This is Animated Image attachment:";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
        
        NSArray *names = @[@"001",@"022",@"019",@"056",@"085"];
        for (NSString *name in names) {
            NSString *path = [[NSBundle mainBundle]pathForScaledResource:name ofType:@"gif" inDirectory:@"EmoticonQQ.bundle"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            YYImage *image = [YYImage imageWithData:data scale:2];
            image.preloadAllAnimatedImageFrames = YES;
            YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
            
            NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text appendAttributedString:attachText];
            
        }
        YYImage *image = [YYImage imageNamed:@"wall-e.webp"];
        image.preloadAllAnimatedImageFrames = YES;
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        imageView.autoPlayAnimatedImage = NO;
        [imageView startAnimating];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentBottom];
        [text appendAttributedString:attachText];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    text.font = font;
    
    _label = [YYLabel new];
    _label.userInteractionEnabled = YES;
    _label.numberOfLines = 0;
    _label.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _label.size = CGSizeMake(260, 260);
    _label.center = CGPointMake(self.view.width *0.5, self.view.height*0.5-(kiOS7Later?0:32));
    _label.attributedText = text;
    [self addSeeMoreButton];
    [self.view addSubview:_label];
    _label.layer.borderWidth = CGFloatToPixel(1);
    _label.layer.borderColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:1.000].CGColor;
    
    __weak typeof(_label) wlabel = _label;
    UIView *dot = [self newDotView];
    dot.center = CGPointMake(_label.width, _label.height);
    dot.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    [_label addSubview:dot];
    
    
    YYGestureRecognizer *gesture = [YYGestureRecognizer new];
    gesture.action = ^(YYGestureRecognizer * _Nonnull gesture, YYGestureRecognizerState state) {
        if (state != YYGestureRecognizerStateMoved) return ;
        CGFloat width = gesture.currentPoint.x;
        CGFloat height = gesture.currentPoint.y;
        wlabel.width = width <30?30:width;
        wlabel.height = height<30?30:height;
    };
    gesture.delegate = self;
    [_label addGestureRecognizer:gesture];
    
    
    
    
}

-(void)addSeeMoreButton{
    __weak typeof(self) _self = self;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...more"];
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
    hi.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        YYLabel *label = _self.label;
        [label sizeToFit];
    };
    
    [text setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000] range:[text.string rangeOfString:@"more"]];
    [text setTextHighlight:hi range:[text.string rangeOfString:@"more"]];
    text.font = _label.font;
    
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.size alignToFont:text.font alignment:YYTextVerticalAlignmentCenter];
    _label.truncationToken = truncationToken;
    
}

-(UIView *)newDotView{
    UIView *view = [UIView new];
    view.size = CGSizeMake(50, 50);
    UIView *dot = [UIView new];
    dot.size = CGSizeMake(10, 10);
    dot.backgroundColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:1.000];
    dot.clipsToBounds = YES;
    dot.layer.cornerRadius = dot.height *0.5;
    dot.center = CGPointMake(view.width *0.5, view.height*0.5);
    [view addSubview:dot];
    return view;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint p = [gestureRecognizer locationInView:_label];
    if (p.x < _label.width -20) return NO;
    if (p.y < _label.height - 20) return NO;
    return YES;
}








@end
