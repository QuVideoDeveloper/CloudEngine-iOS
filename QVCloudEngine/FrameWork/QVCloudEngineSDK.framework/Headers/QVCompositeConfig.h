//
//  QVCompositeConfig.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/13.
//

#import <Foundation/Foundation.h>
#import "QVCloudEngineEnum.h"

@class PHAsset;

NS_ASSUME_NONNULL_BEGIN

@interface QVCompositeMediaData : NSObject

/// 相册的asset
@property (nonatomic, strong) PHAsset *asset;

@end

@interface QVCompositeConfig : NSObject

/// 素材唯一标识
@property (nonatomic, strong) NSNumber *templateId;

/// 图片视频数据
@property (nonatomic, copy) NSArray <QVCompositeMediaData *> *mediaDataList;

/// 合成的分辨率
@property (nonatomic, assign) QVCloudEngineResolution resolution;

@end

NS_ASSUME_NONNULL_END
