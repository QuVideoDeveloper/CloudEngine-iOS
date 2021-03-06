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

/// 相册的asset -- asset 和 filePath 只能设置其中的一个
@property (nonatomic, strong) PHAsset *asset;

/// 视频图片的路径 -- asset 和 filePath 只能设置其中的一个
@property (nonatomic, copy) NSString *filePath;

@end

@interface QVCompositeConfig : NSObject

/// 素材唯一标识
@property (nonatomic, strong) NSNumber *templateId;

/// 图片视频数据
@property (nonatomic, copy) NSArray <QVCompositeMediaData *> *mediaDataList;

/// 合成的分辨率
@property (nonatomic, assign) QVCloudEngineResolution resolution;

/// 查询超时时间， 单位秒，默认是180s
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@end

NS_ASSUME_NONNULL_END
