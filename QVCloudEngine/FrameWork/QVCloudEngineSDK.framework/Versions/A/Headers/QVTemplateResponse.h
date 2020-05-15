//
//  QVTemplateResponse.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/17.
//

#import "XYCommonModel.h"

@class QVTemplateInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface QVTemplateResponse : XYCommonModel

@property (nonatomic, copy) NSArray<QVTemplateInfoModel *> *dataList;

/// 是否有下一页，true：有，false:无
@property (nonatomic, assign) BOOL hasMore;

@end

NS_ASSUME_NONNULL_END
