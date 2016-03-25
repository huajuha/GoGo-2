//
//  PlayScene.m
//  GoGo
//
//  Created by 王振西 on 16/2/28.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import "PlayScene.h"
#import "EndScene.h"
#define stagegapwidth 40
#define bigstagehigh 10
#define littestagehigh 70
static const uint32_t heroCategory = 0x1 << 0;
static const uint32_t stageCategory = 0x1 << 1;
static const uint32_t monsterCategory = 0x1 << 2;
@interface PlayScene()<SKPhysicsContactDelegate>
@property NSInteger stagecounts;//
@property CGPoint stagepoint;
@property int numbers;
@property (strong,nonatomic)SKSpriteNode *playerSprite;
@property (strong,nonatomic)SKAction *runRightAction;
@property (strong,nonatomic)SKAction *runForever;
@property (strong,nonatomic)NSArray *textureArray;
@property(nonatomic)NSInteger score;//纪录当前分数
@property(strong,nonatomic)SKLabelNode *scoreLabel;//显示分数的标签
@end
@implementation PlayScene

-(void)didMoveToView:(SKView *)view {

    _score=0;
    SKLabelNode *myLableNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLableNode.text =@"score:";
    myLableNode.fontSize = 50;
    myLableNode.zPosition=1;
    myLableNode.position = CGPointMake(850,700);
    [self addChild:myLableNode];
    _scoreLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _scoreLabel.text=[NSString stringWithFormat:@"%ld",(long)_score];
    _scoreLabel.fontSize=50;
    _scoreLabel.zPosition=1;
    _scoreLabel.position=CGPointMake(950, 690);
    [self addChild:_scoreLabel];
    self.speed=2;
    self.physicsWorld.contactDelegate=self;
    SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:@"bg"];
    //background.anchorPoint=CGPointZero;
    background.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
    background.size=CGSizeMake(self.size.width,self.size.height);//设置背景图片适应屏幕
    background.zPosition=0;//设置z轴坐标，解决遮挡关系
    [self addChild:background];
    // 4 animation frames stored as textures
    SKTexture *f1 = [SKTexture textureWithImageNamed: @"run_1"];
    SKTexture *f2 = [SKTexture textureWithImageNamed: @"run_2"];
    SKTexture *f3 = [SKTexture textureWithImageNamed: @"run_3"];
    SKTexture *f4 = [SKTexture textureWithImageNamed: @"run_4"];
    
    // an array of these textures
    _textureArray = @[f1,f2,f3,f4];
    
    // our player character sprite & starting position in the scene
    _playerSprite = [SKSpriteNode spriteNodeWithTexture:f1];
    _playerSprite.name=@"hero";
    _playerSprite.position = CGPointMake(CGRectGetMidX(self.frame)/3,
                                         CGRectGetMidY(self.frame)/1.5+19);
    // an Action using our array of textures with each frame lasting 0.1 seconds
    _runRightAction = [SKAction animateWithTextures:_textureArray timePerFrame:0.1];
    
    // don't run just once but loop indefinetely
    _runForever = [SKAction repeatActionForever:_runRightAction];
    
    // attach the completed action to our sprite
    
    
    // add the sprite to the scene
    _playerSprite.zPosition=2;
    _playerSprite.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:_playerSprite.size];
    _playerSprite.physicsBody.dynamic=YES;
    _playerSprite.physicsBody.allowsRotation=NO;
    _playerSprite.physicsBody.categoryBitMask=heroCategory;
    _playerSprite.physicsBody.collisionBitMask=monsterCategory | stageCategory;
    _playerSprite.physicsBody.contactTestBitMask=monsterCategory|stageCategory;
    [self addChild:_playerSprite];
    
