//
//  QVTemplateConfig.h
//  QVCloudEngine
//
//  Created by 夏澄 on 2020/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QVTemplateConfig : NSObject


/// 页码，默认从1开始
@property (nonatomic, assign) NSInteger pageNum;

/// 每页记录条数，默认10条
@property (nonatomic, assign) NSInteger pageSize;

@end

NS_ASSUME_NONNULL_END
