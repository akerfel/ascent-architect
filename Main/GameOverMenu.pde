class GameOverMenu {
    Button mainMenuButton;

    GameOverMenu() {
        mainMenuButton = new Button("Main Menu", width / 2, height * 0.8);
    }

    void display() {
        fill(255);
        textSize(55);
        textAlign(CENTER, CENTER);

        mainMenuButton.display();
        drawGameOver();
    }

    void handleMousePressed() {
        if (mainMenuButton.isClicked(mouseX, mouseY)) {
            resetGame();
            gameState = GameState.STARTSCREEN; // Change the game state back to the start menu
        }
    }
}
