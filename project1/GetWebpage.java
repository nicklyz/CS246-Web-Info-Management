import java.net.*;
import java.io.*;

public class GetWebpage {
    public static void main(String args[]) throws Exception {
      // args[0] has the URL passed as the command parameter.
      // You need to retrieve the webpage corresponding to the URL and print it out on console
      // Here, we simply printout the URL
        //   System.out.println(args[0]);
        URL url;
        InputStream is = null;
        BufferedReader br;
        String line;

        try {
            url = new URL(args[0]);
            is = url.openStream();  // throws an IOException
            br = new BufferedReader(new InputStreamReader(is));

            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
        } catch (MalformedURLException mue) {
            mue.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } finally {
            try {
              if (is != null) is.close();
            } catch (IOException ioe) {
              // nothing to see here
            }
        }
    }
}
