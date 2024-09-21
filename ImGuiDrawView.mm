#import "Luu_Code/Call_func"
#define iPhone8P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define kTest   0 
//#import "Vector3.h"
@interface ImGuiDrawView () <MTKViewDelegate>
//@property (nonatomic, strong) IBOutlet MTKView *mtkView;

@property (nonatomic, strong) id <MTLDevice> device;
@property (weak, nonatomic) IBOutlet UILabel *wifiSpeedLabel;

@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@end
float headx;
float heady;
#define Red 0x990000ff
#define Green 0x9900FF00
#define Yellow 0x9900ffff
#define Blue 0x99ff0000
#define Pink 0x99eb8cfe
#define White 0xffffffff
#define Black 0xe3dac9ff
#define Bnack 0x9900ffff
#import "Quaternion.h"
#import "Vector2.h"

float defffv = 80.0f;
int currbno = 0;

using vec3 = Vector3;
Vector3 vector;

bool aimonshoot;




float NormalizeAngle (float angle){
    while (angle>360)
        angle -= 360;
    while (angle<0)
        angle += 360;
    return angle;
}


Vector3 NormalizeAngles (Vector3 angles){
    angles.x = NormalizeAngle (angles.x);
    angles.y = NormalizeAngle (angles.y);
    angles.z = NormalizeAngle (angles.z);
    return angles;
}


Vector3 ToEulerRad(Quaternion q1){
    float Rad2Deg = 360.0f / (M_PI * 2.0f);

    float sqw = q1.w * q1.w;
    float sqx = q1.x * q1.x;
    float sqy = q1.y * q1.y;
    float sqz = q1.z * q1.z;
    float unit = sqx + sqy + sqz + sqw;
    float test = q1.x * q1.w - q1.y * q1.z;
    Vector3 v;

    if (test>0.4995f*unit) {
        v.y = 2.0f * atan2f (q1.y, q1.x);
        v.x = M_PI / 2.0f;
        v.z = 0;
        return NormalizeAngles(v * Rad2Deg);
    }
    if (test<-0.4995f*unit) {
        v.y = -2.0f * atan2f (q1.y, q1.x);
        v.x = -M_PI / 2.0f;
        v.z = 0;
        return NormalizeAngles (v * Rad2Deg);
    }
    Quaternion q(q1.w, q1.z, q1.x, q1.y);
    v.y = atan2f (2.0f * q.x * q.w + 2.0f * q.y * q.z, 1 - 2.0f * (q.z * q.z + q.w * q.w)); // yaw
    v.x = asinf (2.0f * (q.x * q.z - q.w * q.y)); // pitch
    v.z = atan2f (2.0f * q.x * q.y + 2.0f * q.z * q.w, 1 - 2.0f * (q.y * q.y + q.z * q.z)); // roll
    return NormalizeAngles (v * Rad2Deg);
}
void* atu;
int HeadPercent = 17;
int NeckPercent = 37;
int BodyPercent = 47;

bool silentaim = false;
NSString* uuidRes;
NSString* uuidResb;
bool isHead,isNeck,isBody,ammo,firerate,recoil,freez,airjump,aimedPlayerHead,isAimDistanceOn,gandon = false;

bool telekill,masskill,enemyscbool,spinbot,thirdperson,teleport,aimingdata,aim,isAimBotYOn,aiming,pidor,antiaimtype,Body,Head,noclip,aadelta = false;
float thirdpersonvalue = 0; 
float scale = 0; 
float tepX = 0; 
float gandons = 30; 
float tepY = 0; 
float tepZ = 0; 
NSString *Key;
NSUserDefaults *check;
NSString *jail;
NSString *namedv;
NSString *deviceType;
NSString *bundle;
NSString *ver;
UIWindow *bonios;
UIButton *view;
UIButton *viewtd;
UIWindow *bonios1;
UIWindow *bonios2;
UIButton *view1;
UIButton *viewtd1;
UIButton *Bantenna;
UIButton *BBone;
UIButton *BBone1;

Vector3(*get_BonePositon)(void *component);



