// In this file, all global variables and declared and initialized,
// and the draw() method is defined, which is called 60 times per second.

// Cheats
boolean onlySpawnLongPieces;

// Settings
int pixelsPerBlock;
int timeIntervalFlag;
int gridWidth;
int gridHeight;
int playerLength;
int playerXstartPos;
int playerYstartPos;

// Colors
color backgroundColor;
color gridBackgroundColor;
color goalColor;

// Dynamic BUILDING variables
int lastTimeCheck;
Grid grid;
Piece currentPiece;
Piece heldPiece;
boolean canHoldPiece;
boolean gameOver;
GameState gameState;
int currentLevel;

// Dynamic CLIMBING variables
Player player;
ArrayList<Wall> walls;

// This function is called once, at startup.
void setup() {
        size(1728, 972);
    // Cheats
    onlySpawnLongPieces = false;

    // Settings
    gridWidth = 64;
    gridHeight = 36;
    pixelsPerBlock = width/gridWidth;
    timeIntervalFlag = 500;
    playerLength = pixelsPerBlock;
    playerXstartPos = pixelsPerBlock * 2;
    playerYstartPos = (gridHeight - 2) * pixelsPerBlock - pixelsPerBlock/8;
    
    // Colors
    backgroundColor = color(0);
    gridBackgroundColor = color(135, 206, 235);
    goalColor = color(203, 209, 25);

    // Dynamic BUILDING variables
    lastTimeCheck = millis();
    grid = new Grid();
    currentPiece = createRandomPiece();
    currentPiece.fillBlocks();
    heldPiece = null;
    canHoldPiece = true;
    gameOver = false;
    gameState = GameState.BUILDING;
    currentLevel = 1;
    
    // Dynamic CLIMBING variables
    player = new Player(0, 0);
    setPlayerToStartPos();
}

// This function is called ~60 times per second.
void draw() {
    if (gameState == GameState.BUILDING) {
        updateBuildingGameStateIfTimerReady();
    }
    else if (gameState == GameState.CLIMBING) {
        updateClimbingGameState();
    }
    drawEverything();
}
