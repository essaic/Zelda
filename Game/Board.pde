class Board {
  final float board_width;
  final float board_length;
  final float board_height;
  
  Board(float board_width, float board_height, float board_length) {
    this.board_width = board_width;
    this.board_length = board_length;
    this.board_height = board_height;
  }
  
  void display() {
    stroke(30);
    fill(255);
    box(board_length, board_height, board_width);
  }
}
