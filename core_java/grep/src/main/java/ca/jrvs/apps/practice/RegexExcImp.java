package ca.jrvs.apps.practice;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class RegexExcImp implements RegexExc{
  Pattern pattern;
  Matcher matcher;
  @Override
  public boolean matchJpeg(String filename) {
    pattern = Pattern.compile(".*\\.jpn?g$");
    matcher = pattern.matcher(filename);
    System.out.println(matcher.matches());
    //System.out.println(filename.matches(".*\\.jpn?g")); less efficient solution
    return matcher.matches();
  }

  @Override
  public boolean matchIp(String ip) {
    pattern = Pattern.compile("([0-9]{1,3}\\.){3}[0-9]{1,3}");
    matcher = pattern.matcher(ip);
    System.out.println(matcher.matches());
    return matcher.matches();
  }

  @Override
  public boolean isEmptyLine(String Line) {
    pattern = Pattern.compile("^\\s*$");
    matcher = pattern.matcher(Line);
    System.out.println(matcher.matches());
    return matcher.matches();
  }

  public static void main(String[] args) {
    RegexExcImp r = new RegexExcImp();
    r.matchJpeg("test.jpg");
    r.matchIp("123.3.2.1");
    r.isEmptyLine("  ");
  }
}
