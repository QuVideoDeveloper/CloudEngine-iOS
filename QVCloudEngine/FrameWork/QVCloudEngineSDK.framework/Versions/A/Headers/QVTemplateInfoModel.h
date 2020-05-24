//
//  QVTemplateInfoModel.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/13.
//

#import <Foundation/Foundation.h>
#import "QVCloudEngineEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface QVTemplateInfoModel : NSObject

/// 模板编号
@property (nonatomic, copy) NSString *templateCode;

/// 素材唯一标识
@property (nonatomic, strong) NSNumber *templateId;

/// 排序序号
@property (nonatomic, strong) NSNumber *orderNo;

/// 缩略图URL
@property (nonatomic, copy) NSString *icon;

/// 预览URL
@property (nonatomic, copy) NSString *previewUrl;

/// 预览类型，1文字 2 图片 3 视频 4音频 5网页 6flash
@property (nonatomic, strong) NSNumber *previewType;

/// 时长（应用于音频和视频), 秒
@property (nonatomic, copy) NSString *duration;

/// 宽度
@property (nonatomic, strong) NSNumber *width;

/// 宽度
@property (nonatomic, strong) NSNumber *height;

/// 视频图片媒体最大张数
@property (nonatomic, strong) NSNumber *maxMediaCount;

/// 名称
@property (nonatomic, copy) NSString *title;

/// 简介
@property (nonatomic, copy) NSString *intro;

/// 模板种类编号
@property (nonatomic, copy) NSString *tcId;

/// 媒体资源的类型
@property (nonatomic, assign) QVCloudEngineDataType *dataType;

@end

NS_ASSUME_NONNULL_END
