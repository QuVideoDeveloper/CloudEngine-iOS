//
//  QVCloudEngineConfig.h
//  QVCloudEngine
//
//  Created by 夏澄 on 2020/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QVCloudEngineConfig : NSObject

/// 必须参数
@property (nonatomic, copy) NSString *appKey;

/// 必须参数
@property (nonatomic, copy) NSString *appSecrect;

/// 必须参数 用户唯一标识或设备标识
@property (nonatomic, copy) NSString *userId;

/// 可选参数 默认获取系统的国家码
@property (nonatomic, copy) NSString *countryCode;

/// 可选参数 语言编码
@property (nonatomic, copy) NSString *languageCode;


@end

NS_ASSUME_NONNULL_END