//    NSString *path=[[NSBundle mainBundle] pathForResource:@"heroDied" ofType:@"sks"];
//    SKEmitterNode *explosion=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    explosion.numParticlesToEmit=20;
//    explosion.position=CGPointMake(0,-40);;
//    explosion.targetNode=self.scene;
//    [self addChild:explosion];
//    explosion.zPosition=3;
    [self initstage];
    
    
    
}
-(void)initstage{//初始化游戏建立三个stage
    SKSpriteNode *stagenode=[SKSpriteNode spriteNodeWithImageNamed:@"map0"];
    stagenode.size=CGSizeMake(500, 480);
    stagenode.anchorPoint=CGPointZero;
    stagenode.position=CGPointMake(0,bigstagehigh);
    stagenode.zPosition=1;
    //stagenode.speed=1;
    //stagenode.xScale=0.9;
    stagenode.name=@"stage";
    stagenode.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 500, 130+bigstagehigh)];
    stagenode.physicsBody.dynamic=NO;
    stagenode.physicsBody.categoryBitMask=stageCategory;
    //stagenode.physicsBody.friction=0;
    SKAction *stageaction=[SKAction moveToX:-600 duration:5];
    [stagenode runAction:stageaction withKey:@"movestage"];
    [self addChild:stagenode];
    SKSpriteNode *stagenode1=[SKSpriteNode spriteNodeWithImageNamed:@"map1"];
    stagenode1.size=CGSizeMake(480, 480);
    //stagenode1.speed=1;
    stagenode1.anchorPoint=CGPointZero;
    stagenode1.zPosition=1;
    //stagenode1.xScale=0.9;
    stagenode1.position=CGPointMake(stagenode.size.width+stagegapwidth, littestagehigh);
    _stagepoint=CGPointMake(stagenode.size.width+stagegapwidth+stagenode1.size.width, littestagehigh);
    stagenode1.name=@"stage";
    stagenode1.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 480, 50+littestagehigh)];
    stagenode1.physicsBody.dynamic=NO;
    stagenode1.physicsBody.categoryBitMask=stageCategory;
    //[stagenode addChild:stagenode1];
    [self addChild:stagenode1];
    SKAction *stageaction1=[SKAction moveToX:-600 duration:10.6];
    [stagenode1 runAction:stageaction1 withKey:@"movestage"];
    SKSpriteNode *stagenode2=[SKSpriteNode spriteNodeWithImageNamed:@"map2"];
    stagenode2.size=CGSizeMake(400, 480);
    stagenode2.anchorPoint=CGPointZero;
    stagenode2.position=CGPointMake(self.size.width,bigstagehigh);
    stagenode2.zPosition=1;
    //stagenode2.speed=1;
    //stagenode.xScale=0.9;
    stagenode2.name=@"stage";
    stagenode2.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 400, 130+bigstagehigh)];
    stagenode2.physicsBody.dynamic=NO;
    stagenode2.physicsBody.categoryBitMask=stageCategory;
    SKAction *stageaction2=[SKAction moveToX:-600 duration:16];
    [stagenode2 addChild:[self addmonster:0 andy:bigstagehigh+50]];
    [stagenode2 runAction:stageaction2  withKey:@"movestage"];
    [self addChild:stagenode2];
    _stagecounts=3;
    NSLog(@"%f",self.size.height);
    NSLog(@"%f",stagenode2.size.width);
    NSLog(@"%f",stagenode2.size.height);
}
-(SKSpriteNode*)addmonster: (int) selfxposition  andy:(int) selfyposition {//添加怪物的方法，怪物作为自节点加入到平台上，根据平台位置决定怪物的位置
    SKSpriteNode *monsternode=[SKSpriteNode spriteNodeWithImageNamed:@"z1"];
    monsternode.anchorPoint=CGPointZero;
    monsternode.position=CGPointMake(selfxposition+250, selfyposition+80);
    monsternode.zPosition=1;
    monsternode.xScale=0.8;
    monsternode.yScale=0.8;
    monsternode.name=@"monster";
    monsternode.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 20, 30)];
    monsternode.physicsBody.dynamic=NO;
    monsternode.physicsBody.categoryBitMask=monsterCategory;
    //monsternode.physicsBody.collisionBitMask=heroCategory;
    //monsternode.physicsBody.contactTestBitMask=heroCategory;
    return monsternode;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    //for (UITouch *touch in touches) {
    //CGPoint location = [touch locationInNode:self];
    //if (location.x>=500) {
    NSLog(@"ready to jump");