void *aimed = nullptr;
void *(*get_bipedmap)(void *nuls);
void (*set_TpsView)(void* pidoras);
int (*GetPlayerTeam)(void* player);
bool (*get_isLocal)(void* player);
int (*get_Health)(void* player);
int (*get_HealthBar)(void* player);
void (*Transform_set_localScale)(void*, Vector3);
void (*Transform_set_position)(void*, Vector3);
Vector3 (*Transform_get_position)(void*);
void *(*Component_get_transform)(void*);
int (*PlayerController_get_team)(void*);
bool (*PlayerController_get_isLocal)(void*);
Vector3 aimedBonePos = Vector3(0,0,0);
int silentfov = 40,handsX,handsY,handsZ,espdistance = 40;
Vector3 GetObjectLocation(void *object)
{
     return Transform_get_position(Component_get_transform(object));
}

float xValue, yValue;
bool RCS = false;

namespace Settings
{
    static int Tab = 1;
}

  NSString *lqicon = lqmbconfig;
    NSData* datalq = [[NSData alloc] initWithBase64EncodedString:lqicon options:0];
    UIImage* img = [UIImage imageWithData:datalq];



ImFont *_espFont;
ImFont *_iconFont;
@implementation ImGuiDrawView
static bool MenDeal = true;

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

[self cc];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    ImGui::StyleColorsDark();


ImFontConfig config;
    ImFontConfig icons_config;
    config.FontDataOwnedByAtlas = false;
    icons_config.MergeMode = true;
    icons_config.PixelSnapH = true;
    icons_config.OversampleH = 2;
    icons_config.OversampleV = 2;

    static const ImWchar icons_ranges[] = { 0xf000, 0xf3ff, 0 };

    NSString *fontPath = NSSENCRYPT("/System/Library/Fonts/Core/AvenirNext.ttc");

    _espFont = io.Fonts->AddFontFromFileTTF(fontPath.UTF8String, 40.f, &config, io.Fonts->GetGlyphRangesVietnamese());

    _iconFont = io.Fonts->AddFontFromMemoryCompressedTTF(font_awesome_data, font_awesome_size, 30.0f, &icons_config, icons_ranges);

    _iconFont->FontSize = 10;


    
    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open
{
    MenDeal = open;
}

- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}

-(void)delete
{


}


-(void)out{

[FTNotificationIndicator showNotificationWithImage:img
                                              title:@"REZ_TOP"
                                         message:@"https://t.me/REZOLVER1709 "];

timer(2) {
exit(0);
});

}

-(void)nam
{

}



-(void)cc
{

ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
bundle = [[NSBundle mainBundle] bundleIdentifier];
namedv = [[UIDevice currentDevice] name];
}


- (void)loadView
{


//gốc

    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Thực hiện bất kỳ thiết lập bổ sung nào sau khi tải chế độ xem.
    
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;


}



#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}
float GetCurrentTime() {
    auto now = std::chrono::high_resolution_clock::now();
    auto duration = now.time_since_epoch();
    return std::chrono::duration_cast<std::chrono::microseconds>(duration).count() / 1000000.0f;
}

#pragma mark - MTKViewDelegate

- (void)drawInMTKView:(MTKView*)view
{


        
    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;



    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;

    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 60);

    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];


