//
//  XYCommonModel.h
//  XYCommonAPIManager
//
//  Created by lizitao on 2019/8/14.
//

#import <Foundation/Foundation.h>

@interface XYCommonModel : NSObject<NSCoding, NSCopying>

@property (nonatomic, assign) BOOL success;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *message;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionaryValue;

- (void)setModelWithDictionary:(NSDictionary *)dictionaryValue;

@end

