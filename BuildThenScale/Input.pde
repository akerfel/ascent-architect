void keyPressed() {
    if (gameState == GameState.BUILDING) {
        handleBuildingInput(key);
    }
    else if (gameState == GameState.CLIMBING) {
        handleClimbingInput(key);
    }
}

void handleBuildingInput(int key) {
    if (key == ENTER) {
          gameState = GameState.CLIMBING;
          return;
    }
    if (key == CODED) {
        if (keyCode == UP) {
            currentPiece.tryToRotate();
        }
        if (keyCode == LEFT) {
            currentPiece.tryToMoveLeft();
        }
        if (keyCode == RIGHT) {
            currentPiece.tryToMoveRight();
        }
        if (keyCode == DOWN) {
            makePieceFallOrSpawnNewPiece();
            lastTimeCheck = millis();
        }
    }

    if (key == ' ') {
        // Make current piece fall until a new piece is spawned.
        while (!makePieceFallOrSpawnNewPiece());
        lastTimeCheck = millis();
        makePieceFallOrSpawnNewPiece();
    }

    if (key == 'c') {
        holdCurrentPiece();
    }
}

void handleClimbingInput(int key) {
    
}
