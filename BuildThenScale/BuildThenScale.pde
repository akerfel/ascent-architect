// In this file, all global variables and declared and initialized,
// and the draw() method is defined, which is called ~60 times per second.
// The setup() method is also called, which is called once, at startup.

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
int currentLevelNum;
int lastTimeCheck;
Grid grid;
Piece currentPiece;
Piece heldPiece;
boolean canHoldPiece;
boolean gameOver;
GameState gameState;

// Dynamic CLIMBING variables
Player player;
ArrayList<Wall> walls;

// This function is called once, at startup.
void setup() {
    size(800, 800);
    
    // Cheats
    onlySpawnLongPieces = false;

    // Settings
    gridWidth = 14;
    gridHeight = 80;
    pixelsPerBlock = height/gridHeight * 4;
    timeIntervalFlag = 500;
    playerLength = pixelsPerBlock * 2/3;
    playerXstartPos = pixelsPerBlock * 2;
    playerYstartPos = (gridHeight - 4) * pixelsPerBlock - pixelsPerBlock/8;
    
    // Colors
    backgroundColor = color(0);
    gridBackgroundColor = color(135, 206, 235);
    goalColor = color(203, 209, 25);
    
    // Dynamic CLIMBING variables
    player = new Player(0, 0);
    setPlayerToStartPos();

    // Dynamic BUILDING variables
    currentLevelNum = 0;
    grid = new Grid();
    //loadCurrentLevel();
    grid.initializeBlocks();
    lastTimeCheck = millis();
    currentPiece = createRandomPiece();
    currentPiece.fillBlocks();
    heldPiece = null;
    canHoldPiece = false;
    gameOver = false;
    gameState = GameState.BUILDING;
}

// This function is called ~60 times per second.
void draw() {
    //if (gameState == GameState.BUILDING) {
        updateBuildingGameStateIfTimerReady();
    //}
    //else if (gameState == GameState.CLIMBING) {
        updateClimbingGameState();
    //}
    drawEverything();
}
