//
//  QVCompositeResponse.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/18.
//

#import "XYCommonModel.h"

@class QVCompositeFileDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface QVCompositeResponse : XYCommonModel

/// 合成的文件信息列表
@property (nonatomic, strong) QVCompositeFileDataModel *data;


@end

NS_ASSUME_NONNULL_END
