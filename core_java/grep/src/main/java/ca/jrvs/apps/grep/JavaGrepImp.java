package ca.jrvs.apps.grep;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.BasicConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class JavaGrepImp implements JavaGrep{

  final Logger logger = LoggerFactory.getLogger(JavaGrep.class);
  private String regex;
  private String rootPath;
  private String outFile;


  public static void main(String[] args) {
    if (args.length != 3) {
      throw new IllegalArgumentException("USAGE: JavaGrep regex rootPath outFile");
    }

    //Use default logger config
    BasicConfigurator.configure();

    JavaGrepImp javaGrepImp = new JavaGrepImp();
    javaGrepImp.setRegex(args[0]);
    javaGrepImp.setRootPath(args[1]);
    javaGrepImp.setOutFile(args[2]);

    try {
      javaGrepImp.process();
    }catch (Exception ex){
      javaGrepImp.logger.error("Error: Unable to process", ex);
    }
  }

  @Override
  public void process() throws IOException {
    List<String> matchedLines = new ArrayList<>();
    List<File> files=ListFiles(getRootPath());
    for (File file : files){
      List<String> lines = readLines(file);
      if (lines != null) {
        for (String line : lines) {
          if (containsPattern(line)) {
            matchedLines.add(line);
          }
        }
      }
    }
    writeToFile(matchedLines);
  }

  @Override
  public List<File> ListFiles(String rootDir) {
    //Create an Arraylist of File objects
    List<File> fileList = new ArrayList<>();
    //Create a File object for directory
    File dirPath = new File(rootDir);
    //List of all files and directories
    File list[] = dirPath.listFiles();

    if (list == null) return fileList;

    for (File file : list){
      if (file.isDirectory()){
        fileList.addAll(ListFiles(String.valueOf(file)));
      }
      else {
        fileList.add(file);
      }
    }
    return fileList;
  }

  @Override
  public List<String> readLines(File inputFile) throws IllegalArgumentException {
    List<String> lineList = null;
    try {
      //connect to the file
      Path path = Paths.get(String.valueOf(inputFile));
      //add all the lines to the arraylist
      lineList = Files.readAllLines(path);
    } catch (Exception e) {
      logger.error("Error: Unable to process", e);
    }
    return lineList;
  }

  @Override
  public boolean containsPattern(String line) {
    Pattern pattern = Pattern.compile(getRegex());
    Matcher matcher = pattern.matcher(line);
    //if(matcher.matches()) logger.debug(String.valueOf(matcher.matches()));
    return matcher.matches();
  }

  @Override
  public void writeToFile(List<String> Lines) throws IOException {
    //created a File object called outFile
    File outFile = new File(getOutFile());
    //created a FileWriter object called myWriter
    FileWriter myWriter = new FileWriter(outFile);
    //write regex matching lines to file
    myWriter.write(String.valueOf(Lines));
    //close the file
    myWriter.close();
  }

  @Override
  public String getRegex() {
    return regex;
  }

  @Override
  public void setRegex(String regex) {
    this.regex = regex;
  }

  @Override
  public String getRootPath() {
    return rootPath;
  }

  @Override
  public void setRootPath(String rootPath) {
    this.rootPath = rootPath;
  }

  @Override
  public String getOutFile() {
    return outFile;
  }

  @Override
  public void setOutFile(String outFile) {
    this.outFile = outFile;
  }
}
