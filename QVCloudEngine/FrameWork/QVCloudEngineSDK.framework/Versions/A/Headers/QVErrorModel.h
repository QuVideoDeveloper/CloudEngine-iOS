//
//  QVRequestErrorModel.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QVErrorModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;

+ (instancetype)initWithCode:(NSInteger)code message:(NSString *)message;


@end

NS_ASSUME_NONNULL_END
