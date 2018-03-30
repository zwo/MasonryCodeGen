//
//  ViewController.m
//  MasonryCodeGen
//
//  Created by 周维鸥 on 2018/3/29.
//  Copyright © 2018年 周维鸥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak) IBOutlet NSTextField *txtFldEdgeInset;
@property (weak) IBOutlet NSTextField *txtFldTopTRBL;
@property (weak) IBOutlet NSTextField *txtFldTopTRBLValue;
@property (weak) IBOutlet NSTextField *txtFldRightTRBL;
@property (weak) IBOutlet NSTextField *txtFldRightTRBLValue;
@property (weak) IBOutlet NSTextField *txtFldBottomTRBL;
@property (weak) IBOutlet NSTextField *txtFldBottomTRBLValue;
@property (weak) IBOutlet NSTextField *txtFldLeftTRBL;
@property (weak) IBOutlet NSTextField *txtFldLeftTRBLValue;
@property (weak) IBOutlet NSTextField *txtFldCenterXValue;
@property (weak) IBOutlet NSTextField *txtFldCenterYValue;
@property (weak) IBOutlet NSTextField *txtFldTopAbsoluteValue;
@property (weak) IBOutlet NSTextField *txtFldLeftAbsoluteValue;
@property (weak) IBOutlet NSTextField *txtFldWidthAbsoluteValue;
@property (weak) IBOutlet NSTextField *txtFldHeightAbsoluteValue;
@property (weak) IBOutlet NSTextField *txtFldWidthRelativeValue;
@property (weak) IBOutlet NSTextField *txtFldHeightRelativeValue;
@property (weak) IBOutlet NSTextField *txtFldComment;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onButtonGenerate:) name:@"Masonry_Code_Gen" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clear) name:@"Masonry_Code_Clear" object:nil];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)onButtonGenerate:(id)sender
{
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:8];
    
    if ([self.txtFldComment.stringValue length]) {
        [array addObject:[NSString stringWithFormat:@"// %@\n",self.txtFldComment.stringValue]];
    }
    
    [array addObject:@"[<#self.#> mas_makeConstraints:^(MASConstraintMaker *make) {\n"];
    
    if ([self.txtFldEdgeInset.stringValue length]) {
        NSString *tmp=self.txtFldEdgeInset.stringValue;
        if ([tmp isEqualToString:@"0 0 0 0"]) {
            [array addObject:@"    make.edges.equalTo(<#self.#>);\n"];
        }else{
            NSArray *comp=[tmp componentsSeparatedByString:@" "];
            if ([comp count] != 4) {
                [self errorWithString:tmp];
                return;
            }
            NSString *newStr=[comp componentsJoinedByString:@" ,"];
            [array addObject:[NSString stringWithFormat:@"    make.edges.equalTo(<#self.#>).insets(UIEdgeInsetsMake(%@));\n",newStr]];
        }
    }
    
    NSDictionary *trblDict=@{@"t":@".mas_top", @"r":@".mas_right", @"b":@".mas_bottom", @"l":@".mas_left"};
    if ([self.txtFldTopTRBL.stringValue length]) {
        NSString *tmp=self.txtFldTopTRBL.stringValue;
        NSString *trblString=trblDict[tmp];
        if (!trblString) {
            [self errorWithString:tmp];
            return;
        }
        if ([trblString isEqualToString:@".mas_top"]) {
            trblString=@"";
        }
        if ([self.txtFldTopTRBLValue.stringValue length]) {
            [array addObject:[NSString stringWithFormat:@"    make.top.equalTo(<#self.#>%@).offset(%@);\n",trblString,self.txtFldTopTRBLValue.stringValue]];
        } else {
            [array addObject:[NSString stringWithFormat:@"    make.top.equalTo(<#self.#>);\n"]];
        }
    }
    
    if ([self.txtFldLeftTRBL.stringValue length]) {
        NSString *tmp=self.txtFldLeftTRBL.stringValue;
        NSString *trblString=trblDict[tmp];
        if (!trblString) {
            [self errorWithString:tmp];
            return;
        }
        if ([trblString isEqualToString:@".mas_left"]) {
            trblString=@"";
        }
        if ([self.txtFldLeftTRBLValue.stringValue length]) {
            [array addObject:[NSString stringWithFormat:@"    make.left.equalTo(<#self.#>%@).offset(%@);\n",trblString,self.txtFldLeftTRBLValue.stringValue]];
        } else {
            [array addObject:[NSString stringWithFormat:@"    make.left.equalTo(<#self.#>);\n"]];
        }
    }
    
    if ([self.txtFldBottomTRBL.stringValue length]) {
        NSString *tmp=self.txtFldBottomTRBL.stringValue;
        NSString *trblString=trblDict[tmp];
        if (!trblString) {
            [self errorWithString:tmp];
            return;
        }
        if ([trblString isEqualToString:@".mas_bottom"]) {
            trblString=@"";
        }
        if ([self.txtFldBottomTRBLValue.stringValue length]) {
            [array addObject:[NSString stringWithFormat:@"    make.bottom.equalTo(<#self.#>%@).offset(%@);\n",trblString,self.txtFldBottomTRBLValue.stringValue]];
        } else {
            [array addObject:[NSString stringWithFormat:@"    make.bottom.equalTo(<#self.#>);\n"]];
        }
    }
    
    if ([self.txtFldRightTRBL.stringValue length]) {
        NSString *tmp=self.txtFldRightTRBL.stringValue;
        NSString *trblString=trblDict[tmp];
        if (!trblString) {
            [self errorWithString:tmp];
            return;
        }
        if ([trblString isEqualToString:@".mas_right"]) {
            trblString=@"";
        }
        if ([self.txtFldRightTRBLValue.stringValue length]) {
            [array addObject:[NSString stringWithFormat:@"    make.right.equalTo(<#self.#>%@).offset(%@);\n",trblString,self.txtFldRightTRBLValue.stringValue]];
        } else {
            [array addObject:[NSString stringWithFormat:@"    make.right.equalTo(<#self.#>);\n"]];
        }
    }
    
    if ([self.txtFldCenterXValue.stringValue length]) {
        NSString *tmp=self.txtFldCenterXValue.stringValue;
        if ([tmp isEqualToString:@"0"]) {
            [array addObject:[NSString stringWithFormat:@"    make.centerX.equalTo(<#self.#>);\n"]];
        } else {
            [array addObject:[NSString stringWithFormat:@"    make.centerX.equalTo(<#self.#>).offset(%@);\n",tmp]];
        }
    }
    
    if ([self.txtFldCenterYValue.stringValue length]) {
        NSString *tmp=self.txtFldCenterYValue.stringValue;
        if ([tmp isEqualToString:@"0"]) {
            [array addObject:[NSString stringWithFormat:@"    make.centerY.equalTo(<#self.#>);\n"]];
        } else {
            [array addObject:[NSString stringWithFormat:@"    make.centerY.equalTo(<#self.#>).offset(%@);\n",tmp]];
        }
    }
    
    if ([self.txtFldTopAbsoluteValue.stringValue length]) {
        [array addObject:[NSString stringWithFormat:@"    make.top.mas_equalTo(%@);\n",self.txtFldTopAbsoluteValue.stringValue]];
    }
    
    if ([self.txtFldLeftAbsoluteValue.stringValue length]) {
        [array addObject:[NSString stringWithFormat:@"    make.left.mas_equalTo(%@);\n",self.txtFldLeftAbsoluteValue.stringValue]];
    }
    
    if ([self.txtFldWidthAbsoluteValue.stringValue length]) {
        [array addObject:[NSString stringWithFormat:@"    make.width.mas_equalTo(%@);\n",self.txtFldWidthAbsoluteValue.stringValue]];
    }
    
    if ([self.txtFldHeightAbsoluteValue.stringValue length]) {
        [array addObject:[NSString stringWithFormat:@"    make.height.mas_equalTo(%@);\n",self.txtFldHeightAbsoluteValue.stringValue]];
    }
    
    if ([self.txtFldWidthRelativeValue.stringValue length]) {
        NSString *tmp = self.txtFldWidthRelativeValue.stringValue;
        if ([tmp isEqualToString:@"0"]) {
            [array addObject:@"    make.width.equalTo(<#self.#>);\n"];
        } else {
            [array addObject:[NSString stringWithFormat:@"    make.width.equalTo(<#self.#>).offset(%@);\n",tmp]];
        }
    }
    
    if ([self.txtFldHeightRelativeValue.stringValue length]) {
        NSString *tmp = self.txtFldHeightRelativeValue.stringValue;
        if ([tmp isEqualToString:@"0"]) {
            [array addObject:@"    make.height.equalTo(<#self.#>);\n"];
        } else {
            [array addObject:[NSString stringWithFormat:@"    make.height.equalTo(<#self.#>).offset(%@);\n",tmp]];
        }
    }
    
    [array addObject:@"}];"];
    
    NSString *finalString=[array componentsJoinedByString:@""];
    self.textView.string=finalString;
    
    NSPasteboard *paste = [NSPasteboard generalPasteboard];
    [paste clearContents];
    [paste writeObjects:@[finalString]];
}

