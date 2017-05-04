//
//  MXQTextEmoticonExample.m
//  YYDemo
//
//  Created by 深圳市泥巴装网络科技有限公司 on 2017/5/3.
//  Copyright © 2017年 马晓强. All rights reserved.
//

#import "MXQTextEmoticonExample.h"

@interface MXQTextEmoticonExample ()<YYTextViewDelegate>

@property (nonatomic, strong) YYTextView *textView;

@end

@implementation MXQTextEmoticonExample

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(setAutomaticTerminationSupportEnabled:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    mapper[@":smile:"] = [self imageWithName:@"002"];
    mapper[@":cool:"] = [self imageWithName:@"013"];
    mapper[@":biggrin:"] = [self imageWithName:@"047"];
    mapper[@"arrow"] = [self imageWithName:@"007"];
    mapper[@":confused:"] = [self imageWithName:@"041"];
    mapper[@":cry:"] = [self imageWithName:@"010"];
    mapper[@":wink:"] = [self imageWithName:@"085"];

    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    parser.emoticonMapper = mapper;
    
    YYTextLinePositionSimpleModifier *mod = [YYTextLinePositionSimpleModifier new];
    mod.fixedLineHeight = 22;
    
    YYTextView *textView = [YYTextView new];
    textView.text = @"Hahahah:smile:, it\'s emoticons::cool::arrow::cry::wink:\n\nYou can input \":\" + \"smile\" + \":\" to display smile emoticon, or you can copy and paste these emoticons.\n\nSee \'YYTextEmoticonExample.m\' for example.";
    textView.font = [UIFont systemFontOfSize:17];
    textView.textParser = parser;
    textView.size = self.view.size;
    textView.linePositionModifier = mod;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    textView.contentInset = UIEdgeInsetsMake((kiOS7Later?64:0), 0, 0, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
    [self.view addSubview:textView];
    
    self.textView = textView;
    [self.textView becomeFirstResponder];
    
}

-(UIImage *)imageWithName:(NSString *)name{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"EmoticonQQ" ofType:@"bundle"]];
    NSString *path = [bundle pathForScaledResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    YYImage *image = [YYImage imageWithData:data scale:2];
    image.preloadAllAnimatedImageFrames = YES;
    return image;
}


-(void)textViewDidBeginEditing:(YYTextView *)textView{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}
-(void)textViewDidEndEditing:(YYTextView *)textView{
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)edit:(UIBarButtonItem *)item{
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    }else{
        [_textView becomeFirstResponder];
    }
}


@end
