import org.jsoup.*;
import org.jsoup.examples.*;
import org.jsoup.helper.*;
import org.jsoup.nodes.*;
import org.jsoup.parser.*;
import org.jsoup.safety.*;
import org.jsoup.select.*;
import http.requests.*;
import java.lang.*;
import java.io.FileWriter;
import java.io.*;

FileWriter fw;
BufferedWriter bw;

String url;
String data;


ArrayList<String> urls;
String targetString = "脑子";

void setup() {

  urls = new ArrayList<String>();


  String bizu = "https://www.douban.com/group/ustv/discussion?start=";

  for (int i=0; i < 2000; i+=50) {
    String temp_url = bizu+i;
    GetRequest get = new GetRequest(temp_url);
    get.send();
    String html = get.getContent();
    Document doc = Jsoup.parse(html);
    Elements postLinks = doc.select("tbody > tr > td.title > a"); 
    for (Element e : postLinks) {
      urls.add(e.attr("href"));
    }
  }


  for (String url : urls) {
    GetRequest get = new GetRequest(url);
    println(url);
    get.send();
    data = get.getContent();
    Document doc = Jsoup.parse(data);
    Elements allPosters = doc.select("div.reply-doc > div.bg-img-green > h4 > a");
    Elements allContent = doc.select("div.reply-doc > p");
    Elements pubTimes = doc.select("div.reply-doc .pubtime");
    for (int i=0; i<allContent.size(); i++) {
      if (allContent.get(i).html().contains(targetString)) {
        String contentInnerHTML = allContent.get(i).html();
        contentInnerHTML.replace("<br>", "");
        if (contentInnerHTML.length() > 70) {
          int indexof = contentInnerHTML.indexOf(targetString);
          int startIndex, endIndex;

          if (indexof>30) {
            startIndex = 30;
          } else {
            startIndex = 0;
          }

          if (contentInnerHTML.length() > indexof+30) {
            endIndex = 30;
          } else {
            endIndex = contentInnerHTML.length();
          }         

          contentInnerHTML = "..."+contentInnerHTML.substring(startIndex, endIndex)+"...";
        }
        String finalString = allPosters.get(i).html() + "\t" + pubTimes.get(i).html() + "\t" + contentInnerHTML + "\n";

        try {
          File file =new File("/Users/inbox/Documents/Processing/SimpleProcessingDoubalCrawler/doubanCrawler/results.txt");

          if (!file.exists()) {
            file.createNewFile();
          }

          FileWriter fw = new FileWriter(file, true);///true = append
          BufferedWriter bw = new BufferedWriter(fw);
          PrintWriter pw = new PrintWriter(bw);

          pw.write(finalString);
          println(finalString + "\n");

          pw.close();
        }
        catch(IOException ioe) {
          System.out.println("Exception ");
          ioe.printStackTrace();
        }

        //output.println(allPosters.get(i).html() + "\t" + pubTimes.get(i).html() + "\t" + allContent.get(i).html());
      }
    }  
    println(url);
  }

  exit(); // Stops the program
}