//
//  QVViewController.m
//  QVCloudEngineSDK
//
//  Created by Sunshine on 03/13/2020.
//  Copyright (c) 2020 Sunshine. All rights reserved.
//

#import "QVTemplateListVC.h"
#import <MediaPlayer/MediaPlayer.h>
@import CoreServices;

#import <QVCloudEngineSDK/QVCloudEngine.h>
//ui
#import "QVTemplateInfoCell.h"
#import "QVPhotosManager.h"
#import "SVProgressHUD.h"
@interface QVTemplateListVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *tCollectionView;

@property (nonatomic, assign) NSInteger didSeletedIndex;

@property (nonatomic, assign) QVCloudEngineResolution resolution;

@end

@implementation QVTemplateListVC {
    QVTemplateResponse *_templateResponse;
}
- (IBAction)onLoginBtn:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"设置userId" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = nil;
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loginWithUserId:alertController.textFields[0].text];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)loginWithUserId:(NSString *)userId {
    //初始化
    if (!userId) {
        return;
    }
    QVCloudEngineConfig *engineConfig = [[QVCloudEngineConfig alloc] init];
    engineConfig.userId = userId;
    engineConfig.appKey = @"申请的appKey";
    engineConfig.appSecrect = @"申请的appSecrect";
    [QVCloudEngine initializeWithConfig:engineConfig];
}

- (void)viewDidLoad
{
    [self loginWithUserId:@"唯一ID"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.tCollectionView.delegate = self;
    self.tCollectionView.dataSource = self;
    [self.tCollectionView registerClass:[QVTemplateInfoCell class] forCellWithReuseIdentifier:@"QVTmplateInfoCellID"];
    
    //获取素材模版列表
    QVTemplateConfig *templateConfig = [[QVTemplateConfig alloc] init];
    templateConfig.pageNum = 1;
    templateConfig.pageSize = 10;
    [QVCloudEngine getTemplates:templateConfig success:^(QVTemplateResponse * _Nonnull responseObject) {
           _templateResponse = responseObject;
           [self.tCollectionView reloadData];
        if (responseObject.hasMore) {
            //获取素材模版列表
            QVTemplateConfig *templateConfig = [[QVTemplateConfig alloc] init];
            templateConfig.pageNum = 2;
            templateConfig.pageSize = 10;
                 //请求下一页数据
               [QVCloudEngine getTemplates:templateConfig success:^(QVTemplateResponse * _Nonnull responseObject) {
                   NSMutableArray *mList = [NSMutableArray arrayWithArray:_templateResponse.dataList];
                   [mList addObjectsFromArray:responseObject.dataList];
                   responseObject.dataList = mList;
                   _templateResponse = responseObject;
                   [self.tCollectionView reloadData];
               } failure:^(QVErrorModel * _Nonnull errorModel) {

               }];
        }
       } failure:^(QVErrorModel * _Nonnull errorModel) {

       }];
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _templateResponse.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QVTemplateInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QVTmplateInfoCellID" forIndexPath:indexPath];
    if ( indexPath.item < _templateResponse.dataList.count) {
        cell.model = _templateResponse.dataList[indexPath.item];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 20) / 2.0 , ((self.view.frame.size.width - 20) / 2.0) * 4 / 3.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

// 每横行之间间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 每竖行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.didSeletedIndex = indexPath.item;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择合成分辨率" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"480P", @"720P", @"1080P",  nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (4 != buttonIndex) {
        switch (buttonIndex) {
            case 0:
                self.resolution = QVCloudEngineResolution480;
                break;
            case 1:
            self.resolution = QVCloudEngineResolution720;
            break;
            case 2:
            self.resolution = QVCloudEngineResolution1080;
            break;
            break;
            default:
                break;
        }
        [self showMediaPicker];
    }
}

- (void)showMediaPicker {
    if (self.didSeletedIndex < _templateResponse.dataList.count) {
        QVTemplateInfoModel *templateModel = _templateResponse.dataList[self.didSeletedIndex];
        [QVPhotosManager showPhotosManager:self withMaxImageCount:[templateModel.maxMediaCount integerValue] withAlbumArray:^(NSMutableArray<QVPhotoModel *> *albumArray) {
            __block NSMutableArray *mediaList = [NSMutableArray array];
            [albumArray enumerateObjectsUsingBlock:^(QVPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                QVCompositeMediaData *mediaDataModel = [[QVCompositeMediaData alloc] init];
                mediaDataModel.asset = obj.asset;
                [mediaList addObject:mediaDataModel];
            }];
            [self composite:mediaList];
        }];
    }
}

#pragma mark - UIImagePickerControllerDelegate

//合成
- (void)composite:(NSArray <QVCompositeMediaData *> *)mediaDataList {
    [SVProgressHUD showWithStatus:@"开始合成"];
    QVCompositeConfig *compositeConfig = [[QVCompositeConfig alloc] init];
    if (self.didSeletedIndex < _templateResponse.dataList.count) {
        QVTemplateInfoModel *templateInfo = _templateResponse.dataList[self.didSeletedIndex];
        compositeConfig.templateId = templateInfo.templateId;
    }
    compositeConfig.resolution = self.resolution;
    compositeConfig.mediaDataList = mediaDataList;
    [QVCloudEngine composite:compositeConfig start:^(QVCompositeTask * _Nonnull task, QVCompositePreResponse * _Nonnull response) {
        
    } progress:^(QVCloudEngineCompositeState state) {
        
    }uploadProgress:^(CGFloat uploadProgress) {
        
    } success:^(QVCompositeResponse * _Nonnull response) {
        [QVCloudEngine report:@[response.data.fileId]];
        [SVProgressHUD showImage:nil status:@"合成成功"];
    } failure:^(QVCompositeTask * _Nonnull task, QVErrorModel * _Nonnull error, BOOL canForceComposite) {
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"合成失败：errorCode:=%ld =%@",(long)error.code, error.message]];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
