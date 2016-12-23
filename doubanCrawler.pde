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

int pageNumber;
String url;
String data;


int startingPageNumber = 83974016+3000;


void setup() {
  size(400, 400);
  background(0);

  for ( int pageNumber = startingPageNumber; pageNumber < startingPageNumber+20000; pageNumber++) {
    url = "https://www.douban.com/group/topic/"+pageNumber+"/";
    GetRequest get = new GetRequest(url);
    get.send();
    data = get.getContent();
    Document doc = Jsoup.parse(data);
    Elements allPosters = doc.select("div.reply-doc > div.bg-img-green > h4 > a");
    Elements allContent = doc.select("div.reply-doc > p");
    Elements pubTimes = doc.select("div.reply-doc .pubtime");
    for (int i=0; i<allContent.size(); i++) {
      if (allContent.get(i).html().contains("脑子")) {
        String finalString = allPosters.get(i).html() + "\t" + pubTimes.get(i).html() + "\t" + allContent.get(i).html();

        try {
          File file =new File("/Users/yangwang/Desktop/results.txt");

          if (!file.exists()) {
            file.createNewFile();
          }

          FileWriter fw = new FileWriter(file, true);///true = append
          BufferedWriter bw = new BufferedWriter(fw);
          PrintWriter pw = new PrintWriter(bw);

          pw.write(finalString);

          pw.close();
        }
        catch(IOException ioe) {
          System.out.println("Exception ");
          ioe.printStackTrace();
        }

        //output.println(allPosters.get(i).html() + "\t" + pubTimes.get(i).html() + "\t" + allContent.get(i).html());
      };
    }  
    println(pageNumber-startingPageNumber);
    delay(1000);
  }

  exit(); // Stops the program
}