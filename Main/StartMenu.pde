class StartMenu {
    Button playButton;
    Button settingsButton;
    Button quitButton;

    StartMenu() {
        playButton = new Button("Play", width / 2, 300);
        settingsButton = new Button("Settings", width / 2, 400);
        quitButton = new Button("Quit", width / 2, 500);
    }

    void display() {
        background(background1);
        fill(255);
        textSize(32);
        textAlign(CENTER, CENTER);
        text("Sky Scraper", width / 2, 100);

        playButton.display();
        settingsButton.display();
        quitButton.display();
    }

    void handleMousePressed() {
        if (playButton.isClicked(mouseX, mouseY)) {
            gameState = GameState.GAMEACTIVE;
        } else if (settingsButton.isClicked(mouseX, mouseY)) {
            // Transition to settings screen (not implemented in this example)
        } else if (quitButton.isClicked(mouseX, mouseY)) {
            exit(); // Exit the program
        }
    }
}

class Button {
    String label;
    float x, y;
    float width = 200;
    float height = 50;

    Button(String label, float x, float y) {
        this.label = label;
        this.x = x;
        this.y = y;
    }

    void display() {
        fill(255);
        rectMode(CENTER);
        rect(x, y, width, height, 10);
        fill(0);
        textSize(24);
        textAlign(CENTER, CENTER);
        text(label, x, y);
        rectMode(CORNER);
        textAlign(CORNER);
    }

    boolean isClicked(float mouseX, float mouseY) {
        return mouseX > x - width / 2 && mouseX < x + width / 2 &&
               mouseY > y - height / 2 && mouseY < y + height / 2;
    }
}
