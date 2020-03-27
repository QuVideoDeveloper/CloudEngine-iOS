//
//  QVCloudEngine.h
//  QVCloudEngine
//
//  Created by 夏澄 on 2020/3/12.
//

#import <Foundation/Foundation.h>
#import "QVCloudEngineEnum.h"

@class QVCloudEngineConfig;
@class QVTemplateConfig;
@class QVCompositeConfig;

@class QVTemplateResponse;
@class QVErrorModel;
@class QVCompositeTask;
@class QVCompositePreResponse;
@class QVCompositeResponse;
@class QVCompositeFileListResponse;

NS_ASSUME_NONNULL_BEGIN


@interface QVCloudEngine : NSObject

/// 初始化SDK
/// @param config 配置信息
+ (void)initializeWithConfig:(QVCloudEngineConfig *)config;

/// 获取素材模版列表
/// @param templateConfig 请求参数配置
/// @param success 成功 返回素材模板数据 responseObject
/// @param failure 失败返回 errorModel
+ (void)getTemplates:(QVTemplateConfig *)templateConfig
             success:(void(^)(QVTemplateResponse *responseObject))success
             failure:(void(^)(QVErrorModel *errorModel))failure;

/// 视频合成
/// @param compositeConfig 合成参数
/// @param start 合成开始 返回task 和 response
/// @param progress 合成进度状态
/// @param success 合成成功 返回response
/// @param failure 合成失败 返回 task 和 error
+ (void)composite:(QVCompositeConfig *)compositeConfig
            start:(void(^)(QVCompositeTask *task, QVCompositePreResponse *response))start
         progress:(void(^)(QVCloudEngineCompositeState state))progress
          success:(void(^)(QVCompositeResponse *response))success
          failure:(void(^)(QVCompositeTask *task, QVErrorModel *error, BOOL canForceComposite))failure;


/// 查询视频列表
/// @param pageNum 分页页码，最小1，默认1
/// @param pageSize 分页条数，默认10 最大50
/// @param success 成功返回 response
/// @param failure 失败 返回 errorModel
+ (void)getVideosWithPageNum:(NSInteger)pageNum
                    pageSize:(NSInteger)pageSize
                     success:(void(^)(QVCompositeFileListResponse *response))success
                     failure:(void(^)(QVErrorModel *errorModel))failure;

/// 上报接口,当成功获取到视频后，调用上报接口，以统计有效合成。
/// @param fileIds 文件唯一标识
+ (void)report:(NSArray <NSString *> *)fileIds;


/// sdk 版本号
+ (NSString *)sdkVersion;

@end

NS_ASSUME_NONNULL_END
