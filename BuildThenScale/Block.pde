public class Block {
    boolean isFilled;
    color rgbColor;
    boolean isGoal;

    public Block(boolean isFilled) {
        this.isFilled = isFilled;
        this.rgbColor = color(19,133,16);
    }
    
    void setIsGoal(boolean isGoal) {
        this.isGoal = isGoal;    
    }
    
    void setRgbColor(color rgbColor) {
        this.rgbColor = rgbColor;
    }
}
