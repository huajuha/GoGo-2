////
////  PlayerSceneHalloween.m
////  GoGo
////
////  Created by 冯斌 on 16/3/27.
////  Copyright © 2016年 王振西. All rights reserved.
////
//
//#import "PlayerSceneHalloween.h"
//#import "EndScene.h"
//
//#define stagegapwidth 40
//#define bigstagehigh 10
//#define littestagehigh 70
//
//@implementation PlayerSceneHalloween
//
//-(void)didMoveToView:(SKView *)view {
//    
//    _backgroundSpeed=300;
//    _score=0;
//    
//    /*  SKLabelNode *myLableNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//     myLableNode.text =@"score:";
//     myLableNode.fontSize = 50;
//     myLableNode.zPosition=1;
//     myLableNode.position = CGPointMake(850,700);
//     [self addChild:myLableNode];*/
//    _scoreLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//    _scoreLabel.text=[NSString stringWithFormat:@"Score:%ld",(long)_score];
//    _scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
//    _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
//    _scoreLabel.fontSize=50;
//    _scoreLabel.zPosition=1;
//    _scoreLabel.position=CGPointMake(self.frame.size.width,self.frame.size.height);
//    [self addChild:_scoreLabel];
//    
//    //SKLabelNode *coinsLabel =[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//    _coinsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//    _coinsLabel.text=[NSString stringWithFormat:@"Coins:%ld",(long)_coins];
//    _coinsLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
//    _coinsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
//    _coinsLabel.fontSize=50;
//    _coinsLabel.zPosition=1;
//    _coinsLabel.position=CGPointMake(0,self.frame.size.height);
//    [self addChild:_coinsLabel];
//    
//    self.speed=2;
//    self.physicsWorld.contactDelegate=self;
//    
//    
//    SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:@"background"];
//    //background.anchorPoint=CGPointZero;
//    background.position = CGPointMake(CGRectGetMidX(self.frame),
//                                      CGRectGetMidY(self.frame));
//    background.size=CGSizeMake(self.size.width,self.size.height);//设置背景图片适应屏幕
//    background.zPosition=0;//设置z轴坐标，解决遮挡关系
//    background.name=@"background";
//    [self addChild:background];
//    
//    _player = [playerNode node];
//    _player.position = CGPointMake(CGRectGetMidX(self.frame)/2,CGRectGetMidY(self.frame)/1.5+19);
//    _player.zPosition = 2;
//    [self.player runAction:_player.runForever withKey:@"walk"];
//   // [self runAction:_player.runForever withKey:@"walk"];
//    [self addChild:_player];
//    
//    [self initstage];
//    _coins = 0;
//    
//    
//    
//}
//
//-(void)initstage{//初始化游戏建立三个stage
//    SKSpriteNode *stagenode_1=[SKSpriteNode spriteNodeWithImageNamed:@"map2_1"];
//    stagenode_1.size=CGSizeMake(800, 480);
//    stagenode_1.anchorPoint=CGPointZero;
//    stagenode_1.position=CGPointMake(0,bigstagehigh);
//    stagenode_1.zPosition=1;
//    stagenode_1.name=@"stage";
//    stagenode_1.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 800, 200+bigstagehigh)];
//    stagenode_1.physicsBody.dynamic=NO;
//    stagenode_1.physicsBody.categoryBitMask=stageCategory;
//    [self addChild:stagenode_1];
//    
//    SKSpriteNode *stagenode_2=[SKSpriteNode spriteNodeWithImageNamed:@"map2_2"];
//    stagenode_2.size=CGSizeMake(600, 480);
//    stagenode_2.anchorPoint=CGPointZero;
//    stagenode_2.zPosition=1;
//    stagenode_2.position=CGPointMake(900, littestagehigh);
//    stagenode_2.name=@"stage";
//    stagenode_2.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 600, 120+littestagehigh)];
//    stagenode_2.physicsBody.dynamic=NO;
//    stagenode_2.physicsBody.categoryBitMask=stageCategory;
//    
//    [stagenode_2 addChild:[self spawnCoins:CGPointMake(0, littestagehigh+50)]];//金币！！
//    [self addChild:stagenode_2];
//    
//    SKSpriteNode *stagenode_3=[SKSpriteNode spriteNodeWithImageNamed:@"map2_3"];
//    stagenode_3.size=CGSizeMake(850, 480);
//    stagenode_3.anchorPoint=CGPointZero;
//    stagenode_3.position=CGPointMake(1600,bigstagehigh);
//    stagenode_3.zPosition=1;
//    stagenode_3.name=@"stage";
//    stagenode_3.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 850, 200+bigstagehigh)];
//    stagenode_3.physicsBody.dynamic=NO;
//    stagenode_3.physicsBody.categoryBitMask=stageCategory;
//    [stagenode_3 addChild:[self addmonster:0 andy:bigstagehigh+50]];
//    [self addChild:stagenode_3];
//    
//    SKSpriteNode *stagenode_4=[SKSpriteNode spriteNodeWithImageNamed:@"map2_4"];
//    stagenode_4.size=CGSizeMake(550, 480);
//    stagenode_4.anchorPoint=CGPointZero;
//    stagenode_4.zPosition=1;
//    stagenode_4.position=CGPointMake(2550, littestagehigh);
//    stagenode_4.name=@"stage";
//    stagenode_4.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 550, 120+littestagehigh)];
//    stagenode_4.physicsBody.dynamic=NO;
//    stagenode_4.physicsBody.categoryBitMask=stageCategory;
//    [stagenode_4 addChild:[self spawnCoins:CGPointMake(0, littestagehigh+50)]];//金币！！
//    [self addChild:stagenode_4];
//    
//    SKSpriteNode *stagenode_5=[SKSpriteNode spriteNodeWithImageNamed:@"map2_5"];
//    stagenode_5.size=CGSizeMake(400, 480);
//    stagenode_5.anchorPoint=CGPointZero;
//    stagenode_5.zPosition=1;
//    stagenode_5.position=CGPointMake(3200, littestagehigh);
//    stagenode_5.name=@"stage";
//    stagenode_5.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 400, 120+littestagehigh)];
//    stagenode_5.physicsBody.dynamic=NO;
//    stagenode_5.physicsBody.categoryBitMask=stageCategory;
//    [self addChild:stagenode_5];
//    _stagecounts=5;
//    
//}
//
//-(SKSpriteNode*)addmonster: (int) selfxposition  andy:(int) selfyposition {//添加怪物的方法，怪物作为自节点加入到平台上，根据平台位置决定怪物的位置
//    SKSpriteNode *monsternode=[SKSpriteNode spriteNodeWithImageNamed:@"enemy_1"];
//    monsternode.anchorPoint=CGPointZero;
//    monsternode.position=CGPointMake(selfxposition+250, selfyposition+150+30);
//    monsternode.zPosition=1;
//    monsternode.xScale=1.2;
//    monsternode.yScale=1.2;
//    monsternode.name=@"monster";
//    monsternode.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 20, 30)];
//    monsternode.physicsBody.dynamic=NO;
//    monsternode.physicsBody.categoryBitMask=monsterCategory;
//    //monsternode.physicsBody.collisionBitMask=heroCategory;
//    //monsternode.physicsBody.contactTestBitMask=heroCategory;
//    return monsternode;
//}
//
//-(SKNode *)spawnCoins:(CGPoint )point{
//    SKNode *Coins = [SKNode node];
//    for (NSUInteger i = 0 ; i < 5; ++i) {
//        SKSpriteNode *coins =[SKSpriteNode spriteNodeWithImageNamed:@"coin"];
//        
//        coins.zPosition = 1;
//        //        coins.xScale = 0.8;
//        //        coins.yScale = 0.8;
//        coins.size=CGSizeMake(50, 70);
//        coins.position = CGPointMake(50+i*coins.size.width,point.y+120);
//        coins.name =@"coins";
//        
//        coins.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 20, 30)];
//        coins.physicsBody.dynamic = NO;
//        coins.physicsBody.categoryBitMask = coinsCategory;
//        
//        [Coins addChild:coins];
//    }
//    return Coins;//////////!!!!!!!!!!!!!!!!!!!!
//}
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
//    
//    //for (UITouch *touch in touches) {
//    //CGPoint location = [touch locationInNode:self];
//    //if (location.x>=500) {
//    NSLog(@"ready to jump");
//    if([_player hasActions]){
//        //    通过脉冲力来完成跳跃
//        [_player runAction:[SKAction playSoundFileNamed:@"jump.wav" waitForCompletion:YES]];
//        [ _player.physicsBody applyImpulse:CGVectorMake(-10, 0)];
//        [ _player.physicsBody applyImpulse:CGVectorMake(10, 400)];
//        //[_player removeActionForKey:@"walk"];
//    }
//}
//-(void)addStageNode{
//    
//    SKSpriteNode *stagenode_1=[SKSpriteNode spriteNodeWithImageNamed:@"map2_1"];
//    stagenode_1.size=CGSizeMake(800, 480);
//    stagenode_1.anchorPoint=CGPointZero;
//    stagenode_1.position=CGPointMake(1250,bigstagehigh);
//    stagenode_1.zPosition=1;
//    stagenode_1.name=@"stage";
//    stagenode_1.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 800, 200+bigstagehigh)];
//    stagenode_1.physicsBody.dynamic=NO;
//    stagenode_1.physicsBody.categoryBitMask=stageCategory;
//    [self addChild:stagenode_1];
//    
//    SKSpriteNode *stagenode_2=[SKSpriteNode spriteNodeWithImageNamed:@"map2_2"];
//    stagenode_2.size=CGSizeMake(600, 480);
//    stagenode_2.anchorPoint=CGPointZero;
//    stagenode_2.zPosition=1;
//    stagenode_2.position=CGPointMake(2150, littestagehigh);
//    stagenode_2.name=@"stage";
//    stagenode_2.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 600, 120+littestagehigh)];
//    stagenode_2.physicsBody.dynamic=NO;
//    stagenode_2.physicsBody.categoryBitMask=stageCategory;
//    [stagenode_2 addChild:[self spawnCoins:CGPointMake(0, littestagehigh+50)]];//金币！！
//    [self addChild:stagenode_2];
//    
//    SKSpriteNode *stagenode_3=[SKSpriteNode spriteNodeWithImageNamed:@"map2_3"];
//    stagenode_3.size=CGSizeMake(850, 480);
//    stagenode_3.anchorPoint=CGPointZero;
//    stagenode_3.position=CGPointMake(2850,bigstagehigh);
//    stagenode_3.zPosition=1;
//    stagenode_3.name=@"stage";
//    stagenode_3.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 850, 200+bigstagehigh)];
//    stagenode_3.physicsBody.dynamic=NO;
//    stagenode_3.physicsBody.categoryBitMask=stageCategory;
//    [stagenode_3 addChild:[self addmonster:0 andy:bigstagehigh+50]];
//    [self addChild:stagenode_3];
//    
//    SKSpriteNode *stagenode_4=[SKSpriteNode spriteNodeWithImageNamed:@"map2_4"];
//    stagenode_4.size=CGSizeMake(550, 480);
//    stagenode_4.anchorPoint=CGPointZero;
//    stagenode_4.zPosition=1;
//    stagenode_4.position=CGPointMake(3800, littestagehigh);
//    stagenode_4.name=@"stage";
//    stagenode_4.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 550, 120+littestagehigh)];
//    stagenode_4.physicsBody.dynamic=NO;
//    stagenode_4.physicsBody.categoryBitMask=stageCategory;
//    [stagenode_4 addChild:[self spawnCoins:CGPointMake(0, littestagehigh+50)]];//金币！！
//    [self addChild:stagenode_4];
//    
//    SKSpriteNode *stagenode_5=[SKSpriteNode spriteNodeWithImageNamed:@"map2_5"];
//    stagenode_5.size=CGSizeMake(400, 480);
//    stagenode_5.anchorPoint=CGPointZero;
//    stagenode_5.zPosition=1;
//    stagenode_5.position=CGPointMake(4450, littestagehigh);
//    stagenode_5.name=@"stage";
//    stagenode_5.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, 400, 120+littestagehigh)];
//    stagenode_5.physicsBody.dynamic=NO;
//    stagenode_5.physicsBody.categoryBitMask=stageCategory;
//    [self addChild:stagenode_5];
//    _stagecounts+=5;
//    
//}
//
//#pragma mark - SKPhysicsContactDelegate
//- (void)didBeginContact:(SKPhysicsContact *)contact
//{
//    
//    SKPhysicsBody *firstBody, *secondBody;
//    //  SKNode *firstBody,*secondBody;
//    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
//        firstBody = contact.bodyA;//.node;
//        secondBody = contact.bodyB;//.node;
//    } else {
//        firstBody = contact.bodyB;//.node;
//        secondBody = contact.bodyA;//.node;
//    }
//    if ((firstBody.categoryBitMask & coinsCategory) && (secondBody.categoryBitMask & heroCategory)) {
//        
//        [firstBody.node removeFromParent];
//        NSLog(@"pengzhuangjibi............................");
//        [_player runAction:_player.runForever withKey:@"walk"];
//        _coins++;
//
//        
//        _coinsLabel.text=[NSString stringWithFormat:@"Coins:%ld",(long)_coins/3];
//        
//        
//    }
//    
//    if ((firstBody.categoryBitMask & heroCategory) && (secondBody.categoryBitMask & monsterCategory)) {
//        [_player removeFromParent];
//        [self enumerateChildNodesWithName:@"stage" usingBlock:^(SKNode *node, BOOL *stop) {
//            [node removeActionForKey:@"movestage"];
//        }];
//        NSString *path=[[NSBundle mainBundle] pathForResource:@"heroDied1" ofType:@"sks"];
//        SKEmitterNode *explosion=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        explosion.numParticlesToEmit=20;
//        explosion.position=contact.contactPoint;
//        explosion.zPosition=4;
//        [self.scene addChild:explosion];
//        SKAction *wait=[SKAction waitForDuration:1];
//        
//        //        [self runAction:wait];
//        SKAction *end=[SKAction runBlock:^{
//            SKScene * endScene = [[EndScene alloc] initWithSize:self.size];
//            SKTransition *doors= [SKTransition doorsOpenVerticalWithDuration:1];
//            ////        [self.view runAciton:wait];
//            [self.view presentScene:endScene transition:doors];
//        }];
//        SKAction *go=[SKAction sequence:@[wait,end]];
//        [self runAction:go];
//        
//    }
//    if((firstBody.categoryBitMask & heroCategory) && (secondBody.categoryBitMask & stageCategory )){
//        [_player runAction:_player.runForever withKey:@"walk"];
//        
//    }
//    //         玩家在地面上的时候执行奔跑动作，否则不执行奔跑动作
//    
//    //[_playerSprite removeFromParent];
//    //[self enumerateChildNodesWithName:@"stage" usingBlock:^(SKNode *node, BOOL *stop) {
//    //  [node removeActionForKey:@"movestage"];
//    //}];
//    
//}
//-(void)moveBackground{
//    float dt=_dt;
//    [self enumerateChildNodesWithName:@"background" usingBlock:^(SKNode *node,BOOL *stop){
//        if (node.position.x==CGRectGetMidX(self.frame)) {
//            NSLog(@"init a new background");
//            SKSpriteNode *background=[[SKSpriteNode alloc]initWithImageNamed:@"background"];
//            background.size=CGSizeMake(self.size.width,self.size.height);//设置背景图片适应屏幕
//            background.position=CGPointMake(CGRectGetMaxX(self.frame)+CGRectGetMidX(self.frame),
//                                            CGRectGetMidY(self.frame));
//            background.zPosition=0;//设置z轴坐标，解决遮挡关系
//            background.name=@"background";
//            [self addChild:background];
//        }
//        if (node.position.x<=-512) {
//            [node removeFromParent];
//            SKSpriteNode *background=[[SKSpriteNode alloc]initWithImageNamed:@"background"];
//            background.size=CGSizeMake(self.size.width,self.size.height);//设置背景图片适应屏幕
//            background.position=CGPointMake(CGRectGetMaxX(self.frame)+CGRectGetMidX(self.frame),
//                                                                        CGRectGetMidY(self.frame));
//            background.zPosition=0;//设置z轴坐标，解决遮挡关系
//            background.name=@"background";
//            [self addChild:background];
//        }
//        node.position=CGPointMake(node.position.x-(_backgroundSpeed*dt/10), node.position.y);
//    }];
//    
//    
//    
//    [self enumerateChildNodesWithName:@"stage" usingBlock:^(SKNode *node,BOOL *stop){
//        //        NSLog(@"moveBackground%f  %f",dt,_dt);
//        node.position=CGPointMake(node.position.x-(_backgroundSpeed*dt), node.position.y);
//    }];
//    
//}
//
//-(void)update:(CFTimeInterval)currentTime {
//    /* Called before each frame is rendered */
//    [self enumerateChildNodesWithName:@"stage" usingBlock:^(SKNode *node, BOOL *stop){
//        
//        if (node.position.x <= -850) {
//            [node removeFromParent];
//            _stagecounts--;
//            if (_stagecounts==2) {
//                [self addStageNode];
//            }
//            // *stop=YES;
//            _score++;
//            _scoreLabel.text=[NSString stringWithFormat:@"Score:%ld",(long)_score];
//            
//            return;
//        }
//        
//    }];
//    [self enumerateChildNodesWithName:@"hero" usingBlock:^(SKNode *node,BOOL *stop){
//        if (node.position.y<=0|node.position.x<=0) {
//            SKScene * endScene = [[EndScene alloc] initWithSize:self.size];
//            SKTransition *doors= [SKTransition doorsOpenVerticalWithDuration:1];
//            [self.view presentScene:endScene transition:doors];
//        }
//    }];
//    
//    if (_lastUpdateTime>0) {
//        _dt=currentTime-_lastUpdateTime;
//    }else{
//        _lastUpdateTime=0;
//    }
//    _lastUpdateTime=currentTime;
//    [self moveBackground];
//    
//}
//
//@end
