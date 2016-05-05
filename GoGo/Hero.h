//
//  Hero.h
//  GoGo
//
//  Created by 王振西 on 16/4/12.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "physicsCategories.h"
@interface Hero : SKSpriteNode
@property (strong,nonatomic)SKAction *runRightAction;
@property (strong,nonatomic)SKAction *runForever;
@property (strong,nonatomic)NSArray *textureArray;
@property(strong,nonatomic)SKTexture *jump;
@property(strong,nonatomic)SKSpriteNode *jumpNode;
@property(assign,nonatomic)BOOL haveDefend;
@property(strong,nonatomic)SKSpriteNode *defendTao;
-(instancetype)initWithCharacterNum :(NSUInteger) characterNum;
-(void)receiveAttacker:(SKNode *)attacker contact:(SKPhysicsContact *)contact;
-(void)heroJump;
- (void)heroDefend;
- (void)heroRemoveDefend;
@end
