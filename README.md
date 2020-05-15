# QVCloudEngine

[![CI Status](https://img.shields.io/travis/Sunshine/QVCloudEngine.svg?style=flat)](https://travis-ci.org/Sunshine/QVCloudEngine)
[![Version](https://img.shields.io/cocoapods/v/QVCloudEngine.svg?style=flat)](https://cocoapods.org/pods/QVCloudEngine)
[![License](https://img.shields.io/cocoapods/l/QVCloudEngine.svg?style=flat)](https://cocoapods.org/pods/QVCloudEngine)
[![Platform](https://img.shields.io/cocoapods/p/QVCloudEngine.svg?style=flat)](https://cocoapods.org/pods/QVCloudEngine)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

QVCloudEngine is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QVCloudEngine'
```

## Author

Sunshine, cheng.xia@quvideo.com

## 接口文档
运行Demo工程，需要把申请到的**AppKey**、**AppSecret**添入如下位置。
```
    engineConfig.appKey = @"申请的appKey ";
    engineConfig.appSecrect = @"申请的appSecrect";
```

## 功能概览
小影云端合成包含支持图片、视频云端模版合成。
## 前期准备
1. 向小影对接人申请 appKey 和 appSecrect（后续API接口签名认证会使用到）；
2. 申请最新版本的小影云端合成sdk。
3. 点击Sync，同步配置。

### 参数配置
1. 网络请求支持http  在Info.plist中添加权限：

```
在Info.plist中添加 App Transport Security Settings 类型 Dictionary ;
并在App Transport Security Settings 下添加 Allow Arbitrary Loads 类型Boolean, 值设为 YES
```
## 接口说明
### 初始化
调用以初始化云端合成SDK，**调用其他接口前需要先调用初始化**。
```
    QVCloudEngineConfig *engineConfig = [[QVCloudEngineConfig alloc] init];
    engineConfig.userId = @"第三方用户唯一标示，如果没有可以传，广告Id等";
    engineConfig.appKey = @"申请的appKey ";
    engineConfig.appSecrect = @"申请的appSecrect";
    [QVCloudEngine initializeWithConfig:engineConfig];
```
#### 请求参数
**engineConfig : 初始化配置**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| engineConfig | 初始化配置 | QVCloudEngineConfig | 必须 |

**QVCloudEngineConfig：初始化参数**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| appKey | 注册时申请的AppKey | String | 必须 |
| config | 初始化配置 | QVCloudEngineConfig | 必须 |
| appSecrect | 注册时申请的AppSecrect | String | 必须 |
| userId | 第三方用户唯一标示，<br>如果没有可以传入广告Id、唯一id等。| String | 必须 | 

### 获取素材模版列表
调用以获取合成素材列表。
```
    //获取素材模版列表
    QVTemplateConfig *templateConfig = [[QVTemplateConfig alloc] init];
    templateConfig.pageNum = 1;
    templateConfig.pageSize = 10;
    [QVCloudEngine getTemplates:templateConfig success:^(QVTemplateResponse * _Nonnull responseObject) {
        //code
    } failure:^(QVErrorModel * _Nonnull errorModel) {
        //code
    }];
```
#### 请求参数
**QVTemplateConfig：获取素材请求参数**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| pageNum | 页码，默认从1开始 | number | 非必须 |
| pageSize | 每页记录条数，默认10条，最大50。<br>**注：超过50按照50生效。**| number | 非必须 | 
#### 响应参数
**QVTemplateResponse：素材详情列表参数**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| dataList | 素材详情列表 | NSArray<QVTemplateInfoModel *> *dataList | 非必须 |
| hasMore | 分页参数，是否有下一页 | bool | 非必须 | 

**QVTemplateInfoModel：单个素材详情参数**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| templateId | 素材Id | number | 必须 | 
| orderNo | 排序序号 | number | 必须 | 
| icon | 缩略图URL，格式为gif/jpeg/png | string | 必须 | 
| previewurl | 预览URL | string | 必须 | 
| previewtype | 预览类型，1文字 2 图片 3 视频 4音频 5网页 6flash | number | 必须 | 
| duration | 时长（应用于音频和视频), 秒 | string | 必须 | 
| width | 宽度 | number | 必须 |
| height | 高度 | number | 必须 |
| maxMediaCount | 限制选择媒体文件个数 | number | 必须 |
| title | 名称 | string | 必须 |
| intro |简介 | string | 必须 | 

**QVErrorModel：获取素材错误参数**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| code | 错误码 | number | 必须 | 
| message | 错误描述 | String | 必须 |
### 发起云端合成
传入合成PHAsset、获取到的素材信息以及其他可配置参数，调用以合成目标视频。
```
QVCompositeConfig *compositeConfig = [[QVCompositeConfig alloc] init];
compositeConfig.templateId = templateInfo.templateId;//素材模版的templateId
compositeConfig.resolution = resolution;//分辨率
NSMutableArray *mediaList = [NSMutableArray array];
QVCompositeMediaData *mediaDataModel = [[QVCompositeMediaData alloc] init];
mediaDataModel.asset = PHAsset;
[mediaList addObject:mediaDataModel];
compositeConfig.mediaDataList = mediaDataList;
    [QVCloudEngine composite:compositeConfig start:^(QVCompositeTask * _Nonnull task, QVCompositePreResponse * _Nonnull response) {
        
    } progress:^(QVCloudEngineCompositeState state) {
        
    } success:^(QVCompositeResponse * _Nonnull response) {
       
    } failure:^(QVCompositeTask * _Nonnull task, QVErrorModel * _Nonnull error, BOOL canForceComposite) {
       
    }];
```
#### 请求参数
**QVCompositeConfig：合成视频请求参数**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| forceMake | 是否强制生成，true：强制，false：不强制，默认false。<br>例：素材要求选择人脸照片，选择的人脸照片像素低，<br>可以强制合成，但是建议更换更清晰的照片。 | boolean | 非必须 | 
| templateId | 素材Id（在素材接口里面获取）| number | 必须 | 
| resolution | 视频分辨率：480p/ 720p/1080p | Resolution | 必须 | 
| mediaDataList | 本地图片组/视频 | NSArray <QVCompositeMediaData *> *mediaDataList | 必须|

**QVCompositeMediaData：单个源文件参数**
| 名称  | 解释 | 类型 | 是否必须 | 注意 |
| :-: | :-: | :-: | :-: |
| asset | Photokit 里的PHAsset  | PHAsset | 可选 |asset 和 filePath 必须有一项是必填 |
| filePath | 图片视频文件的路径  | Sting | 可选 |asset 和 filePath 必须有一项是必填 | 

#### 响应参数
**QVCompositePreResponse：云端合成预处理**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| businessId | 云端合成业务Id | String | 必须 |

**QVCompositeFileDataModel：云端合成完成**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| fileId | 文件唯一标识 | String | 必须 |
| businessId | 云端合成业务Id | String | 必须 | 
| fileUrl | 文件url，视频格式为mp4 | String | 必须 |
| coverImageUrl | 封面url，格式为jpeg/png | String | 必须 | 
| duration | 文件时长（ms） | String | 必须 |

**QVCompositeTask：云端合成任务**
| 接口 | 解释 |
| :-: | :-: |
| forceMake | 强制制作，只有当制作失败并且可以强制制作才有效

**State：云端合成中间状态**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| state | QVCloudEngineCompositeState_IDEL, //初始状态 <br>QVCloudEngineCompositeState_UPLOAD, //进入文件上传阶段 <br>QVCloudEngineCompositeState_COMPOSITE, //进入合成阶段 <br>QUERY, //进入查询合成情况阶段 <br>TIMEOUT, //合成超时 <br>QVCloudEngineCompositeState_SUCCESS, //合成成功 <br>FAILURE, //合成失败 <br>QVCloudEngineCompositeState_FAILURE,//合成失败但是可以强制制作  <br>STOP//停止 | State | 必须 |

### 查询视频列表
查询历史合成视频列表
```
[QVCloudEngine getVideosWithPageNum:1 pageSize:15 success:^(QVCompositeFileListResponse * _Nonnull response) {
      [QVCloudEngine report:[response fetchFileIds]];//上报
    } failure:^(QVErrorModel * _Nonnull errorModel) {
           
 }];
```
#### 请求参数
**VideoConfig：视频请求参数**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| pageNum | 页码，默认从1开始 | number | 非必须 |
| pageSize | 每页记录条数，默认10条，最大50。<br>**注：超过50按照50生效。** | number | 非必须 | 

#### 响应参数
**QVCompositeFileListResponse：视频列表参数**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| data | 视频列表 | NSArray<QVCompositeFileDataModel *> *data | 非必须 |
| hasMore | 分页参数，是否有下一页 | bool | 非必须 | 

**QVCompositeFileDataModel：单个视频参数**
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| fileId | 文件唯一标识 | String | 必须 |
| businessId | 业务id | String | 必须 | 
| fileUrl | 文件url | String | 必须 |
| coverImageUrl | 封面url | String | 必须|
| duration | 文件时长 | String | 必须 |

### 上报接口
当成功获取到视频后，调用上报接口，以统计有效合成。
```
[QVCloudEngine report:fileIds];
```
#### 请求参数
| 名称  | 解释 | 类型 | 是否必须 |
| :-: | :-: | :-: | :-: |
| fileIds | 文件唯一标识（云端合成成功获取）| List<String> | 必须 |
  
## Q & A

## License

QVCloudEngine is available under the MIT license. See the LICENSE file for more info.
