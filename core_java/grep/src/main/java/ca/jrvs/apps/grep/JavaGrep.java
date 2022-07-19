package ca.jrvs.apps.grep;

import java.io.File;
import java.io.IOException;
import java.util.List;

public interface JavaGrep {

  /**
   * Top level search worklow
   * @throws IOException
   */
  void process() throws IOException;

  /**
   * Traverse a given directory and return all files
   * @param rootDir input directory
   * @return files under the rootDir
   */
  List<File> ListFiles(String rootDir);

  /**
   *
   * @param inputFile file to be read
   * @return lines
   * @throws IllegalArgumentException if a given inputFile is not a file
   */
  List<String> readLines(File inputFile) throws IllegalArgumentException;

  /**
   * check if a line contains the regex pattern (passed by user)
   * @param line input string
   * @return  true if there is a match
   */
  boolean containsPattern(String line);

  /**
   * write lines to a file
   * explore: FileOutputStream, OutputStreamWriter and BufferedWriter
   * @param Lines matched line
   * @throws IOException if write failed
   */
  void writeToFile(List<String> Lines) throws IOException;

  String getRootPath();

  void setRootPath(String rootPath);

  String getRegex();

  void setRegex(String regex);

  String getOutFile();

  void setOutFile(String outFile);
}