- (void)clear
{
    self.txtFldEdgeInset.stringValue=@"";
    self.txtFldTopTRBL.stringValue=@"";
    self.txtFldTopTRBLValue.stringValue=@"";
    self.txtFldRightTRBL.stringValue=@"";
    self.txtFldRightTRBLValue.stringValue=@"";
    self.txtFldBottomTRBL.stringValue=@"";
    self.txtFldBottomTRBLValue.stringValue=@"";
    self.txtFldLeftTRBL.stringValue=@"";
    self.txtFldLeftTRBLValue.stringValue=@"";
    self.txtFldTopAbsoluteValue.stringValue=@"";
    self.txtFldLeftAbsoluteValue.stringValue=@"";
    self.txtFldWidthAbsoluteValue.stringValue=@"";
    self.txtFldHeightAbsoluteValue.stringValue=@"";
    self.txtFldWidthRelativeValue.stringValue=@"";
    self.txtFldHeightRelativeValue.stringValue=@"";
    self.txtFldComment.stringValue=@"";
    self.txtFldCenterXValue.stringValue=@"";
    self.txtFldCenterYValue.stringValue=@"";
    [self.txtFldEdgeInset becomeFirstResponder];
}

- (void)errorWithString:(NSString *)errWord
{
    self.textView.string=[NSString stringWithFormat:@"Error interpret: %@",errWord];
}


@end
