//
//  QVCompositeFinishResponseObject.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/16.
//

#import "XYCommonModel.h"

@class QVCompositeFileDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface QVCompositeFileListResponse : XYCommonModel

/// 是否有下一页，true：有，false:无
@property (nonatomic, assign) BOOL hasMore;

/// 合成的文件信息列表
@property (nonatomic, copy) NSArray<QVCompositeFileDataModel *> *data;

- (NSArray <NSString *> *)fetchFileIds;

@end

NS_ASSUME_NONNULL_END
