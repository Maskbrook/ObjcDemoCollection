//
//  CATextLayerDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/15.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CATextLayerDemoController.h"
#import <CoreText/CoreText.h>
#import "TextLayerLabel.h"

@interface CATextLayerDemoController ()

@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UIView *richTextView;

@end

@implementation CATextLayerDemoController
{
    TextLayerLabel *layerLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTextLayer];
    [self setupTextLayerLabel];
    [self setupRichTextView];
}

#pragma mark - private methods
// test CATextLayer
- (void)setupTextLayer
{
    self.labelView = [[UIView alloc] init];
    self.labelView.frame = CGRectMake(50, 100, 200, 140);
    self.labelView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.labelView];
    
    // step 1: create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:textLayer];
    
    // step 2: set text attributes
    textLayer.foregroundColor = [UIColor redColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.wrapped = YES;
    
    // step 3: set font
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    // step 4: set layer text
    NSString *text = @"hxkahsdljqwsdj;xlsk;lxkas;'skqoiq    lkwklwda'sl sqlj";
    textLayer.string = text;
    
    // 以retina方式渲染，解决像素化问题
    textLayer.contentsScale = [UIScreen mainScreen].scale;
}

// test TextLayerLabel
- (void)setupTextLayerLabel
{
    layerLabel = [[TextLayerLabel alloc] initWithFrame:CGRectMake(100, 260, 100, 40)];
    layerLabel.text = @"哈哈啊";
    layerLabel.textColor = [UIColor redColor];
    layerLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:layerLabel];
}

//
- (void)setupRichTextView
{
    // rich text view
    self.richTextView = [[UIView alloc] initWithFrame:CGRectMake(50, 320, 220, 180)];
    self.richTextView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.richTextView];
    
    // setup textlayer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.richTextView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.richTextView.layer addSublayer:textLayer];
    
    // setup text attributes
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //choose some text
    NSString *text = @" 豫章故郡，洪都新府。星分翼轸，地接衡庐。襟三江而带五湖，控蛮荆而引瓯越。物华天宝，龙光射牛斗之墟；人杰地灵，徐孺下陈蕃之榻。雄州雾列，俊采星驰。";
    
    // create attributed string
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    
    //convert UIFont to a CTFont
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    //set text attributes
    NSDictionary *attrs = @{
                            (__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor magentaColor].CGColor,
                            (__bridge id)kCTFontAttributeName: (__bridge id)fontRef,
                            };
    
    [string setAttributes:attrs range:NSMakeRange(0, [text length])];
    
    attrs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor blackColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attrs range:NSMakeRange(6, 5)];
    
    //release the CTFont we created earlier
    CFRelease(fontRef);
    
    //set layer text
    textLayer.string = string;
}

@end