//menu 1



    static bool show_round = false;
    static bool show_L1 = false;
    static bool show_L2 = false;
    static bool show_L3 = false;
    static bool show_L4 = false;
    static bool show_L5 = false;
    static bool show_L6 = false;
    static bool show_L7 = false;
    static bool show_L8 = false;
    static bool rezgods = false;
    static bool rezgodsz = false;
    static bool show_L11 = false;
    static bool rezgodszz = false;
    static bool show_L13 = false;
    static bool show_L14 = false;
    static bool show_L15 = false;
    static bool show_L16 = false;
    static bool show_L17 = false;
    static bool show_L18 = false;
    static bool show_L19 = false;
    static bool show_L20 = false;
    static bool show_L21 = false;
    static bool show_L22 = false;
    static bool show_L23 = false;
    static bool show_L24 = false;
    static bool show_L25 = false;
    static bool show_L26 = false;
    static bool show_L27 = false;
    static bool show_L28 = false;
    static bool show_L29 = false;
    static bool show_L30 = false;
    static bool show_L31 = false;
    static bool show_L32 = false;
    static bool show_L33 = false;
    static bool show_L34 = false;
    static bool show_L35 = false;
    static bool show_L36 = false;
    static bool show_L37 = false;
    static bool show_L38 = false;
    static bool show_L39 = false;
    static bool show_L40 = false;
    static bool show_L41 = false;
    static bool show_L42 = false;
    static bool show_L43 = false;
    static bool show_L44 = false;
    static bool show_L45 = false;
    static bool show_L46 = false;
    static bool show_L47 = false;
    static bool show_L48 = false;
    static bool show_L49 = false;
    static bool show_L50 = false;
    static bool show_L51 = false;
    static bool show_L52 = false;
    static bool show_L53 = false;
    static bool show_L54 = false;
    static bool show_L55 = false;
    static bool show_L56 = false;
    static bool show_L57 = false;
    static bool show_L58 = false;
    static bool show_L59 = false;
    static bool show_L60 = false;
    static bool show_L61 = false;
    static bool show_L62 = false;
    static bool show_L63 = false;
    static bool show_L64 = false;
    static bool show_L65 = false;
    static bool show_L66 = false;
 
if(!alr) {

setup();

 alr = true;
}

//igg
    static bool igg1 = false; 
    static bool igg2 = false; 
    static bool igg3 = false; 
    static bool igg4 = false; 
    static bool igg5 = false; 
    static bool igg6 = false; 
  
    static bool igg8 = false; 
    static bool igg9 = false; 
    static bool igg10 = false; 
    static bool igg11 = false; 
    static bool igg12 = false; 
    static bool igg13 = false; 
    static bool igg14 = false; 
    static bool check_L9 = false; 
    static bool igg16 = false; 
    static bool igg17 = false; 
    static bool igg18 = false; 
    static bool igg19 = false; 
    static bool igg20 = false; 
    static bool igg21 = false; 
  static bool espline = false;
    static bool espbox = false;
    static bool esphealth = false;
    static bool aimbody = false;
    static bool aimhead = false;
    static bool silent = false;
    static bool skinp3501 = false;
    static bool skinp3502 = false;
    static bool skinp3503 = false;
    static bool awp1 = false;

    static bool awp3 = false;
    static bool show_s12 = false;     
    

    
    
    static bool Invisible = false;
    static bool floatt = false;
    static bool moneyhack = false;
    static bool teamradar = false;
    static bool buyanywhere = false;
    static bool givehelmet = false;
    static bool infinityjump = false;
    static bool alwaysrespawn = false;
    static bool dontreturnspawn = false;
    static bool unlimitedamo = false;
    static bool wallshoot = false;
    static bool firerate = false;
    static bool aiming = false;
//Define active function
    static bool show_s0_active = false;
    static int tabb = 0;
    static float boxSizeX = 4;
  
    static float boxSizeY = 6;
    static float Smoothnesshead = 44;
    static float Smoothnessbody = 73;
    static float radiussilent = 73;
 

static int a = 10;
static int b = 5;
static int c = 10;
static int d = 4;
//static int e = 10;

static int circle_size = 330;
static int slider_i = 0;

