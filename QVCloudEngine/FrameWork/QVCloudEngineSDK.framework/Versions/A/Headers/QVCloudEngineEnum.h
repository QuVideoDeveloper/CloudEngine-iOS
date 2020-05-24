//
//  QVCloudEngineEnum.h
//  QVCloudEngineSDK
//
//  Created by 夏澄 on 2020/3/17.
//

#ifndef QVCloudEngineEnum_h
#define QVCloudEngineEnum_h


typedef NS_ENUM(NSInteger, QVCloudEngineResolution) {
    QVCloudEngineResolution480 = 480,
    QVCloudEngineResolution720 = 720,
    QVCloudEngineResolution1080 = 1080,
};

typedef NS_ENUM(NSInteger, QVCloudEngineCompositeState) {
    QVCloudEngineCompositeState_IDEL = 0, //初始状态
    QVCloudEngineCompositeState_UPLOAD, //进入文件上传阶段
    QVCloudEngineCompositeState_COMPOSITE, //进入合成阶段
    QVCloudEngineCompositeState_SUCCESS, //合成成功
    QVCloudEngineCompositeState_FAILURE, //合成失败
};

typedef NS_ENUM(NSInteger, QVCloudEngineDataType) {
    QVCloudEngineDataTypeImage = 0,
    QVCloudEngineDataTypeVideo,
    QVCloudEngineDataTypeBoth,
};

#endif /* QVCloudEngineEnum_h */
