import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import org.jsoup.*; 
import org.jsoup.examples.*; 
import org.jsoup.helper.*; 
import org.jsoup.nodes.*; 
import org.jsoup.parser.*; 
import org.jsoup.safety.*; 
import org.jsoup.select.*; 
import http.requests.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class doubanCrawler extends PApplet {










int pageNumber;
String url;
String data;

public void setup() {
  
  background(0);
  
  pageNumber = 94974116;
  url = "https://www.douban.com/group/topic/"+pageNumber+"/";
  GetRequest get = new GetRequest(url);
  get.send();
  data = get.getContent();
  Document doc = Jsoup.parse(data);
  Elements filter1 = doc.getElementsByClass("reply-doc");

  // Elements filter2 = filter1.getElementsByClass("content");
  // println(allClasses.size());
  for(Element e : filter1){
    println(e.getElementsByClass("content"));
  }
}
  public void settings() {  size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "doubanCrawler" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
