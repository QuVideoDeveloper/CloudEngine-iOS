//
//  LYFAlbumTableView.h
//  LYFAlbum
//
//  Created by 李玉枫 on 2018/12/6.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QVAlbumModel;

typedef void(^LYFAlbumTableViewSelectAction)(QVAlbumModel *albumModel);

@interface QVAlbumTableView : UITableView

/// 相册数组
@property (nonatomic, strong) NSMutableArray<QVAlbumModel *> *assetCollectionList;
/// 选择的相册
@property (nonatomic, copy) LYFAlbumTableViewSelectAction selectAction;

@end
