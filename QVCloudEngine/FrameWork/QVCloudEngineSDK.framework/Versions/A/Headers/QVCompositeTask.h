//
//  QVCompositeTask.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class QVCompositeResponse;

@interface QVCompositeTask : NSObject

@property (nonatomic, copy) void(^forceCompositeBlock)(void);

- (void)forceComposite;


@end

NS_ASSUME_NONNULL_END
