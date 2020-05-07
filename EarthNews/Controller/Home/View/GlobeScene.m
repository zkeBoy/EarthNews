//
//  GlobeScene.m
//  旋转地球
//
//  Created by apple on 16/7/16.
//  Copyright © 2016年 Hogger.Wang. All rights reserved.
//

#import "GlobeScene.h"

@interface GlobeScene()
@property (nonatomic, strong) SCNCamera *camera;
@property (nonatomic, strong) SCNNode *cameraNode;
@property (nonatomic, strong) SCNNode *lightNode;
@property (nonatomic, strong) SCNNode *globeNode;

@end

@implementation GlobeScene

- (instancetype)init {
    //step1: init camera
    self.camera = [[SCNCamera alloc] init];
    self.camera.zNear = 0.01;
    
    self.cameraNode = [[SCNNode alloc] init];
    self.cameraNode.position = SCNVector3Make(0.0, 0.0, 1.5);
    self.cameraNode.camera = self.camera;
    self.camera.focalBlurRadius = 0;
    //step2: init light
    SCNLight *light = [[SCNLight alloc] init];
    light.type = SCNLightTypeAmbient;
    light.color = [UIColor blackColor];
    self.lightNode = [[SCNNode alloc] init];
    self.lightNode.light = light;
    //step3: init picture
    self.globeNode = [[SCNNode alloc] init];
    SCNSphere *sp = [[SCNSphere alloc] init];
    sp.firstMaterial.diffuse.contents = [UIImage imageNamed:@"earth_land_day"];
    SCNNode *modelNode = [SCNNode nodeWithGeometry:sp];
    [self.globeNode addChildNode:modelNode];
    
    //step4: add to rootNode
    self = [super init];
    [self.rootNode addChildNode:self.cameraNode];
    [self.rootNode addChildNode:self.lightNode];
    [self.rootNode addChildNode:self.globeNode];
    
    return self;
}





















@end
