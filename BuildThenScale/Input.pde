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
    if (keyCode == UP || key == 'w') {
        currentPiece.tryToRotate();
    }
    if (keyCode == LEFT || key == 'a') {
        currentPiece.tryToMoveLeft();
    }
    if (keyCode == RIGHT || key == 'd') {
        currentPiece.tryToMoveRight();
    }
    if (keyCode == DOWN || key == 's') {
        makePieceFallOrSpawnNewPiece();
        lastTimeCheck = millis();
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
    if (key == ENTER) {
          gameState = GameState.BUILDING;
          return;
    }
    if (keyCode == LEFT || key == 'a') {
        player.movingLeft = true;  
    }
    if (keyCode == RIGHT || key == 'd') {
        player.movingRight = true;  
    }
    if (key == ' ') {
        player.jump(); 
    }
}

void keyReleased() {
    if (gameState == GameState.CLIMBING) {
        handleKeyReleasedClimbing(key);    
    }
}

void handleKeyReleasedClimbing(int key) {
    if (key == 'a') {
        player.movingLeft = false;  
    }
    if (key == 'd') {
        player.movingRight = false;  
    }    
}
