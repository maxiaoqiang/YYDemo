//
//  MXQTextTagExample.m
//  YYDemo
//
//  Created by 深圳市泥巴装网络科技有限公司 on 2017/4/26.
//  Copyright © 2017年 马晓强. All rights reserved.
//

#import "MXQTextTagExample.h"

@interface MXQTextTagExample ()<YYTextViewDelegate>
@property (nonatomic, strong) YYTextView *textView;
@end

@implementation MXQTextTagExample

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    NSArray *tags =@[@"◉red",@"◉orange",@"◉yellow",@"◉green",@"◉blue",@"◉purple"    ,@"◉gray"];
    NSArray *tagStrokeColors = @[
                                UIColorHex(fa3f39),
                                UIColorHex(f48f25),
                                UIColorHex(f1c02c),
                                UIColorHex(54bc2a),
                                UIColorHex(29a9ee),
                                UIColorHex(c171d8),
                                UIColorHex(818e91)
                                ];
    NSArray *tagFillColors = @[
                               UIColorHex(fb6560),
                               UIColorHex(fba550),
                               UIColorHex(f3cc56),
                               UIColorHex(76c957),
                               UIColorHex(53baf1),
                               UIColorHex(cd8ddf),
                               UIColorHex(a4a4a7)
                               ];
    
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    for (int i = 0; i<tags.count; i++) {
        NSString *tag = tags[i];
        UIColor *tagStrokeColor = tagStrokeColors[i];
        UIColor *tagFillColor = tagFillColors[i];
        NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString:tag];
        [tagText insertString:@"   " atIndex:0];
        [tagText appendString:@"   "];
        tagText.font = font;
        tagText.color = [UIColor whiteColor];
        [tagText setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:tagText.rangeOfAll];
        
        YYTextBorder *border = [YYTextBorder new];
        border.strokeWidth = 1.5;
        border.strokeColor = tagStrokeColor;
        border.fillColor = tagFillColor;
        border.cornerRadius = 100;
        border.insets = UIEdgeInsetsMake(-2, -5.5, -2, -8);
        [tagText setTextBackgroundBorder:border range:[tagText.string rangeOfString:tag]];
        [text appendAttributedString:tagText];
    }
    text.lineSpacing = 10;
    text.lineBreakMode = NSLineBreakByWordWrapping;
    
    [text appendString:@"\n"];
    [text appendAttributedString:text];
    
    
    YYTextView *textView = [YYTextView new];
    textView.attributedText = text;
    textView.size = self.view.size;
    textView.textContainerInset = UIEdgeInsetsMake(10+(kiOS7Later?64:0), 10, 10, 10);
    textView.allowsCopyAttributedString = YES;
    textView.allowsPasteAttributedString = YES;
    textView.delegate = self;
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }else{
        textView.height -=64;
    }
    textView.scrollIndicatorInsets = textView.contentInset;
    textView.selectedRange = NSMakeRange(text.length, 0);
    [self.view addSubview:textView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [textView becomeFirstResponder];
    });
    
}

-(void)edit:(UIBarButtonItem *)item{
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    }else{
        [_textView becomeFirstResponder];
    }
}

-(void)textViewDidBeginEditing:(YYTextView *)textView{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

-(void)textViewDidEndEditing:(YYTextView *)textView{
    self.navigationItem.rightBarButtonItem = nil;
}








@end