static bool bai = true;
//account
static bool logoutkey = false;
static bool exitgame = false;
static bool cleardata = false;
static bool luu_y = false;
        //
        if (MenDeal == true) {
            [self.view setUserInteractionEnabled:YES];
        } else if (MenDeal == false) {
            [self.view setUserInteractionEnabled:NO];
        }
 MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
        if (renderPassDescriptor != nil)
        {
            id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
            [renderEncoder pushDebugGroup:@"ImGui Jane"];

            ImGui_ImplMetal_NewFrame(renderPassDescriptor);
            ImGui::NewFrame();
            
            ImFont* font = ImGui::GetFont();
            font->Scale = 15.f / font->FontSize;
            
            CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 360) / 2;
            CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 300) / 2;
            
            ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
            ImGui::SetNextWindowSize(ImVec2(420, 200), ImGuiCond_FirstUseEver);
            
            
            
            // Получите текущее время или значеныие, которое меняется каждый кадр
            float time = GetCurrentTime(); // Например, здесь используется текущее время

            // Задайте период и частоту изменения цвета бордера
            float period = 5.0f; // Период, через который меняется цвет
            float frequency = 0.5f; // Частота изменения цвета

            // Вычислите значения компонентов цвета (R, G, B) для бордера на текущем кадре
            float red = (sinf(frequency * time + 0.0f) * 0.5f + 0.5f) * 0.8f;    // Здесь меняется красный канал (от 0.0f до 0.8f)
            float green = (sinf(frequency * time + 2.0f) * 0.5f + 0.5f) * 0.8f;  // Здесь меняется зеленый канал (от 0.0f до 0.8f)
            float blue = (sinf(frequency * time + 4.0f) * 0.5f + 0.5f) * 0.8f;   // Здесь меняется синий канал (от 0.0f до 0.8f)



               
            if (MenDeal == true)
            {                

     ImGui::Begin("Standoff 2 0.24.3             REZOLVER", &MenDeal);

 ImGui::SameLine(0.f, 2.f);
                ImGui::PushStyleColor(ImGuiCol_Border, ImVec4(red, green, blue, 1.0f)); // Зелено-салатовый кислотный цвет  Изменяем цвет бордера на красный (RGBA)
                ImGui::PushStyleColor(ImGuiCol_TitleBg, ImVec4(red, green, blue, 1.0f)); // Цвет фона заголовка (ярко циановый)
                ImGui::PushStyleColor(ImGuiCol_TitleBgActive, ImVec4(red, green, blue, 1.0f)); // Цвет активного фона заголовка (ярко циановый)
ImGui::Columns(2);
ImGui::SetColumnOffset(1, 130);
           

                    if (ImGui::Button(ICON_FA_EYE" VISUAL", ImVec2(120,50)))
                    Settings::Tab = 1;
                    
                    
                    
                    if (ImGui::Button(ICON_FA_CROSSHAIRS" AIM MENU", ImVec2(120,50)))
                    Settings::Tab = 2;
                
                    
                    if (ImGui::Button(ICON_FA_ID_CARD" Info", ImVec2(120,50)))
                    Settings::Tab = 3;
                    
                    
                    if (ImGui::Button(ICON_FA_ENVELOPE" Support", ImVec2(120,50)))
                    Settings::Tab = 4;

ImGui::Spacing(); 
                
                ImGui::Spacing(); 
                ImGui::Text(ICON_FA_TELEGRAM" TELEGRAM");
                ImGui::Text("@Rezolver");
                    
                    
    

        
ImGui::NextColumn();
            
                                   if (Settings::Tab == 1) {
 ImGui::Checkbox("telekill",&telekill);
 ImGui::Checkbox("masskill",&masskill);
 ImGui::Checkbox("Unlimited",&rezgods);
 ImGui::Checkbox("Unlimitzz",&rezgodsz);

 ImGui::Checkbox("Unlimitzed",&rezgodszz);
ImGui::Checkbox("triger bot",&aim);
           
                      ImGui::Checkbox("HeadZ",&Head);
                        ImGui::Checkbox("BodyZ",&Body);
                        ImGui::Checkbox("aim LEGIT",&gandon);
                          ImGui::SliderFloat("leigit aim", &gandons, 30.0f, 100.0f);
            
             

                         ImGui::Checkbox("teleportZ", &teleport);                          
                        if(teleport){
                        ImGui::SliderFloat("X", &tepX, 0.0f, 100.0f); // Пример значений 0 и 10, вы можете настроить их по своему усмотрению
                        ImGui::SliderFloat("Y", &tepY, 0.0f, 100.0f);
                        ImGui::SliderFloat("Z", &tepZ, 0.0f, 100.0f); // Пример значений 0 и 10, вы можете настроить их по своему усмотрению
                        }
              


                      ImGui::Checkbox("big enemy", &enemyscbool);
                    if (enemyscbool) {
                        ImGui::SliderFloat("scalemilno", &scale, 0.0f, 60.0f); // Пример значений 0 и 10, вы можете настроить их по своему усмотрению
                       
                    }

                      ImGui::Checkbox("Third Person", &thirdperson);
                    if (thirdperson) {
                        ImGui::SliderFloat("Third Person Distance", &thirdpersonvalue, 0.0f, 30.0f); // Пример значений 0 и 10, вы можете настроить их по своему усмотрению
                       
                    }

                           ImGui::Checkbox("spinbot", &spinbot);
                    if (spinbot) {
                        ImGui::Checkbox("delta", &aadelta);
                        ImGui::SliderFloat("spinbot Y", &bodyY, 0.0f, 200.0f); 
                        ImGui::SliderFloat("spinbot Z", &bodyZ, 0.0f, 200.0f);
                        ImGui::SliderFloat("spinbot X", &bodyX, 0.0f, 200.0f);

                        ImGui::SliderFloat("spin Y", &zxcY, 0.0f, 200.0f); 
                        ImGui::SliderFloat("spin Z", &zxcZ, 0.0f, 200.0f);
                        ImGui::SliderFloat("spin X", &zxcX, 0.0f, 200.0f);

                            }



}


            
                                   if (Settings::Tab == 2) {


                    
                    
                }

                                   if (Settings::Tab == 3) {



              
}
}


                                   
    ImGui::End();
                                            
                                                
        

            ImDrawList* draw_list = ImGui::GetBackgroundDrawList();

            if (show_round) draw_list->AddCircle(ImVec2(kWidth/2, kHeight/2), circle_size, 0xFCF007);




