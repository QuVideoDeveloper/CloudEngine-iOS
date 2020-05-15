//
//  QVCompositeVideoModel.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QVCompositeFileDataModel : NSObject

/// 文件id
@property (nonatomic, copy) NSString *fileId;

/// 播放时长，时间戳格式
@property (nonatomic, copy) NSString *duration;

/// 封面url
@property (nonatomic, copy) NSString *coverImageUrl;

/// 生成后的图片或视频url
@property (nonatomic, copy) NSString *fileUrl;

/// 业务ID
@property (nonatomic, copy) NSString *businessId;

@end

NS_ASSUME_NONNULL_END
