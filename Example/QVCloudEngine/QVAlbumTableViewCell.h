//
//  LYFAlbumTableViewCell.h
//  LYFAlbum
//
//  Created by 李玉枫 on 2018/12/6.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QVAlbumModel;

@interface QVAlbumTableViewCell : UITableViewCell

/// 相册
@property (nonatomic, strong) QVAlbumModel *albumModel;
/// 行数
@property (nonatomic, assign) NSInteger row;

/// 加载图片
-(void)loadImage:(NSIndexPath *)index;

@end
