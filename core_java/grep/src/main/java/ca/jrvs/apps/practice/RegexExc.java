package ca.jrvs.apps.practice;

public interface RegexExc {

  /**
   * return true if filename extension is jpg or jpeg (case insensitive)
   * @param filename
   * @return
   */
  public boolean matchJpeg(String filename);

  /**
   * return true if ip is valid (range from 0.0.0.0 to 999.999.999.999)
   * @param ip
   * @return
   */
  public boolean matchIp(String ip);

  /**
   * return true if line empty (e.g. empty, white space, tavs, etc.)
   * @param Line
   * @return
   */
  public boolean isEmptyLine(String Line);
}
