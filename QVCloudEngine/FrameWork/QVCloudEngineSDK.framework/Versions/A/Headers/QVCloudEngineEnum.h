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
    QVCloudEngineCompositeState_QUERY, //进入查询合成情况阶段
    QVCloudEngineCompositeState_SUCCESS, //合成成功
    QVCloudEngineCompositeState_FAILURE, //合成失败
    QVCloudEngineCompositeState_QUERY_TIMEOUT, //合成查询超时
    QVCloudEngineCompositeState_QUERY_FAILURE,//查询失败
    QVCloudEngineCompositeState_UPLOAD_CANCEL,// 上传取消
    QVCloudEngineCompositeState_FAILURE_FORCEMAKE,//合成失败但是可以强制制作
};

typedef NS_ENUM(NSInteger, QVCloudEngineDataType) {
    QVCloudEngineDataTypeBoth = 0,
    QVCloudEngineDataTypeImage ,
    QVCloudEngineDataTypeVideo,
};

#endif /* QVCloudEngineEnum_h */
