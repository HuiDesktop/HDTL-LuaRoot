local ffi = require 'ffi'
ffi.cdef[[
typedef struct Vector2 {
float x;                
float y;                
} Vector2;
typedef struct Vector3 {
float x;                
float y;                
float z;                
} Vector3;
typedef struct Vector4 {
float x;                
float y;                
float z;                
float w;                
} Vector4;
typedef Vector4 Quaternion;
typedef struct Matrix {
float m0, m4, m8, m12;  
float m1, m5, m9, m13;  
float m2, m6, m10, m14; 
float m3, m7, m11, m15; 
} Matrix;
typedef struct Color {
unsigned char r;        
unsigned char g;        
unsigned char b;        
unsigned char a;        
} Color;
typedef struct Rectangle {
float x;                
float y;                
float width;            
float height;           
} Rectangle;
typedef struct Image {
void *data;             
int width;              
int height;             
int mipmaps;            
int format;             
} Image;
typedef struct Texture {
unsigned int id;        
int width;              
int height;             
int mipmaps;            
int format;             
} Texture;
typedef Texture Texture2D;
typedef Texture TextureCubemap;
typedef struct RenderTexture {
unsigned int id;        
Texture texture;        
Texture depth;          
} RenderTexture;
typedef RenderTexture RenderTexture2D;
typedef struct NPatchInfo {
Rectangle source;       
int left;               
int top;                
int right;              
int bottom;             
int layout;             
} NPatchInfo;
typedef struct GlyphInfo {
int value;              
int offsetX;            
int offsetY;            
int advanceX;           
Image image;            
} GlyphInfo;
typedef struct Font {
int baseSize;           
int glyphCount;         
int glyphPadding;       
Texture2D texture;      
Rectangle *recs;        
GlyphInfo *glyphs;      
} Font;
typedef struct Camera3D {
Vector3 position;       
Vector3 target;         
Vector3 up;             
float fovy;             
int projection;         
} Camera3D;
typedef Camera3D Camera;    
typedef struct Camera2D {
Vector2 offset;         
Vector2 target;         
float rotation;         
float zoom;             
} Camera2D;
typedef struct Mesh {
int vertexCount;        
int triangleCount;      
float *vertices;        
float *texcoords;       
float *texcoords2;      
float *normals;         
float *tangents;        
unsigned char *colors;      
unsigned short *indices;    
float *animVertices;    
float *animNormals;     
unsigned char *boneIds; 
float *boneWeights;     
unsigned int vaoId;     
unsigned int *vboId;    
} Mesh;
typedef struct Shader {
unsigned int id;        
int *locs;              
} Shader;
typedef struct MaterialMap {
Texture2D texture;      
Color color;            
float value;            
} MaterialMap;
typedef struct Material {
Shader shader;          
MaterialMap *maps;      
float params[4];        
} Material;
typedef struct Transform {
Vector3 translation;    
Quaternion rotation;    
Vector3 scale;          
} Transform;
typedef struct BoneInfo {
char name[32];          
int parent;             
} BoneInfo;
typedef struct Model {
Matrix transform;       
int meshCount;          
int materialCount;      
Mesh *meshes;           
Material *materials;    
int *meshMaterial;      
int boneCount;          
BoneInfo *bones;        
Transform *bindPose;    
} Model;
typedef struct ModelAnimation {
int boneCount;          
int frameCount;         
BoneInfo *bones;        
Transform **framePoses; 
} ModelAnimation;
typedef struct Ray {
Vector3 position;       
Vector3 direction;      
} Ray;
typedef struct RayCollision {
bool hit;               
float distance;         
Vector3 point;          
Vector3 normal;         
} RayCollision;
typedef struct BoundingBox {
Vector3 min;            
Vector3 max;            
} BoundingBox;
typedef struct Wave {
unsigned int frameCount;    
unsigned int sampleRate;    
unsigned int sampleSize;    
unsigned int channels;      
void *data;                 
} Wave;
typedef struct rAudioBuffer rAudioBuffer;
typedef struct AudioStream {
rAudioBuffer *buffer;       
unsigned int sampleRate;    
unsigned int sampleSize;    
unsigned int channels;      
} AudioStream;
typedef struct Sound {
AudioStream stream;         
unsigned int frameCount;    
} Sound;
typedef struct Music {
AudioStream stream;         
unsigned int frameCount;    
bool looping;               
int ctxType;                
void *ctxData;              
} Music;
typedef struct VrDeviceInfo {
int hResolution;                
int vResolution;                
float hScreenSize;              
float vScreenSize;              
float vScreenCenter;            
float eyeToScreenDistance;      
float lensSeparationDistance;   
float interpupillaryDistance;   
float lensDistortionValues[4];  
float chromaAbCorrection[4];    
} VrDeviceInfo;
typedef struct VrStereoConfig {
Matrix projection[2];           
Matrix viewOffset[2];           
float leftLensCenter[2];        
float rightLensCenter[2];       
float leftScreenCenter[2];      
float rightScreenCenter[2];     
float scale[2];                 
float scaleIn[2];               
} VrStereoConfig;
typedef enum {
FLAG_VSYNC_HINT         = 0x00000040,   
FLAG_FULLSCREEN_MODE    = 0x00000002,   
FLAG_WINDOW_RESIZABLE   = 0x00000004,   
FLAG_WINDOW_UNDECORATED = 0x00000008,   
FLAG_WINDOW_HIDDEN      = 0x00000080,   
FLAG_WINDOW_MINIMIZED   = 0x00000200,   
FLAG_WINDOW_MAXIMIZED   = 0x00000400,   
FLAG_WINDOW_UNFOCUSED   = 0x00000800,   
FLAG_WINDOW_TOPMOST     = 0x00001000,   
FLAG_WINDOW_ALWAYS_RUN  = 0x00000100,   
FLAG_WINDOW_TRANSPARENT = 0x00000010,   
FLAG_WINDOW_HIGHDPI     = 0x00002000,   
FLAG_WINDOW_MOUSE_PASSTHROUGH = 0x00004000,
FLAG_MSAA_4X_HINT       = 0x00000020,   
FLAG_INTERLACED_HINT    = 0x00010000    
} ConfigFlags;
typedef enum {
LOG_ALL = 0,        
LOG_TRACE,          
LOG_DEBUG,          
LOG_INFO,           
LOG_WARNING,        
LOG_ERROR,          
LOG_FATAL,          
LOG_NONE            
} TraceLogLevel;
typedef enum {
KEY_NULL            = 0,        
KEY_APOSTROPHE      = 39,       
KEY_COMMA           = 44,       
KEY_MINUS           = 45,       
KEY_PERIOD          = 46,       
KEY_SLASH           = 47,       
KEY_ZERO            = 48,       
KEY_ONE             = 49,       
KEY_TWO             = 50,       
KEY_THREE           = 51,       
KEY_FOUR            = 52,       
KEY_FIVE            = 53,       
KEY_SIX             = 54,       
KEY_SEVEN           = 55,       
KEY_EIGHT           = 56,       
KEY_NINE            = 57,       
KEY_SEMICOLON       = 59,       
KEY_EQUAL           = 61,       
KEY_A               = 65,       
KEY_B               = 66,       
KEY_C               = 67,       
KEY_D               = 68,       
KEY_E               = 69,       
KEY_F               = 70,       
KEY_G               = 71,       
KEY_H               = 72,       
KEY_I               = 73,       
KEY_J               = 74,       
KEY_K               = 75,       
KEY_L               = 76,       
KEY_M               = 77,       
KEY_N               = 78,       
KEY_O               = 79,       
KEY_P               = 80,       
KEY_Q               = 81,       
KEY_R               = 82,       
KEY_S               = 83,       
KEY_T               = 84,       
KEY_U               = 85,       
KEY_V               = 86,       
KEY_W               = 87,       
KEY_X               = 88,       
KEY_Y               = 89,       
KEY_Z               = 90,       
KEY_LEFT_BRACKET    = 91,       
KEY_BACKSLASH       = 92,       
KEY_RIGHT_BRACKET   = 93,       
KEY_GRAVE           = 96,       
KEY_SPACE           = 32,       
KEY_ESCAPE          = 256,      
KEY_ENTER           = 257,      
KEY_TAB             = 258,      
KEY_BACKSPACE       = 259,      
KEY_INSERT          = 260,      
KEY_DELETE          = 261,      
KEY_RIGHT           = 262,      
KEY_LEFT            = 263,      
KEY_DOWN            = 264,      
KEY_UP              = 265,      
KEY_PAGE_UP         = 266,      
KEY_PAGE_DOWN       = 267,      
KEY_HOME            = 268,      
KEY_END             = 269,      
KEY_CAPS_LOCK       = 280,      
KEY_SCROLL_LOCK     = 281,      
KEY_NUM_LOCK        = 282,      
KEY_PRINT_SCREEN    = 283,      
KEY_PAUSE           = 284,      
KEY_F1              = 290,      
KEY_F2              = 291,      
KEY_F3              = 292,      
KEY_F4              = 293,      
KEY_F5              = 294,      
KEY_F6              = 295,      
KEY_F7              = 296,      
KEY_F8              = 297,      
KEY_F9              = 298,      
KEY_F10             = 299,      
KEY_F11             = 300,      
KEY_F12             = 301,      
KEY_LEFT_SHIFT      = 340,      
KEY_LEFT_CONTROL    = 341,      
KEY_LEFT_ALT        = 342,      
KEY_LEFT_SUPER      = 343,      
KEY_RIGHT_SHIFT     = 344,      
KEY_RIGHT_CONTROL   = 345,      
KEY_RIGHT_ALT       = 346,      
KEY_RIGHT_SUPER     = 347,      
KEY_KB_MENU         = 348,      
KEY_KP_0            = 320,      
KEY_KP_1            = 321,      
KEY_KP_2            = 322,      
KEY_KP_3            = 323,      
KEY_KP_4            = 324,      
KEY_KP_5            = 325,      
KEY_KP_6            = 326,      
KEY_KP_7            = 327,      
KEY_KP_8            = 328,      
KEY_KP_9            = 329,      
KEY_KP_DECIMAL      = 330,      
KEY_KP_DIVIDE       = 331,      
KEY_KP_MULTIPLY     = 332,      
KEY_KP_SUBTRACT     = 333,      
KEY_KP_ADD          = 334,      
KEY_KP_ENTER        = 335,      
KEY_KP_EQUAL        = 336,      
KEY_BACK            = 4,        
KEY_MENU            = 82,       
KEY_VOLUME_UP       = 24,       
KEY_VOLUME_DOWN     = 25        
} KeyboardKey;
typedef enum {
MOUSE_BUTTON_LEFT    = 0,       
MOUSE_BUTTON_RIGHT   = 1,       
MOUSE_BUTTON_MIDDLE  = 2,       
MOUSE_BUTTON_SIDE    = 3,       
MOUSE_BUTTON_EXTRA   = 4,       
MOUSE_BUTTON_FORWARD = 5,       
MOUSE_BUTTON_BACK    = 6,       
} MouseButton;
typedef enum {
MOUSE_CURSOR_DEFAULT       = 0,     
MOUSE_CURSOR_ARROW         = 1,     
MOUSE_CURSOR_IBEAM         = 2,     
MOUSE_CURSOR_CROSSHAIR     = 3,     
MOUSE_CURSOR_POINTING_HAND = 4,     
MOUSE_CURSOR_RESIZE_EW     = 5,     
MOUSE_CURSOR_RESIZE_NS     = 6,     
MOUSE_CURSOR_RESIZE_NWSE   = 7,     
MOUSE_CURSOR_RESIZE_NESW   = 8,     
MOUSE_CURSOR_RESIZE_ALL    = 9,     
MOUSE_CURSOR_NOT_ALLOWED   = 10     
} MouseCursor;
typedef enum {
GAMEPAD_BUTTON_UNKNOWN = 0,         
GAMEPAD_BUTTON_LEFT_FACE_UP,        
GAMEPAD_BUTTON_LEFT_FACE_RIGHT,     
GAMEPAD_BUTTON_LEFT_FACE_DOWN,      
GAMEPAD_BUTTON_LEFT_FACE_LEFT,      
GAMEPAD_BUTTON_RIGHT_FACE_UP,       
GAMEPAD_BUTTON_RIGHT_FACE_RIGHT,    
GAMEPAD_BUTTON_RIGHT_FACE_DOWN,     
GAMEPAD_BUTTON_RIGHT_FACE_LEFT,     
GAMEPAD_BUTTON_LEFT_TRIGGER_1,      
GAMEPAD_BUTTON_LEFT_TRIGGER_2,      
GAMEPAD_BUTTON_RIGHT_TRIGGER_1,     
GAMEPAD_BUTTON_RIGHT_TRIGGER_2,     
GAMEPAD_BUTTON_MIDDLE_LEFT,         
GAMEPAD_BUTTON_MIDDLE,              
GAMEPAD_BUTTON_MIDDLE_RIGHT,        
GAMEPAD_BUTTON_LEFT_THUMB,          
GAMEPAD_BUTTON_RIGHT_THUMB          
} GamepadButton;
typedef enum {
GAMEPAD_AXIS_LEFT_X        = 0,     
GAMEPAD_AXIS_LEFT_Y        = 1,     
GAMEPAD_AXIS_RIGHT_X       = 2,     
GAMEPAD_AXIS_RIGHT_Y       = 3,     
GAMEPAD_AXIS_LEFT_TRIGGER  = 4,     
GAMEPAD_AXIS_RIGHT_TRIGGER = 5      
} GamepadAxis;
typedef enum {
MATERIAL_MAP_ALBEDO    = 0,     
MATERIAL_MAP_METALNESS,         
MATERIAL_MAP_NORMAL,            
MATERIAL_MAP_ROUGHNESS,         
MATERIAL_MAP_OCCLUSION,         
MATERIAL_MAP_EMISSION,          
MATERIAL_MAP_HEIGHT,            
MATERIAL_MAP_CUBEMAP,           
MATERIAL_MAP_IRRADIANCE,        
MATERIAL_MAP_PREFILTER,         
MATERIAL_MAP_BRDF               
} MaterialMapIndex;
typedef enum {
SHADER_LOC_VERTEX_POSITION = 0, 
SHADER_LOC_VERTEX_TEXCOORD01,   
SHADER_LOC_VERTEX_TEXCOORD02,   
SHADER_LOC_VERTEX_NORMAL,       
SHADER_LOC_VERTEX_TANGENT,      
SHADER_LOC_VERTEX_COLOR,        
SHADER_LOC_MATRIX_MVP,          
SHADER_LOC_MATRIX_VIEW,         
SHADER_LOC_MATRIX_PROJECTION,   
SHADER_LOC_MATRIX_MODEL,        
SHADER_LOC_MATRIX_NORMAL,       
SHADER_LOC_VECTOR_VIEW,         
SHADER_LOC_COLOR_DIFFUSE,       
SHADER_LOC_COLOR_SPECULAR,      
SHADER_LOC_COLOR_AMBIENT,       
SHADER_LOC_MAP_ALBEDO,          
SHADER_LOC_MAP_METALNESS,       
SHADER_LOC_MAP_NORMAL,          
SHADER_LOC_MAP_ROUGHNESS,       
SHADER_LOC_MAP_OCCLUSION,       
SHADER_LOC_MAP_EMISSION,        
SHADER_LOC_MAP_HEIGHT,          
SHADER_LOC_MAP_CUBEMAP,         
SHADER_LOC_MAP_IRRADIANCE,      
SHADER_LOC_MAP_PREFILTER,       
SHADER_LOC_MAP_BRDF             
} ShaderLocationIndex;
typedef enum {
SHADER_UNIFORM_FLOAT = 0,       
SHADER_UNIFORM_VEC2,            
SHADER_UNIFORM_VEC3,            
SHADER_UNIFORM_VEC4,            
SHADER_UNIFORM_INT,             
SHADER_UNIFORM_IVEC2,           
SHADER_UNIFORM_IVEC3,           
SHADER_UNIFORM_IVEC4,           
SHADER_UNIFORM_SAMPLER2D        
} ShaderUniformDataType;
typedef enum {
SHADER_ATTRIB_FLOAT = 0,        
SHADER_ATTRIB_VEC2,             
SHADER_ATTRIB_VEC3,             
SHADER_ATTRIB_VEC4              
} ShaderAttributeDataType;
typedef enum {
PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1, 
PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,    
PIXELFORMAT_UNCOMPRESSED_R5G6B5,        
PIXELFORMAT_UNCOMPRESSED_R8G8B8,        
PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,      
PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,      
PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,      
PIXELFORMAT_UNCOMPRESSED_R32,           
PIXELFORMAT_UNCOMPRESSED_R32G32B32,     
PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,  
PIXELFORMAT_COMPRESSED_DXT1_RGB,        
PIXELFORMAT_COMPRESSED_DXT1_RGBA,       
PIXELFORMAT_COMPRESSED_DXT3_RGBA,       
PIXELFORMAT_COMPRESSED_DXT5_RGBA,       
PIXELFORMAT_COMPRESSED_ETC1_RGB,        
PIXELFORMAT_COMPRESSED_ETC2_RGB,        
PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,   
PIXELFORMAT_COMPRESSED_PVRT_RGB,        
PIXELFORMAT_COMPRESSED_PVRT_RGBA,       
PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA,   
PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA    
} PixelFormat;
typedef enum {
TEXTURE_FILTER_POINT = 0,               
TEXTURE_FILTER_BILINEAR,                
TEXTURE_FILTER_TRILINEAR,               
TEXTURE_FILTER_ANISOTROPIC_4X,          
TEXTURE_FILTER_ANISOTROPIC_8X,          
TEXTURE_FILTER_ANISOTROPIC_16X,         
} TextureFilter;
typedef enum {
TEXTURE_WRAP_REPEAT = 0,                
TEXTURE_WRAP_CLAMP,                     
TEXTURE_WRAP_MIRROR_REPEAT,             
TEXTURE_WRAP_MIRROR_CLAMP               
} TextureWrap;
typedef enum {
CUBEMAP_LAYOUT_AUTO_DETECT = 0,         
CUBEMAP_LAYOUT_LINE_VERTICAL,           
CUBEMAP_LAYOUT_LINE_HORIZONTAL,         
CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR,     
CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE,     
CUBEMAP_LAYOUT_PANORAMA                 
} CubemapLayout;
typedef enum {
FONT_DEFAULT = 0,               
FONT_BITMAP,                    
FONT_SDF                        
} FontType;
typedef enum {
BLEND_ALPHA = 0,                
BLEND_ADDITIVE,                 
BLEND_MULTIPLIED,               
BLEND_ADD_COLORS,               
BLEND_SUBTRACT_COLORS,          
BLEND_CUSTOM                    
} BlendMode;
typedef enum {
GESTURE_NONE        = 0,        
GESTURE_TAP         = 1,        
GESTURE_DOUBLETAP   = 2,        
GESTURE_HOLD        = 4,        
GESTURE_DRAG        = 8,        
GESTURE_SWIPE_RIGHT = 16,       
GESTURE_SWIPE_LEFT  = 32,       
GESTURE_SWIPE_UP    = 64,       
GESTURE_SWIPE_DOWN  = 128,      
GESTURE_PINCH_IN    = 256,      
GESTURE_PINCH_OUT   = 512       
} Gesture;
typedef enum {
CAMERA_CUSTOM = 0,              
CAMERA_FREE,                    
CAMERA_ORBITAL,                 
CAMERA_FIRST_PERSON,            
CAMERA_THIRD_PERSON             
} CameraMode;
typedef enum {
CAMERA_PERSPECTIVE = 0,         
CAMERA_ORTHOGRAPHIC             
} CameraProjection;
typedef enum {
NPATCH_NINE_PATCH = 0,          
NPATCH_THREE_PATCH_VERTICAL,    
NPATCH_THREE_PATCH_HORIZONTAL   
} NPatchLayout;
typedef void (*TraceLogCallback)(int logLevel, const char *text, va_list args);  
typedef unsigned char *(*LoadFileDataCallback)(const char *fileName, unsigned int *bytesRead);      
typedef bool (*SaveFileDataCallback)(const char *fileName, void *data, unsigned int bytesToWrite);  
typedef char *(*LoadFileTextCallback)(const char *fileName);       
typedef bool (*SaveFileTextCallback)(const char *fileName, char *text);     
void InitWindow(int width, int height, const char *title);  
bool WindowShouldClose(void);                               
void CloseWindow(void);                                     
bool IsWindowReady(void);                                   
bool IsWindowFullscreen(void);                              
bool IsWindowHidden(void);                                  
bool IsWindowMinimized(void);                               
bool IsWindowMaximized(void);                               
bool IsWindowFocused(void);                                 
bool IsWindowResized(void);                                 
bool IsWindowState(unsigned int flag);                      
void SetWindowState(unsigned int flags);                    
void ClearWindowState(unsigned int flags);                  
void ToggleFullscreen(void);                                
void MaximizeWindow(void);                                  
void MinimizeWindow(void);                                  
void RestoreWindow(void);                                   
void SetWindowIcon(Image image);                            
void SetWindowTitle(const char *title);                     
void SetWindowPosition(int x, int y);                       
void SetWindowMonitor(int monitor);                         
void SetWindowMinSize(int width, int height);               
void SetWindowSize(int width, int height);                  
void *GetWindowHandle(void);                                
int GetScreenWidth(void);                                   
int GetScreenHeight(void);                                  
int GetMonitorCount(void);                                  
int GetCurrentMonitor(void);                                
Vector2 GetMonitorPosition(int monitor);                    
int GetMonitorWidth(int monitor);                           
int GetMonitorHeight(int monitor);                          
int GetMonitorPhysicalWidth(int monitor);                   
int GetMonitorPhysicalHeight(int monitor);                  
int GetMonitorRefreshRate(int monitor);                     
Vector2 GetWindowPosition(void);                            
Vector2 GetWindowScaleDPI(void);                            
const char *GetMonitorName(int monitor);                    
void SetClipboardText(const char *text);                    
const char *GetClipboardText(void);                         
void SwapScreenBuffer(void);                                
void PollInputEvents(void);                                 
void WaitTime(float ms);                                    
void ShowCursor(void);                                      
void HideCursor(void);                                      
bool IsCursorHidden(void);                                  
void EnableCursor(void);                                    
void DisableCursor(void);                                   
bool IsCursorOnScreen(void);                                
void ClearBackground(Color color);                          
void BeginDrawing(void);                                    
void EndDrawing(void);                                      
void BeginMode2D(Camera2D camera);                          
void EndMode2D(void);                                       
void BeginMode3D(Camera3D camera);                          
void EndMode3D(void);                                       
void BeginTextureMode(RenderTexture2D target);              
void EndTextureMode(void);                                  
void BeginShaderMode(Shader shader);                        
void EndShaderMode(void);                                   
void BeginBlendMode(int mode);                              
void EndBlendMode(void);                                    
void BeginScissorMode(int x, int y, int width, int height); 
void EndScissorMode(void);                                  
void BeginVrStereoMode(VrStereoConfig config);              
void EndVrStereoMode(void);                                 
VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);     
void UnloadVrStereoConfig(VrStereoConfig config);           
Shader LoadShader(const char *vsFileName, const char *fsFileName);   
Shader LoadShaderFromMemory(const char *vsCode, const char *fsCode); 
int GetShaderLocation(Shader shader, const char *uniformName);       
int GetShaderLocationAttrib(Shader shader, const char *attribName);  
void SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType);               
void SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count);   
void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);         
void SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture); 
void UnloadShader(Shader shader);                                    
Ray GetMouseRay(Vector2 mousePosition, Camera camera);      
Matrix GetCameraMatrix(Camera camera);                      
Matrix GetCameraMatrix2D(Camera2D camera);                  
Vector2 GetWorldToScreen(Vector3 position, Camera camera);  
Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height); 
Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera); 
Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera); 
void SetTargetFPS(int fps);                                 
int GetFPS(void);                                           
float GetFrameTime(void);                                   
double GetTime(void);                                       
int GetRandomValue(int min, int max);                       
void SetRandomSeed(unsigned int seed);                      
void TakeScreenshot(const char *fileName);                  
void SetConfigFlags(unsigned int flags);                    
void TraceLog(int logLevel, const char *text, ...);         
void SetTraceLogLevel(int logLevel);                        
void *MemAlloc(int size);                                   
void *MemRealloc(void *ptr, int size);                      
void MemFree(void *ptr);                                    
void SetTraceLogCallback(TraceLogCallback callback);         
void SetLoadFileDataCallback(LoadFileDataCallback callback); 
void SetSaveFileDataCallback(SaveFileDataCallback callback); 
void SetLoadFileTextCallback(LoadFileTextCallback callback); 
void SetSaveFileTextCallback(SaveFileTextCallback callback); 
unsigned char *LoadFileData(const char *fileName, unsigned int *bytesRead);     
void UnloadFileData(unsigned char *data);                   
bool SaveFileData(const char *fileName, void *data, unsigned int bytesToWrite); 
char *LoadFileText(const char *fileName);                   
void UnloadFileText(char *text);                            
bool SaveFileText(const char *fileName, char *text);        
bool FileExists(const char *fileName);                      
bool DirectoryExists(const char *dirPath);                  
bool IsFileExtension(const char *fileName, const char *ext);
const char *GetFileExtension(const char *fileName);         
const char *GetFileName(const char *filePath);              
const char *GetFileNameWithoutExt(const char *filePath);    
const char *GetDirectoryPath(const char *filePath);         
const char *GetPrevDirectoryPath(const char *dirPath);      
const char *GetWorkingDirectory(void);                      
char **GetDirectoryFiles(const char *dirPath, int *count);  
void ClearDirectoryFiles(void);                             
bool ChangeDirectory(const char *dir);                      
bool IsFileDropped(void);                                   
char **GetDroppedFiles(int *count);                         
void ClearDroppedFiles(void);                               
long GetFileModTime(const char *fileName);                  
unsigned char *CompressData(unsigned char *data, int dataLength, int *compDataLength);        
unsigned char *DecompressData(unsigned char *compData, int compDataLength, int *dataLength);  
char *EncodeDataBase64(const unsigned char *data, int dataLength, int *outputLength);         
unsigned char *DecodeDataBase64(unsigned char *data, int *outputLength);                      
bool SaveStorageValue(unsigned int position, int value);    
int LoadStorageValue(unsigned int position);                
void OpenURL(const char *url);                              
bool IsKeyPressed(int key);                             
bool IsKeyDown(int key);                                
bool IsKeyReleased(int key);                            
bool IsKeyUp(int key);                                  
void SetExitKey(int key);                               
int GetKeyPressed(void);                                
int GetCharPressed(void);                               
bool IsGamepadAvailable(int gamepad);                   
const char *GetGamepadName(int gamepad);                
bool IsGamepadButtonPressed(int gamepad, int button);   
bool IsGamepadButtonDown(int gamepad, int button);      
bool IsGamepadButtonReleased(int gamepad, int button);  
bool IsGamepadButtonUp(int gamepad, int button);        
int GetGamepadButtonPressed(void);                      
int GetGamepadAxisCount(int gamepad);                   
float GetGamepadAxisMovement(int gamepad, int axis);    
int SetGamepadMappings(const char *mappings);           
bool IsMouseButtonPressed(int button);                  
bool IsMouseButtonDown(int button);                     
bool IsMouseButtonReleased(int button);                 
bool IsMouseButtonUp(int button);                       
int GetMouseX(void);                                    
int GetMouseY(void);                                    
Vector2 GetMousePosition(void);                         
Vector2 GetMouseDelta(void);                            
void SetMousePosition(int x, int y);                    
void SetMouseOffset(int offsetX, int offsetY);          
void SetMouseScale(float scaleX, float scaleY);         
float GetMouseWheelMove(void);                          
void SetMouseCursor(int cursor);                        
int GetTouchX(void);                                    
int GetTouchY(void);                                    
Vector2 GetTouchPosition(int index);                    
int GetTouchPointId(int index);                         
int GetTouchPointCount(void);                           
void SetGesturesEnabled(unsigned int flags);      
bool IsGestureDetected(int gesture);              
int GetGestureDetected(void);                     
float GetGestureHoldDuration(void);               
Vector2 GetGestureDragVector(void);               
float GetGestureDragAngle(void);                  
Vector2 GetGesturePinchVector(void);              
float GetGesturePinchAngle(void);                 
void SetCameraMode(Camera camera, int mode);      
void UpdateCamera(Camera *camera);                
void SetCameraPanControl(int keyPan);             
void SetCameraAltControl(int keyAlt);             
void SetCameraSmoothZoomControl(int keySmoothZoom); 
void SetCameraMoveControls(int keyFront, int keyBack, int keyRight, int keyLeft, int keyUp, int keyDown); 
void SetShapesTexture(Texture2D texture, Rectangle source);       
void DrawPixel(int posX, int posY, Color color);                                                   
void DrawPixelV(Vector2 position, Color color);                                                    
void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);                
void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     
void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);                       
void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);                   
void DrawLineBezierQuad(Vector2 startPos, Vector2 endPos, Vector2 controlPos, float thick, Color color); 
void DrawLineBezierCubic(Vector2 startPos, Vector2 endPos, Vector2 startControlPos, Vector2 endControlPos, float thick, Color color); 
void DrawLineStrip(Vector2 *points, int pointCount, Color color);                                  
void DrawCircle(int centerX, int centerY, float radius, Color color);                              
void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);      
void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color); 
void DrawCircleGradient(int centerX, int centerY, float radius, Color color1, Color color2);       
void DrawCircleV(Vector2 center, float radius, Color color);                                       
void DrawCircleLines(int centerX, int centerY, float radius, Color color);                         
void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);             
void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);        
void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color); 
void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);    
void DrawRectangle(int posX, int posY, int width, int height, Color color);                        
void DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  
void DrawRectangleRec(Rectangle rec, Color color);                                                 
void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 
void DrawRectangleGradientV(int posX, int posY, int width, int height, Color color1, Color color2);
void DrawRectangleGradientH(int posX, int posY, int width, int height, Color color1, Color color2);
void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4);       
void DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   
void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);                            
void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);              
void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, float lineThick, Color color); 
void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                
void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           
void DrawTriangleFan(Vector2 *points, int pointCount, Color color);                                
void DrawTriangleStrip(Vector2 *points, int pointCount, Color color);                              
void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               
void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);          
void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color); 
bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);                                           
bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);        
bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);                         
bool CheckCollisionPointRec(Vector2 point, Rectangle rec);                                         
bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);                       
bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);               
bool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint); 
bool CheckCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold);                
Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                         
Image LoadImage(const char *fileName);                                                             
Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);       
Image LoadImageAnim(const char *fileName, int *frames);                                            
Image LoadImageFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);      
Image LoadImageFromTexture(Texture2D texture);                                                     
Image LoadImageFromScreen(void);                                                                   
void UnloadImage(Image image);                                                                     
bool ExportImage(Image image, const char *fileName);                                               
bool ExportImageAsCode(Image image, const char *fileName);                                         
Image GenImageColor(int width, int height, Color color);                                           
Image GenImageGradientV(int width, int height, Color top, Color bottom);                           
Image GenImageGradientH(int width, int height, Color left, Color right);                           
Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);      
Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);    
Image GenImageWhiteNoise(int width, int height, float factor);                                     
Image GenImageCellular(int width, int height, int tileSize);                                       
Image ImageCopy(Image image);                                                                      
Image ImageFromImage(Image image, Rectangle rec);                                                  
Image ImageText(const char *text, int fontSize, Color color);                                      
Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);         
void ImageFormat(Image *image, int newFormat);                                                     
void ImageToPOT(Image *image, Color fill);                                                         
void ImageCrop(Image *image, Rectangle crop);                                                      
void ImageAlphaCrop(Image *image, float threshold);                                                
void ImageAlphaClear(Image *image, Color color, float threshold);                                  
void ImageAlphaMask(Image *image, Image alphaMask);                                                
void ImageAlphaPremultiply(Image *image);                                                          
void ImageResize(Image *image, int newWidth, int newHeight);                                       
void ImageResizeNN(Image *image, int newWidth,int newHeight);                                      
void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill);  
void ImageMipmaps(Image *image);                                                                   
void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);                            
void ImageFlipVertical(Image *image);                                                              
void ImageFlipHorizontal(Image *image);                                                            
void ImageRotateCW(Image *image);                                                                  
void ImageRotateCCW(Image *image);                                                                 
void ImageColorTint(Image *image, Color color);                                                    
void ImageColorInvert(Image *image);                                                               
void ImageColorGrayscale(Image *image);                                                            
void ImageColorContrast(Image *image, float contrast);                                             
void ImageColorBrightness(Image *image, int brightness);                                           
void ImageColorReplace(Image *image, Color color, Color replace);                                  
Color *LoadImageColors(Image image);                                                               
Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorCount);                         
void UnloadImageColors(Color *colors);                                                             
void UnloadImagePalette(Color *colors);                                                            
Rectangle GetImageAlphaBorder(Image image, float threshold);                                       
Color GetImageColor(Image image, int x, int y);                                                    
void ImageClearBackground(Image *dst, Color color);                                                
void ImageDrawPixel(Image *dst, int posX, int posY, Color color);                                  
void ImageDrawPixelV(Image *dst, Vector2 position, Color color);                                   
void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color); 
void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);                          
void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);               
void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);                        
void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);       
void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);                 
void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);                                
void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);                   
void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);             
void ImageDrawText(Image *dst, const char *text, int posX, int posY, int fontSize, Color color);   
void ImageDrawTextEx(Image *dst, Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint); 
Texture2D LoadTexture(const char *fileName);                                                       
Texture2D LoadTextureFromImage(Image image);                                                       
TextureCubemap LoadTextureCubemap(Image image, int layout);                                        
RenderTexture2D LoadRenderTexture(int width, int height);                                          
void UnloadTexture(Texture2D texture);                                                             
void UnloadRenderTexture(RenderTexture2D target);                                                  
void UpdateTexture(Texture2D texture, const void *pixels);                                         
void UpdateTextureRec(Texture2D texture, Rectangle rec, const void *pixels);                       
void GenTextureMipmaps(Texture2D *texture);                                                        
void SetTextureFilter(Texture2D texture, int filter);                                              
void SetTextureWrap(Texture2D texture, int wrap);                                                  
void DrawTexture(Texture2D texture, int posX, int posY, Color tint);                               
void DrawTextureV(Texture2D texture, Vector2 position, Color tint);                                
void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);  
void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);            
void DrawTextureQuad(Texture2D texture, Vector2 tiling, Vector2 offset, Rectangle quad, Color tint);  
void DrawTextureTiled(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, float scale, Color tint);      
void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);           
void DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint);   
void DrawTexturePoly(Texture2D texture, Vector2 center, Vector2 *points, Vector2 *texcoords, int pointCount, Color tint);      
Color Fade(Color color, float alpha);                                 
int ColorToInt(Color color);                                          
Vector4 ColorNormalize(Color color);                                  
Color ColorFromNormalized(Vector4 normalized);                        
Vector3 ColorToHSV(Color color);                                      
Color ColorFromHSV(float hue, float saturation, float value);         
Color ColorAlpha(Color color, float alpha);                           
Color ColorAlphaBlend(Color dst, Color src, Color tint);              
Color GetColor(unsigned int hexValue);                                
Color GetPixelColor(void *srcPtr, int format);                        
void SetPixelColor(void *dstPtr, Color color, int format);            
int GetPixelDataSize(int width, int height, int format);              
Font GetFontDefault(void);                                                            
Font LoadFont(const char *fileName);                                                  
Font LoadFontEx(const char *fileName, int fontSize, int *fontChars, int glyphCount);  
Font LoadFontFromImage(Image image, Color key, int firstChar);                        
Font LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *fontChars, int glyphCount); 
GlyphInfo *LoadFontData(const unsigned char *fileData, int dataSize, int fontSize, int *fontChars, int glyphCount, int type);      
Image GenImageFontAtlas(const GlyphInfo *chars, Rectangle **recs, int glyphCount, int fontSize, int padding, int packMethod);      
void UnloadFontData(GlyphInfo *chars, int glyphCount);                                 
void UnloadFont(Font font);                                                           
void DrawFPS(int posX, int posY);                                                     
void DrawText(const char *text, int posX, int posY, int fontSize, Color color);       
void DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint);    
void DrawTextPro(Font font, const char *text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint); 
void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint);   
int MeasureText(const char *text, int fontSize);                                      
Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);    
int GetGlyphIndex(Font font, int codepoint);                                          
GlyphInfo GetGlyphInfo(Font font, int codepoint);                                     
Rectangle GetGlyphAtlasRec(Font font, int codepoint);                                 
int *LoadCodepoints(const char *text, int *count);              
void UnloadCodepoints(int *codepoints);                         
int GetCodepointCount(const char *text);                        
int GetCodepoint(const char *text, int *bytesProcessed);        
const char *CodepointToUTF8(int codepoint, int *byteSize);      
char *TextCodepointsToUTF8(int *codepoints, int length);        
int TextCopy(char *dst, const char *src);                                             
bool TextIsEqual(const char *text1, const char *text2);                               
unsigned int TextLength(const char *text);                                            
const char *TextFormat(const char *text, ...);                                        
const char *TextSubtext(const char *text, int position, int length);                  
char *TextReplace(char *text, const char *replace, const char *by);                   
char *TextInsert(const char *text, const char *insert, int position);                 
const char *TextJoin(const char **textList, int count, const char *delimiter);        
const char **TextSplit(const char *text, char delimiter, int *count);                 
void TextAppend(char *text, const char *append, int *position);                       
int TextFindIndex(const char *text, const char *find);                                
const char *TextToUpper(const char *text);                      
const char *TextToLower(const char *text);                      
const char *TextToPascal(const char *text);                     
int TextToInteger(const char *text);                            
void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);                                    
void DrawPoint3D(Vector3 position, Color color);                                                   
void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color); 
void DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);                              
void DrawTriangleStrip3D(Vector3 *points, int pointCount, Color color);                           
void DrawCube(Vector3 position, float width, float height, float length, Color color);             
void DrawCubeV(Vector3 position, Vector3 size, Color color);                                       
void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);        
void DrawCubeWiresV(Vector3 position, Vector3 size, Color color);                                  
void DrawCubeTexture(Texture2D texture, Vector3 position, float width, float height, float length, Color color); 
void DrawCubeTextureRec(Texture2D texture, Rectangle source, Vector3 position, float width, float height, float length, Color color); 
void DrawSphere(Vector3 centerPos, float radius, Color color);                                     
void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);            
void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);         
void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); 
void DrawCylinderEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color); 
void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); 
void DrawCylinderWiresEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color); 
void DrawPlane(Vector3 centerPos, Vector2 size, Color color);                                      
void DrawRay(Ray ray, Color color);                                                                
void DrawGrid(int slices, float spacing);                                                          
Model LoadModel(const char *fileName);                                                
Model LoadModelFromMesh(Mesh mesh);                                                   
void UnloadModel(Model model);                                                        
void UnloadModelKeepMeshes(Model model);                                              
BoundingBox GetModelBoundingBox(Model model);                                         
void DrawModel(Model model, Vector3 position, float scale, Color tint);                           
void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); 
void DrawModelWires(Model model, Vector3 position, float scale, Color tint);                      
void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); 
void DrawBoundingBox(BoundingBox box, Color color);                                               
void DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float size, Color tint);   
void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint); 
void DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint); 
void UploadMesh(Mesh *mesh, bool dynamic);                                            
void UpdateMeshBuffer(Mesh mesh, int index, void *data, int dataSize, int offset);    
void UnloadMesh(Mesh mesh);                                                           
void DrawMesh(Mesh mesh, Material material, Matrix transform);                        
void DrawMeshInstanced(Mesh mesh, Material material, Matrix *transforms, int instances); 
bool ExportMesh(Mesh mesh, const char *fileName);                                     
BoundingBox GetMeshBoundingBox(Mesh mesh);                                            
void GenMeshTangents(Mesh *mesh);                                                     
void GenMeshBinormals(Mesh *mesh);                                                    
Mesh GenMeshPoly(int sides, float radius);                                            
Mesh GenMeshPlane(float width, float length, int resX, int resZ);                     
Mesh GenMeshCube(float width, float height, float length);                            
Mesh GenMeshSphere(float radius, int rings, int slices);                              
Mesh GenMeshHemiSphere(float radius, int rings, int slices);                          
Mesh GenMeshCylinder(float radius, float height, int slices);                         
Mesh GenMeshCone(float radius, float height, int slices);                             
Mesh GenMeshTorus(float radius, float size, int radSeg, int sides);                   
Mesh GenMeshKnot(float radius, float size, int radSeg, int sides);                    
Mesh GenMeshHeightmap(Image heightmap, Vector3 size);                                 
Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);                               
Material *LoadMaterials(const char *fileName, int *materialCount);                    
Material LoadMaterialDefault(void);                                                   
void UnloadMaterial(Material material);                                               
void SetMaterialTexture(Material *material, int mapType, Texture2D texture);          
void SetModelMeshMaterial(Model *model, int meshId, int materialId);                  
ModelAnimation *LoadModelAnimations(const char *fileName, unsigned int *animCount);   
void UpdateModelAnimation(Model model, ModelAnimation anim, int frame);               
void UnloadModelAnimation(ModelAnimation anim);                                       
void UnloadModelAnimations(ModelAnimation* animations, unsigned int count);           
bool IsModelAnimationValid(Model model, ModelAnimation anim);                         
bool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);       
bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);                                     
bool CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius);                      
RayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);                        
RayCollision GetRayCollisionBox(Ray ray, BoundingBox box);                                        
RayCollision GetRayCollisionModel(Ray ray, Model model);                                          
RayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);                           
RayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);                
RayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);        
void InitAudioDevice(void);                                     
void CloseAudioDevice(void);                                    
bool IsAudioDeviceReady(void);                                  
void SetMasterVolume(float volume);                             
Wave LoadWave(const char *fileName);                            
Wave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize); 
Sound LoadSound(const char *fileName);                          
Sound LoadSoundFromWave(Wave wave);                             
void UpdateSound(Sound sound, const void *data, int sampleCount); 
void UnloadWave(Wave wave);                                     
void UnloadSound(Sound sound);                                  
bool ExportWave(Wave wave, const char *fileName);               
bool ExportWaveAsCode(Wave wave, const char *fileName);         
void PlaySound(Sound sound);                                    
void StopSound(Sound sound);                                    
void PauseSound(Sound sound);                                   
void ResumeSound(Sound sound);                                  
void PlaySoundMulti(Sound sound);                               
void StopSoundMulti(void);                                      
int GetSoundsPlaying(void);                                     
bool IsSoundPlaying(Sound sound);                               
void SetSoundVolume(Sound sound, float volume);                 
void SetSoundPitch(Sound sound, float pitch);                   
void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels);  
Wave WaveCopy(Wave wave);                                       
void WaveCrop(Wave *wave, int initSample, int finalSample);     
float *LoadWaveSamples(Wave wave);                              
void UnloadWaveSamples(float *samples);                         
Music LoadMusicStream(const char *fileName);                    
Music LoadMusicStreamFromMemory(const char *fileType, unsigned char *data, int dataSize); 
void UnloadMusicStream(Music music);                            
void PlayMusicStream(Music music);                              
bool IsMusicStreamPlaying(Music music);                         
void UpdateMusicStream(Music music);                            
void StopMusicStream(Music music);                              
void PauseMusicStream(Music music);                             
void ResumeMusicStream(Music music);                            
void SeekMusicStream(Music music, float position);              
void SetMusicVolume(Music music, float volume);                 
void SetMusicPitch(Music music, float pitch);                   
float GetMusicTimeLength(Music music);                          
float GetMusicTimePlayed(Music music);                          
AudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); 
void UnloadAudioStream(AudioStream stream);                      
void UpdateAudioStream(AudioStream stream, const void *data, int frameCount); 
bool IsAudioStreamProcessed(AudioStream stream);                
void PlayAudioStream(AudioStream stream);                       
void PauseAudioStream(AudioStream stream);                      
void ResumeAudioStream(AudioStream stream);                     
bool IsAudioStreamPlaying(AudioStream stream);                  
void StopAudioStream(AudioStream stream);                       
void SetAudioStreamVolume(AudioStream stream, float volume);    
void SetAudioStreamPitch(AudioStream stream, float pitch);      
void SetAudioStreamBufferSizeDefault(int size);                 
typedef struct GuiStyleProp {
unsigned short controlId;
unsigned short propertyId;
int propertyValue;
} GuiStyleProp;
typedef enum {
GUI_STATE_NORMAL = 0,
GUI_STATE_FOCUSED,
GUI_STATE_PRESSED,
GUI_STATE_DISABLED,
} GuiControlState;
typedef enum {
GUI_TEXT_ALIGN_LEFT = 0,
GUI_TEXT_ALIGN_CENTER,
GUI_TEXT_ALIGN_RIGHT,
} GuiTextAlignment;
typedef enum {
DEFAULT = 0,    
LABEL,          
BUTTON,
TOGGLE,         
SLIDER,         
PROGRESSBAR,
CHECKBOX,
COMBOBOX,
DROPDOWNBOX,
TEXTBOX,        
VALUEBOX,
SPINNER,
LISTVIEW,
COLORPICKER,
SCROLLBAR,
STATUSBAR
} GuiControl;
typedef enum {
BORDER_COLOR_NORMAL = 0,
BASE_COLOR_NORMAL,
TEXT_COLOR_NORMAL,
BORDER_COLOR_FOCUSED,
BASE_COLOR_FOCUSED,
TEXT_COLOR_FOCUSED,
BORDER_COLOR_PRESSED,
BASE_COLOR_PRESSED,
TEXT_COLOR_PRESSED,
BORDER_COLOR_DISABLED,
BASE_COLOR_DISABLED,
TEXT_COLOR_DISABLED,
BORDER_WIDTH,
TEXT_PADDING,
TEXT_ALIGNMENT,
RESERVED
} GuiControlProperty;
typedef enum {
TEXT_SIZE = 16,
TEXT_SPACING,
LINE_COLOR,
BACKGROUND_COLOR,
} GuiDefaultProperty;
typedef enum {
GROUP_PADDING = 16,
} GuiToggleProperty;
typedef enum {
SLIDER_WIDTH = 16,
SLIDER_PADDING
} GuiSliderProperty;
typedef enum {
PROGRESS_PADDING = 16,
} GuiProgressBarProperty;
typedef enum {
CHECK_PADDING = 16
} GuiCheckBoxProperty;
typedef enum {
COMBO_BUTTON_WIDTH = 16,
COMBO_BUTTON_PADDING
} GuiComboBoxProperty;
typedef enum {
ARROW_PADDING = 16,
DROPDOWN_ITEMS_PADDING
} GuiDropdownBoxProperty;
typedef enum {
TEXT_INNER_PADDING = 16,
TEXT_LINES_PADDING,
COLOR_SELECTED_FG,
COLOR_SELECTED_BG
} GuiTextBoxProperty;
typedef enum {
SPIN_BUTTON_WIDTH = 16,
SPIN_BUTTON_PADDING,
} GuiSpinnerProperty;
typedef enum {
ARROWS_SIZE = 16,
ARROWS_VISIBLE,
SCROLL_SLIDER_PADDING,
SCROLL_SLIDER_SIZE,
SCROLL_PADDING,
SCROLL_SPEED,
} GuiScrollBarProperty;
typedef enum {
SCROLLBAR_LEFT_SIDE = 0,
SCROLLBAR_RIGHT_SIDE
} GuiScrollBarSide;
typedef enum {
LIST_ITEMS_HEIGHT = 16,
LIST_ITEMS_PADDING,
SCROLLBAR_WIDTH,
SCROLLBAR_SIDE,
} GuiListViewProperty;
typedef enum {
COLOR_SELECTOR_SIZE = 16,
HUEBAR_WIDTH,                  
HUEBAR_PADDING,                
HUEBAR_SELECTOR_HEIGHT,        
HUEBAR_SELECTOR_OVERFLOW       
} GuiColorPickerProperty;
void GuiEnable(void);                                         
void GuiDisable(void);                                        
void GuiLock(void);                                           
void GuiUnlock(void);                                         
bool GuiIsLocked(void);                                       
void GuiFade(float alpha);                                    
void GuiSetState(int state);                                  
int GuiGetState(void);                                        
void GuiSetFont(Font font);                                   
Font GuiGetFont(void);                                        
void GuiSetStyle(int control, int property, int value);       
int GuiGetStyle(int control, int property);                   
bool GuiWindowBox(Rectangle bounds, const char *title);                                       
void GuiGroupBox(Rectangle bounds, const char *text);                                         
void GuiLine(Rectangle bounds, const char *text);                                             
void GuiPanel(Rectangle bounds);                                                              
Rectangle GuiScrollPanel(Rectangle bounds, Rectangle content, Vector2 *scroll);               
void GuiLabel(Rectangle bounds, const char *text);                                            
bool GuiButton(Rectangle bounds, const char *text);                                           
bool GuiLabelButton(Rectangle bounds, const char *text);                                      
bool GuiToggle(Rectangle bounds, const char *text, bool active);                              
int GuiToggleGroup(Rectangle bounds, const char *text, int active);                           
bool GuiCheckBox(Rectangle bounds, const char *text, bool checked);                           
int GuiComboBox(Rectangle bounds, const char *text, int active);                              
bool GuiDropdownBox(Rectangle bounds, const char *text, int *active, bool editMode);          
bool GuiSpinner(Rectangle bounds, const char *text, int *value, int minValue, int maxValue, bool editMode);     
bool GuiValueBox(Rectangle bounds, const char *text, int *value, int minValue, int maxValue, bool editMode);    
bool GuiTextBox(Rectangle bounds, char *text, int textSize, bool editMode);                   
bool GuiTextBoxMulti(Rectangle bounds, char *text, int textSize, bool editMode);              
float GuiSlider(Rectangle bounds, const char *textLeft, const char *textRight, float value, float minValue, float maxValue);       
float GuiSliderBar(Rectangle bounds, const char *textLeft, const char *textRight, float value, float minValue, float maxValue);    
float GuiProgressBar(Rectangle bounds, const char *textLeft, const char *textRight, float value, float minValue, float maxValue);  
void GuiStatusBar(Rectangle bounds, const char *text);                                        
void GuiDummyRec(Rectangle bounds, const char *text);                                         
int GuiScrollBar(Rectangle bounds, int value, int minValue, int maxValue);                    
Vector2 GuiGrid(Rectangle bounds, float spacing, int subdivs);                                
int GuiListView(Rectangle bounds, const char *text, int *scrollIndex, int active);            
int GuiListViewEx(Rectangle bounds, const char **text, int count, int *focus, int *scrollIndex, int active);      
int GuiMessageBox(Rectangle bounds, const char *title, const char *message, const char *buttons);                 
int GuiTextInputBox(Rectangle bounds, const char *title, const char *message, const char *buttons, char *text);   
Color GuiColorPicker(Rectangle bounds, Color color);                                          
Color GuiColorPanel(Rectangle bounds, Color color);                                           
float GuiColorBarAlpha(Rectangle bounds, float alpha);                                        
float GuiColorBarHue(Rectangle bounds, float value);                                          
void GuiLoadStyle(const char *fileName);              
void GuiLoadStyleDefault(void);                       
const char *GuiIconText(int iconId, const char *text); 
void GuiDrawIcon(int iconId, int posX, int posY, int pixelSize, Color color);
unsigned int *GuiGetIcons(void);                      
unsigned int *GuiGetIconData(int iconId);             
void GuiSetIconData(int iconId, unsigned int *data);  
void GuiSetIconPixel(int iconId, int x, int y);       
void GuiClearIconPixel(int iconId, int x, int y);     
bool GuiCheckIconPixel(int iconId, int x, int y);     
typedef enum {
OPENGL_11 = 1,
OPENGL_21,
OPENGL_33,
OPENGL_43,
OPENGL_ES_20
} rlGlVersion;
typedef enum {
RL_ATTACHMENT_COLOR_CHANNEL0 = 0,
RL_ATTACHMENT_COLOR_CHANNEL1,
RL_ATTACHMENT_COLOR_CHANNEL2,
RL_ATTACHMENT_COLOR_CHANNEL3,
RL_ATTACHMENT_COLOR_CHANNEL4,
RL_ATTACHMENT_COLOR_CHANNEL5,
RL_ATTACHMENT_COLOR_CHANNEL6,
RL_ATTACHMENT_COLOR_CHANNEL7,
RL_ATTACHMENT_DEPTH = 100,
RL_ATTACHMENT_STENCIL = 200,
} rlFramebufferAttachType;
typedef enum {
RL_ATTACHMENT_CUBEMAP_POSITIVE_X = 0,
RL_ATTACHMENT_CUBEMAP_NEGATIVE_X,
RL_ATTACHMENT_CUBEMAP_POSITIVE_Y,
RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y,
RL_ATTACHMENT_CUBEMAP_POSITIVE_Z,
RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z,
RL_ATTACHMENT_TEXTURE2D = 100,
RL_ATTACHMENT_RENDERBUFFER = 200,
} rlFramebufferAttachTextureType;
typedef struct rlVertexBuffer {
int elementCount;           
float *vertices;            
float *texcoords;           
unsigned char *colors;      
unsigned int *indices;      
unsigned int vaoId;         
unsigned int vboId[4];      
} rlVertexBuffer;
typedef struct rlDrawCall {
int mode;                   
int vertexCount;            
int vertexAlignment;        
unsigned int textureId;     
} rlDrawCall;
typedef struct rlRenderBatch {
int bufferCount;            
int currentBuffer;          
rlVertexBuffer *vertexBuffer; 
rlDrawCall *draws;          
int drawCounter;            
float currentDepth;         
} rlRenderBatch;
typedef enum {
RL_LOG_ALL = 0,            
RL_LOG_TRACE,              
RL_LOG_DEBUG,              
RL_LOG_INFO,               
RL_LOG_WARNING,            
RL_LOG_ERROR,              
RL_LOG_FATAL,              
RL_LOG_NONE                
} rlTraceLogLevel;
typedef enum {
RL_PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1,     
RL_PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,        
RL_PIXELFORMAT_UNCOMPRESSED_R5G6B5,            
RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8,            
RL_PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,          
RL_PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,          
RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,          
RL_PIXELFORMAT_UNCOMPRESSED_R32,               
RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32,         
RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,      
RL_PIXELFORMAT_COMPRESSED_DXT1_RGB,            
RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA,           
RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA,           
RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA,           
RL_PIXELFORMAT_COMPRESSED_ETC1_RGB,            
RL_PIXELFORMAT_COMPRESSED_ETC2_RGB,            
RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,       
RL_PIXELFORMAT_COMPRESSED_PVRT_RGB,            
RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA,           
RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA,       
RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA        
} rlPixelFormat;
typedef enum {
RL_TEXTURE_FILTER_POINT = 0,               
RL_TEXTURE_FILTER_BILINEAR,                
RL_TEXTURE_FILTER_TRILINEAR,               
RL_TEXTURE_FILTER_ANISOTROPIC_4X,          
RL_TEXTURE_FILTER_ANISOTROPIC_8X,          
RL_TEXTURE_FILTER_ANISOTROPIC_16X,         
} rlTextureFilter;
typedef enum {
RL_BLEND_ALPHA = 0,                
RL_BLEND_ADDITIVE,                 
RL_BLEND_MULTIPLIED,               
RL_BLEND_ADD_COLORS,               
RL_BLEND_SUBTRACT_COLORS,          
RL_BLEND_CUSTOM                    
} rlBlendMode;
typedef enum {
RL_SHADER_LOC_VERTEX_POSITION = 0, 
RL_SHADER_LOC_VERTEX_TEXCOORD01,   
RL_SHADER_LOC_VERTEX_TEXCOORD02,   
RL_SHADER_LOC_VERTEX_NORMAL,       
RL_SHADER_LOC_VERTEX_TANGENT,      
RL_SHADER_LOC_VERTEX_COLOR,        
RL_SHADER_LOC_MATRIX_MVP,          
RL_SHADER_LOC_MATRIX_VIEW,         
RL_SHADER_LOC_MATRIX_PROJECTION,   
RL_SHADER_LOC_MATRIX_MODEL,        
RL_SHADER_LOC_MATRIX_NORMAL,       
RL_SHADER_LOC_VECTOR_VIEW,         
RL_SHADER_LOC_COLOR_DIFFUSE,       
RL_SHADER_LOC_COLOR_SPECULAR,      
RL_SHADER_LOC_COLOR_AMBIENT,       
RL_SHADER_LOC_MAP_ALBEDO,          
RL_SHADER_LOC_MAP_METALNESS,       
RL_SHADER_LOC_MAP_NORMAL,          
RL_SHADER_LOC_MAP_ROUGHNESS,       
RL_SHADER_LOC_MAP_OCCLUSION,       
RL_SHADER_LOC_MAP_EMISSION,        
RL_SHADER_LOC_MAP_HEIGHT,          
RL_SHADER_LOC_MAP_CUBEMAP,         
RL_SHADER_LOC_MAP_IRRADIANCE,      
RL_SHADER_LOC_MAP_PREFILTER,       
RL_SHADER_LOC_MAP_BRDF             
} rlShaderLocationIndex;
typedef enum {
RL_SHADER_UNIFORM_FLOAT = 0,       
RL_SHADER_UNIFORM_VEC2,            
RL_SHADER_UNIFORM_VEC3,            
RL_SHADER_UNIFORM_VEC4,            
RL_SHADER_UNIFORM_INT,             
RL_SHADER_UNIFORM_IVEC2,           
RL_SHADER_UNIFORM_IVEC3,           
RL_SHADER_UNIFORM_IVEC4,           
RL_SHADER_UNIFORM_SAMPLER2D        
} rlShaderUniformDataType;
typedef enum {
RL_SHADER_ATTRIB_FLOAT = 0,        
RL_SHADER_ATTRIB_VEC2,             
RL_SHADER_ATTRIB_VEC3,             
RL_SHADER_ATTRIB_VEC4              
} rlShaderAttributeDataType;
void rlMatrixMode(int mode);                    
void rlPushMatrix(void);                        
void rlPopMatrix(void);                         
void rlLoadIdentity(void);                      
void rlTranslatef(float x, float y, float z);   
void rlRotatef(float angle, float x, float y, float z);  
void rlScalef(float x, float y, float z);       
void rlMultMatrixf(float *matf);                
void rlFrustum(double left, double right, double bottom, double top, double znear, double zfar);
void rlOrtho(double left, double right, double bottom, double top, double znear, double zfar);
void rlViewport(int x, int y, int width, int height); 
void rlBegin(int mode);                         
void rlEnd(void);                               
void rlVertex2i(int x, int y);                  
void rlVertex2f(float x, float y);              
void rlVertex3f(float x, float y, float z);     
void rlTexCoord2f(float x, float y);            
void rlNormal3f(float x, float y, float z);     
void rlColor4ub(unsigned char r, unsigned char g, unsigned char b, unsigned char a);  
void rlColor3f(float x, float y, float z);          
void rlColor4f(float x, float y, float z, float w); 
bool rlEnableVertexArray(unsigned int vaoId);     
void rlDisableVertexArray(void);                  
void rlEnableVertexBuffer(unsigned int id);       
void rlDisableVertexBuffer(void);                 
void rlEnableVertexBufferElement(unsigned int id);
void rlDisableVertexBufferElement(void);          
void rlEnableVertexAttribute(unsigned int index); 
void rlDisableVertexAttribute(unsigned int index);
void rlActiveTextureSlot(int slot);               
void rlEnableTexture(unsigned int id);            
void rlDisableTexture(void);                      
void rlEnableTextureCubemap(unsigned int id);     
void rlDisableTextureCubemap(void);               
void rlTextureParameters(unsigned int id, int param, int value); 
void rlEnableShader(unsigned int id);             
void rlDisableShader(void);                       
void rlEnableFramebuffer(unsigned int id);        
void rlDisableFramebuffer(void);                  
void rlActiveDrawBuffers(int count);              
void rlEnableColorBlend(void);                     
void rlDisableColorBlend(void);                   
void rlEnableDepthTest(void);                     
void rlDisableDepthTest(void);                    
void rlEnableDepthMask(void);                     
void rlDisableDepthMask(void);                    
void rlEnableBackfaceCulling(void);               
void rlDisableBackfaceCulling(void);              
void rlEnableScissorTest(void);                   
void rlDisableScissorTest(void);                  
void rlScissor(int x, int y, int width, int height); 
void rlEnableWireMode(void);                      
void rlDisableWireMode(void);                     
void rlSetLineWidth(float width);                 
float rlGetLineWidth(void);                       
void rlEnableSmoothLines(void);                   
void rlDisableSmoothLines(void);                  
void rlEnableStereoRender(void);                  
void rlDisableStereoRender(void);                 
bool rlIsStereoRenderEnabled(void);               
void rlClearColor(unsigned char r, unsigned char g, unsigned char b, unsigned char a); 
void rlClearScreenBuffers(void);                  
void rlCheckErrors(void);                         
void rlSetBlendMode(int mode);                    
void rlSetBlendFactors(int glSrcFactor, int glDstFactor, int glEquation); 
void rlglInit(int width, int height);           
void rlglClose(void);                           
void rlLoadExtensions(void *loader);            
int rlGetVersion(void);                         
int rlGetFramebufferWidth(void);                
int rlGetFramebufferHeight(void);               
unsigned int rlGetTextureIdDefault(void);       
unsigned int rlGetShaderIdDefault(void);        
int *rlGetShaderLocsDefault(void);              
rlRenderBatch rlLoadRenderBatch(int numBuffers, int bufferElements);  
void rlUnloadRenderBatch(rlRenderBatch batch);                        
void rlDrawRenderBatch(rlRenderBatch *batch);                         
void rlSetRenderBatchActive(rlRenderBatch *batch);                    
void rlDrawRenderBatchActive(void);                                   
bool rlCheckRenderBatchLimit(int vCount);                             
void rlSetTexture(unsigned int id);           
unsigned int rlLoadVertexArray(void);                               
unsigned int rlLoadVertexBuffer(void *buffer, int size, bool dynamic);            
unsigned int rlLoadVertexBufferElement(void *buffer, int size, bool dynamic);     
void rlUpdateVertexBuffer(unsigned int bufferId, void *data, int dataSize, int offset);    
void rlUnloadVertexArray(unsigned int vaoId);
void rlUnloadVertexBuffer(unsigned int vboId);
void rlSetVertexAttribute(unsigned int index, int compSize, int type, bool normalized, int stride, void *pointer);
void rlSetVertexAttributeDivisor(unsigned int index, int divisor);
void rlSetVertexAttributeDefault(int locIndex, const void *value, int attribType, int count); 
void rlDrawVertexArray(int offset, int count);
void rlDrawVertexArrayElements(int offset, int count, void *buffer);
void rlDrawVertexArrayInstanced(int offset, int count, int instances);
void rlDrawVertexArrayElementsInstanced(int offset, int count, void *buffer, int instances);
unsigned int rlLoadTexture(void *data, int width, int height, int format, int mipmapCount); 
unsigned int rlLoadTextureDepth(int width, int height, bool useRenderBuffer);               
unsigned int rlLoadTextureCubemap(void *data, int size, int format);                        
void rlUpdateTexture(unsigned int id, int offsetX, int offsetY, int width, int height, int format, const void *data);  
void rlGetGlTextureFormats(int format, int *glInternalFormat, int *glFormat, int *glType);  
const char *rlGetPixelFormatName(unsigned int format);              
void rlUnloadTexture(unsigned int id);                              
void rlGenTextureMipmaps(unsigned int id, int width, int height, int format, int *mipmaps); 
void *rlReadTexturePixels(unsigned int id, int width, int height, int format);              
unsigned char *rlReadScreenPixels(int width, int height);           
unsigned int rlLoadFramebuffer(int width, int height);              
void rlFramebufferAttach(unsigned int fboId, unsigned int texId, int attachType, int texType, int mipLevel);  
bool rlFramebufferComplete(unsigned int id);                        
void rlUnloadFramebuffer(unsigned int id);                          
unsigned int rlLoadShaderCode(const char *vsCode, const char *fsCode);    
unsigned int rlCompileShader(const char *shaderCode, int type);           
unsigned int rlLoadShaderProgram(unsigned int vShaderId, unsigned int fShaderId); 
void rlUnloadShaderProgram(unsigned int id);                              
int rlGetLocationUniform(unsigned int shaderId, const char *uniformName); 
int rlGetLocationAttrib(unsigned int shaderId, const char *attribName);   
void rlSetUniform(int locIndex, const void *value, int uniformType, int count);   
void rlSetUniformMatrix(int locIndex, Matrix mat);                        
void rlSetUniformSampler(int locIndex, unsigned int textureId);           
void rlSetShader(unsigned int id, int *locs);                             
unsigned int rlLoadComputeShaderProgram(unsigned int shaderId);           
void rlComputeShaderDispatch(unsigned int groupX, unsigned int groupY, unsigned int groupZ);  
unsigned int rlLoadShaderBuffer(unsigned long long size, const void *data, int usageHint);    
void rlUnloadShaderBuffer(unsigned int ssboId);                           
void rlUpdateShaderBufferElements(unsigned int id, const void *data, unsigned long long dataSize, unsigned long long offset); 
unsigned long long rlGetShaderBufferSize(unsigned int id);                
void rlReadShaderBufferElements(unsigned int id, void *dest, unsigned long long count, unsigned long long offset);    
void rlBindShaderBuffer(unsigned int id, unsigned int index);             
void rlCopyBuffersElements(unsigned int destId, unsigned int srcId, unsigned long long destOffset, unsigned long long srcOffset, unsigned long long count); 
void rlBindImageTexture(unsigned int id, unsigned int index, unsigned int format, int readonly);  
Matrix rlGetMatrixModelview(void);                                  
Matrix rlGetMatrixProjection(void);                                 
Matrix rlGetMatrixTransform(void);                                  
Matrix rlGetMatrixProjectionStereo(int eye);                        
Matrix rlGetMatrixViewOffsetStereo(int eye);                        
void rlSetMatrixProjection(Matrix proj);                            
void rlSetMatrixModelview(Matrix view);                             
void rlSetMatrixProjectionStereo(Matrix right, Matrix left);        
void rlSetMatrixViewOffsetStereo(Matrix right, Matrix left);        
void rlLoadDrawCube(void);     
void rlLoadDrawQuad(void);   

// below is luaopt.c
void pGetWindowPosition(Vector2 *v);
void pClearBackground(Color *v);
void pBeginMode2D(Camera2D* v);
]]
return hdtLoadFFI('raylib.dll')