//màu menu


//màu button


  static double s0 = 0.0;//0.0
  ImGui::PushStyleColor(ImGuiCol_Button, ImCandy::Rainbow(s0));


    ImGuiStyle& Style = ImGui::GetStyle();
Style.WindowBorderSize = 1;
Style.FrameBorderSize = 0.1f;  
Style.TabBorderSize = 1;

Style.FrameRounding = 3;
Style.GrabRounding = 3;
Style.TabRounding = 3;
Style.ScrollbarSize = 22.5f;
Style.ScrollbarRounding = 3.0f;
Style.WindowRounding = 3.0f;
        
Style.WindowTitleAlign = ImVec2(0.5, 0.5);
Style.ButtonTextAlign = ImVec2(0.5,0.5);
Style.FramePadding = ImVec2(4, 4);


ImVec4* colors = ImGui::GetStyle().Colors;

//Transparan
colors[ImGuiCol_FrameBg]               = ImColor(0, 0, 0, 100);
colors[ImGuiCol_FrameBgActive]         = ImColor(0, 0, 0, 100);
colors[ImGuiCol_FrameBgHovered]
= ImColor(0, 0, 0, 100);
colors[ImGuiCol_PopupBg]               = ImColor(0, 0, 0, 100);
colors[ImGuiCol_Separator] = ImVec4(0, 0, 0, 0);

ImGuiStyle *style = &ImGui::GetStyle();
                   
        style->Colors[ImGuiCol_Text]                  = ImColor(255, 255, 255, 255);
        style->Colors[ImGuiCol_WindowBg]              = ImColor(0, 0, 0, 255);
        style->Colors[ImGuiCol_FrameBg]               = ImColor(219, 20, 61, 255);
        style->Colors[ImGuiCol_FrameBgActive]               = ImColor(219, 20, 61, 255);
        style->Colors[ImGuiCol_FrameBgHovered]               = ImColor(219, 20, 61, 255);
        style->Colors[ImGuiCol_PopupBg]               = ImColor(77, 37, 46, 255);
        style->Colors[ImGuiCol_Button]                   = ImColor(219, 20, 61, 255);
        style->Colors[ImGuiCol_ButtonActive]             = ImColor(219, 20, 61, 255);
        style->Colors[ImGuiCol_ButtonHovered]            = ImColor(219, 20, 61, 255);
        style->Colors[ImGuiCol_TitleBg]               = ImColor(77, 37, 46, 255);
        style->Colors[ImGuiCol_TitleBgActive]         = ImColor(77, 37, 46, 255);
        style->Colors[ImGuiCol_TitleBgCollapsed]      = ImColor(77, 37, 46, 255);
        style->Colors[ImGuiCol_CheckMark]             = ImColor(255, 255, 255, 255);



