// Cheats
boolean onlySpawnLongPieces;

// Settings
int pixelsPerBlock;
int gridWidth;
int gridHeight;
int playerLength;
int playerXstartPos;
int playerYstartPos;
int distancePiecesSpawnAbovePlayer;
int numBlocksVisibleBelowPlayer;

// The falling piece moves down one step per tick
int initialTickTime;
int minimumTickTime;
int decreaseInTickTimePerLevel;
int levelIncrementPerScore;
int currentTickTime; // changes

// Colors
color backgroundColor;
color gridBackgroundColor;
color goalColor;

// Dynamic CLIMBING variables
Player player;
ArrayList<Wall> walls;

// Dynamic BUILDING variables
int currentLevelNum;
int lastTimeCheck;
Grid grid;
Piece currentPiece;
Piece heldPiece;
boolean canHoldPiece;
boolean gameOver;
GameState gameState;

// score and highscore
int score;
PrintWriter output;

// Textures
PImage stoneTexture;

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
    playerLength = pixelsPerBlock * 2/3;
    playerXstartPos = pixelsPerBlock * 2;
    playerYstartPos = (gridHeight - 1) * pixelsPerBlock - pixelsPerBlock/8;
    distancePiecesSpawnAbovePlayer = 15;    
    numBlocksVisibleBelowPlayer = 6;
    
    // Time per tick
    initialTickTime = 700;
    decreaseInTickTimePerLevel = 80;
    minimumTickTime = 100;
    levelIncrementPerScore = 10;
    currentTickTime = initialTickTime;
    
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
