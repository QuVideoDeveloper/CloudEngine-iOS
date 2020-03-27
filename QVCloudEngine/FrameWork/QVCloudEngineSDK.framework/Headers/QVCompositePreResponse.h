//
//  QVCompositePreResponse.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QVCompositePreResponse : NSObject

/// 业务id，云合成服务生成
@property (nonatomic, copy) NSString *businessId;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;


@end

NS_ASSUME_NONNULL_END
