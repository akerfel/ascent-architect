void keyPressed() {
    if (key == ENTER) {
        if (gameState == GameState.BUILDING) {
            gameState = GameState.CLIMBING;    
        }
        else if (gameState == GameState.CLIMBING) {
            gameState = GameState.BUILDING;    
        }
    }
    
    if (gameState == GameState.BUILDING) {
        handleBuildingInput(key);
    }
    handleClimbingInput(key);
}

void handleBuildingInput(int key) {
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

    if (key == 'c') {
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
    if (key == 'a' || key == 'A') {
        player.movingLeft = true;  
    }
    if (key == 'd' || key == 'D') {
        player.movingRight = true;  
    }
    if (key == ' ' || key == 'w' || key == 'W') {
        player.jump(); 
    }
}

void keyReleased() {
    handleKeyReleasedClimbing(key);    
}

void handleKeyReleasedClimbing(int key) {
    if (key == 'a' || key == 'A') {
        player.movingLeft = false;  
    }
    if (key == 'd' || key == 'D') {
        player.movingRight = false;  
    }    
}
