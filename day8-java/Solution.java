import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class Solution {
  static String inputPath = "./input.txt";
  private static int dim = 99;
  private static int[][] matrix = new int[dim][dim];
  private static boolean[][] visible = new boolean[dim][dim];

  public static void main(String args[]) throws IOException {
    readInput();
    findVisibility();

    int numVisible = 0;
    for (int x = 0; x < dim; x++) {
      for (int y = 0; y < dim; y++) {
        if (visible[x][y]) numVisible++;
      }
    }

    System.out.println(numVisible);

    int score = getTopScore();
    System.out.println(score);
  }

  private static void readInput() throws IOException {
    byte[] bytes = Files.readAllBytes(Paths.get(inputPath));
    String s = new String(bytes);

    for (int i = 0; i < s.length(); i++) {
      char c = s.charAt(i);
      if (c != '\n') {
        int n = c - '0';
        matrix[i / (dim+1)][i % (dim+1)] = n;
      }
    }
  }

  private static int checkPoint(int x, int y, int max) {
    if (matrix[x][y] > max) {
      visible[x][y] = true;
      return matrix[x][y];
    }
    return max;
  }

  private static void findVisibility() {
    int max;
    for (int x = 0; x < dim; x++) {
      max = -1;
      for (int y = 0; y < dim; y++) {
        max = checkPoint(x,y,max);
      }

      max = -1;
      for (int y = dim-1; y >= 0; y--) {
        max = checkPoint(x,y,max);
      }
    }

    for (int y = 0; y < dim; y++) {
      max = -1;
      for (int x = 0; x < dim; x++) {
        max = checkPoint(x,y,max);
      }

      max = -1;
      for (int x = dim-1; x >= 0; x--) {
        max = checkPoint(x,y,max);
      }
    }
  }

  private static int getScore(int x, int y) {
    if (!visible[x][y]) return 0;

    int total = 1;
    int score = 0;
    int start = matrix[x][y];
    int max = -1;
    for (int xx = x+1; xx < dim; xx++) {
      score++;
      if (matrix[xx][y] >= start) break;
    }
    total *= score;

    max = -1;
    score = 0;
    for (int xx = x-1; xx >= 0; xx--) {
      score++;
      if (matrix[xx][y] >= start) break;
    }
    total *= score;

    max = -1;
    score = 0;
    for (int yy = y+1; yy < dim; yy++) {
      score++;
      if (matrix[x][yy] >= start) break;
    }
    total *= score;

    max = -1;
    score = 0;
    for (int yy = y-1; yy >= 0; yy--) {
      score++;
      if (matrix[x][yy] >= start) break;
    }
    total *= score;

    return total;
  }

  private static int getTopScore() {
    int best = -1;
    for (int x = 0; x < dim; x++) {
      for (int y = 0; y < dim; y++) {
        int score = getScore(x,y);
        if (score > best) {
          best = score;
        }
      }
    }
    return best;
  }
}