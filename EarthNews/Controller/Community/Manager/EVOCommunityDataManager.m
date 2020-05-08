//
//  EVOCommunityDataManager.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOCommunityDataManager.h"

@implementation EVOCommunityDataManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataSourceArray = [NSMutableArray array];
        [self readLocalJsonData];
    }
    return self;
}

- (void)readLocalJsonData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        NSLog(@"JSON解码失败");
    }else {
        self.dataSourceArray = [EVOUserCommunityDataObj mj_objectArrayWithKeyValuesArray:jsonObj];
    }
}

@end
