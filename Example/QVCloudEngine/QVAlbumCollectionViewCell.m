//
//  LYFAlbumCollectionViewCell.m
//  LYFAlbum
//
//  Created by 李玉枫 on 2018/12/6.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import "QVAlbumCollectionViewCell.h"
#import "QVPhotoManger.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface QVAlbumCollectionViewCell()

/// 相片
@property (nonatomic, strong) UIImageView *photoImageView;
/// 选中按钮
@property (nonatomic, strong) UIButton *selectButton;
/// 半透明遮罩
@property (nonatomic, strong) UIView *translucentView;

@property (nonatomic, strong) UILabel *durationLabel;

@end

@implementation QVAlbumCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self photoImageView];
        [self translucentView];
        [self selectButton];
    }
    
    return self;
}

#pragma mark - Set方法
-(void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    
    self.translucentView.hidden = !isSelect;
    [self.selectButton setBackgroundImage:isSelect ? [UIImage imageNamed: @"selectImage_select"] : nil forState:UIControlStateNormal];
    
    if ([QVPhotoManger standardPhotoManger].maxCount == [QVPhotoManger standardPhotoManger].choiceCount) {
        self.translucentView.hidden = NO;
        if (isSelect) {
            _translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        } else {
            _translucentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        }
    } else {
        _translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
}

#pragma mark - 加载图片
-(void)loadImage:(NSIndexPath *)indexPath {
    CGFloat imageWidth = (kScreenWidth - 20.f) / 5.5;
    self.photoImageView.image = nil;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = NO;
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:self.asset targetSize:CGSizeMake(imageWidth * [UIScreen mainScreen].scale, imageWidth * [UIScreen mainScreen].scale) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (self.row == indexPath.row) {
            self.photoImageView.image = result;
        }
    }];
    if (PHAssetMediaTypeVideo == self.asset.mediaType) {
        self.durationLabel.hidden = NO;
        self.durationLabel.text = [self xy_stringFromMilliseconds:self.asset.duration * 1000 style:nil];
    } else {
        self.durationLabel.hidden = YES;
    }
}

- (NSString *)xy_stringFromMilliseconds:(UInt32)totalMilliseconds style:(NSString *)style
{
    //    NSLog(@"totalMilliseconds = %lld",totalMilliseconds);
    long long milliseconds = (totalMilliseconds % 1000 )/100;
    long long seconds = totalMilliseconds / 1000 % 60;
    long long minutes = (totalMilliseconds / 1000 / 60) % 60;
    long long hours = (totalMilliseconds / 1000 / 3600);
    
    if([style isEqualToString:@"hh:mm:ss.ms"]){
        if(hours == 0){
            return [NSString stringWithFormat:@"%01lli:%02lli.%01lli", minutes, seconds,milliseconds];
        }else{
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }else if([style isEqualToString:@"ss.ms"]){
        if(hours == 0 && minutes == 0){
            return [NSString stringWithFormat:@"%02lli.%01lli",seconds,milliseconds];
        }else if(hours == 0){
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli", minutes, seconds];
        }else{
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }else if([style isEqualToString:@"s.ms"]){
        if(hours == 0 && minutes == 0){
            return [NSString stringWithFormat:@"%01lli.%01lli",seconds,milliseconds];
        }else if(hours == 0){
            return [NSString stringWithFormat:@"%01lli:%02lli.%01lli", minutes, seconds, milliseconds];
        }else{
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }else if([style isEqualToString:@"sss.ms"]){//use 60.0 instead of 1:00.0
        if(hours == 0 && minutes == 0){
            return [NSString stringWithFormat:@"%01lli.%01lli",seconds,milliseconds];
        }else if(hours == 0 && minutes == 1){
            seconds += 60;
            return [NSString stringWithFormat:@"%02lli.%01lli", seconds, milliseconds];
        }else if(hours == 0){
            return [NSString stringWithFormat:@"%01lli:%02lli.%01lli", minutes, seconds, milliseconds];
        }else{
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }else if([style isEqualToString:@"ss'ms\""]){
        //mm'ss''
        if(milliseconds>=5){
            seconds+=1;
            if(seconds == 60){
                seconds = 0;
                minutes+=1;
                if(minutes == 60){
                    minutes = 0;
                    hours+=1;
                }
            }
        }
        if(hours == 0){
            return [NSString stringWithFormat:@"%02lli'%02lli''", minutes, seconds];
        }else{
            return [NSString stringWithFormat:@"%01lli:%02lli'%02lli''", hours, minutes, seconds];
        }
    }else{
        //hh:mm:ss
        if(milliseconds>=5){
            seconds+=1;
            if(seconds == 60){
                seconds = 0;
                minutes+=1;
                if(minutes == 60){
                    minutes = 0;
                    hours+=1;
                }
            }
        }
        if(hours == 0){
            return [NSString stringWithFormat:@"%02lli:%02lli", minutes, seconds];
        }else{
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }
}

#pragma mark - 点击事件
-(void)selectPhoto:(UIButton *)button {
    if (self.selectPhotoAction) {
        self.selectPhotoAction(self.asset);
    }
}

#pragma mark - Get方法

- (UILabel *)durationLabel {
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, (kScreenWidth - 20.f) / 3.f - 20, (kScreenWidth - 20.f) / 3.f, 20)];
        _durationLabel.textColor = [UIColor redColor];
        _durationLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_durationLabel];
    }
    return _durationLabel;
}

-(UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 20.f) / 3.f, (kScreenWidth - 20.f) / 3.f)];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_photoImageView];
    }
    
    return _photoImageView;
}

-(UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _selectButton.layer.borderWidth = 1.f;
        _selectButton.layer.cornerRadius = 12.5f;
        _selectButton.layer.masksToBounds = YES;
        [_selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_selectButton];
        _selectButton.frame = CGRectMake((kScreenWidth - 20.f) / 3.f - 29, 3, 25, 25);
    }
    
    return _selectButton;
}

-(UIView *)translucentView {
    if (!_translucentView) {
        _translucentView = [[UIView alloc] init];
        _translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        [self.contentView addSubview:_translucentView];
        _translucentView.frame = CGRectMake(0, 0, (kScreenWidth - 20.f) / 3.f, (kScreenWidth - 20.f) / 3.f);
        _translucentView.hidden = YES;
    }
    
    return _translucentView;
}

@end