//////////////////////////////////////////////////////////////////////////////
// если чо так тут функции пишутся 
/*
static bool rezgodsz = NO;
if(rezgods)
    {
         if (!rezgodsz) {
patchOffset(ENCRYPTOFFSET("0x1D215B0"), ENCRYPTHEX("0xC0035FD6"));

                   rezgodsz = YES;    
       } 
    } else {
         if (rezgodsz) { 
patchOffset(ENCRYPTOFFSET("0x1D215B0"), ENCRYPTHEX("0xFD7BBFA9"));  //а это не просто оффсет типо вкл выкл а надо качать прогу на пк там искать оффсет который находиться он в hex

rezgodsz = NO;
       }
    }


static bool zxc = NO;
if(rezgodsz)
    {
         if (!zxc) {
patchOffset(ENCRYPTOFFSET("0x1D20D60"), ENCRYPTHEX("0xC0035FD6"));

                   zxc = YES;    
       } 
    } else {
         if (zxc) { 
patchOffset(ENCRYPTOFFSET("0x1D20D60"), ENCRYPTHEX("0xFD7BBFA9"));

zxc = NO;
       }
    }



static bool zxzc = NO;
if(rezgodszz)
    {
         if (!zxzc) {
patchOffset(ENCRYPTOFFSET("0x1E65540"), ENCRYPTHEX("0x00F0271EC0035FD6"));

                   zxzc = YES;    
       } 
    } else {
         if (zxzc) { 
patchOffset(ENCRYPTOFFSET("0x1E65540"), ENCRYPTHEX("0x00F0271EC0035FD6"));

zxzc = NO;
       }
    }

*/

 




            ImGui::Render();
            ImDrawData* draw_data = ImGui::GetDrawData();
            ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);
          
            [renderEncoder popDebugGroup];
            [renderEncoder endEncoding];

            [commandBuffer presentDrawable:view.currentDrawable];
        }

        [commandBuffer commit];
}







//offset here 





Vector3 whereToShoot;
Vector3 delta;






bool shooted;
void* (*get_BipedMap)(void* bone);
void *get_head(void *player) {
    return *(void **)((uint64_t) get_BipedMap(player) + 0xC);
}

void *get_neck(void *player) {
    return *(void **)((uint64_t) get_BipedMap(player) + 0x14);
}
void *get_hip(void *player) {
    return *(void **)((uint64_t) get_BipedMap(player) + 0x3C);
}

- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{
    
}
void (*set_position)(void *transform, Vector3 value);



static void *get_aim(void *player) {
    return *(void **)((uint64_t) player + 0x60);
}
void *defAimedPlayer = nullptr;


float headintaim = 1.0f;
void *(*get_main)();
#define INIT_F(x,y) *(void **) (&x) = (void*) getRealOffset(y)
Vector3(*Transform$$get_forward)(void* a);
bool alr = false;

void setup() {
INIT_F(Transform$$get_forward, 0x348FE24);//новый
INIT_F(set_TpsView, 0x1AFD768);
INIT_F(get_bipedmap, 0x1AFD768);
//INIT_F(get_main, 0x34653DC);
 *(void **)&get_main = (void *) getRealOffset(0x34653DC);
   INIT_F(set_position, 0x348F8EC);//новый
   // HOOK(0x1B00624, LateUpdate, old_CameraControllerFPS_LateUpdate);//новый
Transform_get_position = (Vector3 (*)(void*))getRealOffset(0x348F83C);
get_rotation = (Quaternion (*)(void*))getRealOffset(0x348FB18);
_get_position = (void (*)(void *, Vector3 *))getRealOffset(0x348F83C);
Transform_set_position = (void (*)(void*, Vector3))getRealOffset(0x348F8EC);
Component_get_transform = (void* (*)(void*))getRealOffset(0x3485CA4);
PlayerController_get_isLocal = (bool (*)(void *)) getRealOffset(0x1AFE00C); //
PlayerController_get_team = (int (*)(void *)) getRealOffset(0x1B01720); //
HOOK(0x1B005B8, Player_Update, old_Player_Update);
Transform_set_localScale = (void (*)(void*, Vector3)) getRealOffset(0x3490098); 
set_eulerAngles = (void (*)(void*, Vector3)) getRealOffset(0x348FB74); 
HOOK(0x1B2ABD0 ,xyesos,_xyesos);
get_BipedMap = (void* (*)(void*))getRealOffset(0x1AFCB7C);
get_deltaTime = (float (*)(void*))getRealOffset(0x3481728);

get_right = (Vector3 (*)(void*))getRealOffset(0x348FD1C);




}
float flySpeed = 20;
Vector3 flypos;
float xu = 0;
float yu = 0;

