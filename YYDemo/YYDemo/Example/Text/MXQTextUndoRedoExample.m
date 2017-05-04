//
//  MXQTextUndoRedoExample.m
//  YYDemo
//
//  Created by 深圳市泥巴装网络科技有限公司 on 2017/5/4.
//  Copyright © 2017年 马晓强. All rights reserved.
//

#import "MXQTextUndoRedoExample.h"

@interface MXQTextUndoRedoExample ()<YYTextViewDelegate>

@property (nonatomic, strong) YYTextView *textView;


@end

@implementation MXQTextUndoRedoExample

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    NSString *text = @"You can shake the device to undo or redo";
    YYTextView *textView = [YYTextView new];
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:17];
    textView.size = self.view.size;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    textView.allowsUndoAndRedo = YES;
    textView.maximumUndoLevel = 10;
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    textView.contentInset = UIEdgeInsetsMake((kiOS7Later?64:0), 0, 0, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
    [self.view addSubview:textView];
    self.textView = textView;
    
    textView.selectedRange = NSMakeRange(text.length, 0);
    [textView becomeFirstResponder];
}


-(void)textViewDidBeginEditing:(YYTextView *)textView{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

-(void)edit:(UIBarButtonItem *)item{
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    }else{
        [_textView becomeFirstResponder];
    }
}

-(void)textViewDidEndEditing:(YYTextView *)textView{
    self.navigationItem.rightBarButtonItem = nil;
}





@end
