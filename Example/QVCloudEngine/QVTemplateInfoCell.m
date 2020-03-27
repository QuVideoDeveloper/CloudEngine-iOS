//
//  QVTmplateInfoCell.m
//  QVCloudEngineSDK_Example
//
//  Created by 夏澄 on 2020/3/20.
//  Copyright © 2020 Sunshine. All rights reserved.
//

#import "QVTemplateInfoCell.h"
#import <YYWebImage/YYWebImage.h>

@interface QVTemplateInfoCell ()

@property (strong, nonatomic) YYAnimatedImageView *tImageView;
@property (strong, nonatomic) UILabel *makeLabel;

@end

@implementation QVTemplateInfoCell

- (void)setModel:(QVTemplateInfoModel *)model {
    _model = model;
    [self.tImageView yy_setImageWithURL:[NSURL URLWithString:model.icon] placeholder:nil];
    [self addSubview:self.makeLabel];
}

- (YYAnimatedImageView *)tImageView {
    if (!_tImageView) {
        _tImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_tImageView];
    }
    return _tImageView;
}

- (UILabel *)makeLabel {
    if (!_makeLabel) {
        _makeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, self.frame.size.height - 30, 80, 16)];
        _makeLabel.font = [UIFont systemFontOfSize:15];
        _makeLabel.textColor = [UIColor redColor];
        _makeLabel.text = @"点击制作";
    }
    return _makeLabel;
}

@end