bool handspos = false;

float speedSpin, downSpin, spinX, spinY;
 int zxcs = 50;
 float bodyY = 0;
     float bodyZ = 0;
    float bodyX = 0; 


 float zxcY = 0;
     float zxcZ = 0;
    float zxcX = 0;  


void *me = NULL;
void *enemy = NULL;





Vector3 get_position123(void *instance) {
    Vector3 position123;
    _get_position(instance, &position123);
    return position123;
}
void (*_get_position)(void *transform, Vector3 *out);
int (*GetPlayerHealth)(void* player);


bool IsPlayerDied(void *player) {
    if (player) {
        int health = GetPlayerHealth(player);
        if (health <= 0) {
            return true;
        }
    }
    return false;
}





Vector3 get_position(void *transform) {
    if (!transform)
        return Vector3();
    Vector3 position;
    static const auto get_position_injected = reinterpret_cast<uint64_t(__fastcall *)(void *,Vector3 &)>(getRealOffset(0x348F83C));
    get_position_injected(transform, position);
    return position;
}


void *get_transform(void *player) {
    if (!player)
        return NULL;
    static const auto get_transform_injected = reinterpret_cast<uint64_t(__fastcall *)(void *)>(getRealOffset(0x3485CA4));
    return (void *) get_transform_injected(player);
}


void *camera() {
static const auto get_camera_injected = reinterpret_cast<uint64_t(__fastcall *)()>(getRealOffset(0x34653DC));
return (void *) get_camera_injected();
}


Vector3 WorldToViewportPoint_Injected(void *transform, Vector3 test) {
    if (!transform)
        return Vector3();
    Vector3 position;
    static const auto WorldToScreenPoint_Injected = reinterpret_cast<uint64_t(__fastcall *)(void *, Vector3,  int, Vector3 &)>(getRealOffset(0x3464D7C));
    WorldToScreenPoint_Injected(transform, test, 2, position);
    return position;
}

Vector3 GetPlayerLocation(void *player) {
    Vector3 location;
    location = get_position(get_transform(player));

    return location;
}

bool IsPlayerDead(void *player) {
  if(get_Health(player) < 1) {
    return true;
  }

  return false;
}

struct player_t {
    CGRect rect;
    CGRect background;
    CGRect healthbar;
    CGPoint topofbox;
    CGPoint bottomofbox;
    CGRect box;
    CGPoint chest;
    CGPoint centerbox;
    float health;
    void* object;
    Vector3 location;
    bool *weapon;
    bool enemy;
    float distance;
    float maxHealth;
};

struct enemy_t {
void *object;
Vector3 location;
Vector3 worldtoscreen;
bool dead;
float distance;
bool enemy;
bool visible;
int health;
};


void *myPlayer = NULL;
void *enemyPlayer = NULL;


class EntityManager {
public:
    std::vector<enemy_t *> *enemies;

    EntityManager() {
        enemies = new std::vector<enemy_t *>();
    }

    bool isEnemyPresent(void *enemyObject) {
        for (std::vector<enemy_t *>::iterator it = enemies->begin(); it != enemies->end(); it++) {
            if ((*it)->object == enemyObject) {
                return true;
            }
        }

        return false;
    }

    void removeEnemy(enemy_t *enemy) {
        for (int i = 0; i < enemies->size(); i++) {
            if ((*enemies)[i] == enemy) {
                enemies->erase(enemies->begin() + i);

                return;
            }
        }
    }

    void tryAddEnemy(void *enemyObject) {
        if (isEnemyPresent(enemyObject)) {
            return;
        }

        if (IsPlayerDead(enemyObject)) {
           return;
       }

        enemy_t *newEnemy = new enemy_t();

        newEnemy->object = enemyObject;

        enemies->push_back(newEnemy);
    }