//    _playerSprite.physicsBody.dynamic=NO;
//    SKAction *jumpup=[SKAction moveToY:300 duration:1.5];
//     SKAction *jumpdown=[SKAction moveToY:180 duration:0.5];
//     SKAction *jump=[SKAction sequence:@[jumpup,jumpdown]];
//     [_playerSprite removeActionForKey:@"walk"];
//     [_playerSprite runAction:jumpup withKey:@"jump"];
    //SKPhysicsBody *gojump=[SKPhysicsBody ]
    ///[_playerSprite removeActionForKey:@"jump"] ;
    //[_playerSprite runAction:_runForever withKey:@"walk"];
    if([_playerSprite hasActions]){
//    通过脉冲力来完成跳跃
        [_playerSprite runAction:[SKAction playSoundFileNamed:@"jump.wav" waitForCompletion:YES]];
    [ _playerSprite.physicsBody applyImpulse:CGVectorMake(-10, 0)];
    [ _playerSprite.physicsBody applyImpulse:CGVectorMake(10, 400)];
    [_playerSprite removeActionForKey:@"walk"];
    }
    
    // }
    
    
    
    //}
}
-(void)addStageNode{
    int i=_stagecounts%3;//余三运算决定用哪副图片来生成精灵
    int b=arc4random()%2;//随机数产生来决定stage的高度
    float stagehigh;
    NSString *name=[NSString stringWithFormat:@"map%d",i];
    SKSpriteNode *stagenode=[SKSpriteNode spriteNodeWithImageNamed:name];
    stagenode.anchorPoint=CGPointZero;
    if (b==0) {
        stagenode.position=CGPointMake(self.size.width+10*i, littestagehigh);
        stagehigh=140;
    }else{
        stagenode.position=CGPointMake(self.size.width+10*i,bigstagehigh);
        stagehigh=130;
    }
    if (i==0) {
        stagenode.size=CGSizeMake(500, 480);
        stagenode.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 460, stagehigh)];
    }
    if (i==1) {
        stagenode.size=CGSizeMake(480, 480);
        stagenode.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 440, stagehigh)];
    }
    if (i==2) {
        stagenode.size=CGSizeMake(400, 480);
        stagenode.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 360, stagehigh)];
    }
    stagenode.physicsBody.categoryBitMask=stageCategory;
    [stagenode addChild:[self addmonster:50*i andy:stagehigh-50]];
    stagenode.zPosition=1;
    //stagenode.xScale=0.9;
    stagenode.name=@"stage";
    [self addChild:stagenode];
    _stagecounts++;
    SKAction *stageaction=[SKAction moveToX:-600 duration:16];
    [stagenode runAction:stageaction withKey:@"movestage"];
}

#pragma mark - SKPhysicsContactDelegate
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & heroCategory) && (secondBody.categoryBitMask & monsterCategory)) {
        [_playerSprite removeFromParent];
        [self enumerateChildNodesWithName:@"stage" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeActionForKey:@"movestage"];
        }];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"heroDied1" ofType:@"sks"];
        SKEmitterNode *explosion=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        explosion.numParticlesToEmit=20;
        explosion.position=contact.contactPoint;
        explosion.zPosition=4;
        [self.scene addChild:explosion];
//        SKAction *wait=[SKAction waitForDuration:300];
////        [self runAction:wait];
        SKScene * endScene = [[EndScene alloc] initWithSize:self.size];
        SKTransition *doors= [SKTransition doorsOpenVerticalWithDuration:1];
////        [self.view runAciton:wait];
        [self.view presentScene:endScene transition:doors];
    }
    if((firstBody.categoryBitMask & heroCategory) && (secondBody.categoryBitMask & stageCategory )){
        [_playerSprite runAction:_runForever withKey:@"walk"];
        
    }
//         玩家在地面上的时候执行奔跑动作，否则不执行奔跑动作
    
    //[_playerSprite removeFromParent];
    //[self enumerateChildNodesWithName:@"stage" usingBlock:^(SKNode *node, BOOL *stop) {
    //  [node removeActionForKey:@"movestage"];
    //}];
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self enumerateChildNodesWithName:@"stage" usingBlock:^(SKNode *node, BOOL *stop) {
        //node.
        if (node.position.x <= -500) {
            [node removeFromParent];
            [self addStageNode];
            *stop=YES;
            _score++;
            _scoreLabel.text=[NSString stringWithFormat:@"%ld",(long)_score];
            return;
        }
        
    }];
    [self enumerateChildNodesWithName:@"hero" usingBlock:^(SKNode *node,BOOL *stop){
        if (node.position.y<=0|node.position.x<=0) {
            SKScene * endScene = [[EndScene alloc] initWithSize:self.size];
            SKTransition *doors= [SKTransition doorsOpenVerticalWithDuration:1];
            [self.view presentScene:endScene transition:doors];
        }
    }];
}
//func moveBackground() {
//    enumerateChildNodesWithName("background") { node, _ in
//        let background = node as SKSpriteNode                                          //将node转换为SKSpriteNode
//        let backgroundVelocity =CGPoint(x: -self.backgroundMovePointsPerSec, y: 0)  //背景的速度
//        let amountToMove = backgroundVelocity * CGFloat(self.dt)                                         //偏移量
//        background.position += amountToMove                                                                    //背景的位置
//    }
//}
//
//override func update(currentTime: NSTimeInterval) {
//    //判断lastUpdateTime是否大于0
//    if lastUpdateTime > 0 {
//        dt = currentTime - lastUpdateTime
//    } else {
//        dt = 0
//    }
//    lastUpdateTime = currentTime
//    moveBackground()                                                          //调用
//}


@end
