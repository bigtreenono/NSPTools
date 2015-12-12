# TLAttributedLabel
可支持JSON配置的CoreText

## TLAttributeConfig 属性的配置，配置好属性后传入TLFrameParser对应的方法中即可，可默认为空

## JSON文件配置的使用
TLAttributedLabel *displayText = [[TLAttributedLabel alloc] initWithFrame:self.view.bounds];
displayText.delegate = self;
[scrollView addSubview:displayText];
displayText.backgroundColor = [UIColor whiteColor];

NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
TLCoreTextData *data = [TLFrameParser parseTemplateFile:path];
displayText.data = data;
displayText.height = data.height;

## 基本使用
TLAttributedLabel *displayText = [[TLAttributedLabel alloc] initWithFrame:self.view.bounds];
displayText.backgroundColor = [UIColor whiteColor];
displayText.delegate = self;
[self.view addSubview:displayText];

// 直接赋值
TLAttributeConfig *config = [[TLAttributeConfig alloc] init];
config.textColor = [UIColor blackColor];
config.width = displayText.width;

TLCoreTextData *data = [TLFrameParser parseContent:content config:config link:@[@"小明明"]];
displayText.data = data;
displayText.height = data.height;