    void updateEnemies(void *enemyObject) {
        for (int i = 0; i < enemies->size(); i++) {
            enemy_t *current = (*enemies)[i];

           if(IsPlayerDead(current->object)) {
                enemies->erase(enemies->begin() + i);
           }

            
        }
    }

    void removeEnemyGivenObject(void *enemyObject) {
        for (int i = 0; i < enemies->size(); i++) {
            if ((*enemies)[i]->object == enemyObject) {
                enemies->erase(enemies->begin() + i);

                return;
            }
        }
    }
std::vector<enemy_t *> *GetAllEnemies() {
    return enemies;
  }
};


EntityManager *entityManager = new EntityManager();
bool espp;

float yyyy;
float xxxx;
float dy;
float dx;


 void (*set_eulerAngles)(void*, Vector3);
Vector3 player;
int silentDistance;
Quaternion PlayerLook;
Vector3(*get_right) (void*);

 float AngleSpeed;
 Vector3(*getAxis) (void*);
float (*get_deltaTime)(void* nul);
 Quaternion (*get_rotation)(void*);
 int SmoothValue = 5;
void (*old_Player_Update)(void *player); 
void Player_Update(void *player) { 
  if(PlayerController_get_isLocal(player)) {
std::vector<enemy_t *> *enemies = entityManager->GetAllEnemies();
UIWindow *main = [UIApplication sharedApplication].keyWindow;
void *mycam = camera();



if(get_isLocal(player)){
   me = player;

}



if(thirdperson) {
                set_TpsView(player);
            }

    me = player;
  }

  if(me != NULL) {
    if(PlayerController_get_team(me) != PlayerController_get_team(player)) {
      enemy = player;

    }

                if (masskill){
      Vector3 mypos = Transform_get_position(Component_get_transform(me));
      Transform_set_position(Component_get_transform(enemy), Vector3(mypos.x, mypos.y, mypos.z + 1.3f));
    } 





if (enemy != NULL) {
    if (aim) {
        void* aimingdata = *(void **)((uint64_t)get_aim(me) + 0x90);
        if (aimingdata) {
            Vector3 angle = ToEulerRad(PlayerLook);
            if (angle.x >= 275.0f)
                angle.x -= 360.0f;
            if (angle.x <= -275.0f)
                angle.x += 360.0f;
            *(Vector3*)((uint64_t)aimingdata + 0x18) = *(Vector3*)((uint64_t)aimingdata + 0x24) = angle;

   
        } else {
            enemy = NULL;
            return;
        }


    }}
}

if (aim) {
    PlayerLook = Quaternion::LookRotation((GetPlayerLocation(enemy) + Vector3(0, -0.40f, 0)) - GetPlayerLocation(me), Vector3(0, 1, 0) );

}


        




Vector3 antiaim;
antiaim.x = bodyY;
antiaim.y = bodyZ;
antiaim.z = bodyX;

antiaim.x = zxcY;
antiaim.y = zxcZ;
antiaim.z = zxcX;

float deltatime;
      




if (enemyscbool) {    
  // float scale = Transform_get_position(Component_get_transform(enemy));               
    Transform_set_localScale(Component_get_transform(enemy),  Vector3(scale, scale, scale));
} else {
    Transform_set_localScale(Component_get_transform(enemy), Vector3(1, 1, 1));
}





 

            if (telekill){
        Vector3 enemypos = Transform_get_position(Component_get_transform(enemy));
      Transform_set_position(Component_get_transform(me), Vector3(enemypos.x, enemypos.y, enemypos.z + 1.3f));
            
}
  
    old_Player_Update(player); 
}

void (*_xyesos)(void* player, void* player1, int player2, float player3);
void xyesos(void* player, void* player1, int player2, float player3) {



if(Body){
    *(float *)((uint64_t) player1 + 0x2C) = 2.5f;
   }

if(Head){
    *(float *)((uint64_t) player1 + 0x34) = 7.5f;
  }
  _xyesos(player, player1, player2, player3);
}





- (void)ROOTSpringYES{
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    progress.mode = MBProgressHUDModeText;
    progress.label.text = @"ioscccc";
    [self performSelector:@selector(removehProgress) withObject:nil afterDelay:1.5];
}
-(void)removehProgress{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}



@end


