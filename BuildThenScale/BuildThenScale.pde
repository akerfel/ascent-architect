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

// Textures
PImage stoneTexture;

// Dynamic CLIMBING variables
Player player;
ArrayList<Wall> walls;

// score and highscore
int score;
PrintWriter output;

// Dynamic BUILDING variables
int currentLevelNum;
int lastTimeCheck;
Grid grid;
Piece currentPiece;
Piece heldPiece;
boolean canHoldPiece;
boolean gameOver;
GameState gameState;
int distancePiecesSpawnAbovePlayer;

// This function is called once, at startup.
void setup() {
    size(600, 1000);
    
    initializeState();
}

void initializeState() {
    // Cheats
    onlySpawnLongPieces = false;

    // Settings
    gridWidth = 14;
    gridHeight = 1000;
    pixelsPerBlock = 1000/80 * 3;
    timeIntervalFlag = 500;
    playerLength = pixelsPerBlock * 2/3;
    playerXstartPos = pixelsPerBlock * 2;
    playerYstartPos = (gridHeight - 1) * pixelsPerBlock - pixelsPerBlock/8;
    
    // Colors
    backgroundColor = color(0);
    gridBackgroundColor = color(135, 206, 235);
    goalColor = color(203, 209, 25);
    
    // Texture
    stoneTexture = loadImage("stone.png");
    
    // Dynamic CLIMBING variables
    player = new Player(0, 0);
    setPlayerToStartPos();
    
    
    // score and highscore
    score = 0;
    createDataFolderIfDoesNotExist();
    
    // Dynamic BUILDING variables
    currentLevelNum = 0;
    grid = new Grid();
    //loadCurrentLevel();
    grid.initializeBlocks();
    lastTimeCheck = millis();
    currentPiece = createRandomPiece();
    currentPiece.fillBlocks_and_checkIfGAMEOVER();
    heldPiece = null;
    canHoldPiece = false;
    gameState = GameState.GAMEACTIVE;
    distancePiecesSpawnAbovePlayer = 15;    
}

void gameOver() {
    gameState = GameState.GAMEOVER;
    saveCurrentScore();  // will only save if actually is new highscore
}

void resetGame() {
    initializeState();
}

// This function is called ~60 times per second.
void draw() {
    switch(gameState) {
    case GAMEACTIVE:
        updateBuildingGameStateIfTimerReady();
        updateClimbingGameState();
        drawEverything();
        break;
    case GAMEOVER:
        drawGameOver();
        break;
    case STARTSCREEN:
        break;
    }
}
