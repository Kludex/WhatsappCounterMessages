import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.*;

public class WhatsappCounter {

  public static void main(String[] args) {
    try {
      if (args.length != 1)
        throw new IllegalArgumentException("Exactly 1 parameter required!");

      FileReader fr = new FileReader(args[0]);
      BufferedReader br = new BufferedReader(fr);
      Pattern pattern = Pattern.compile("(.*) - ([^:]*): (.*)");
      Map<String, Integer> mp = new HashMap<String, Integer>();

      while (br.ready()) {
        String line = br.readLine();
        Matcher matcher = pattern.matcher(line);

        if (matcher.matches()) {
          String name = matcher.group(2);
          if (name.equals("Erro")) continue;
          if (mp.containsKey(name))
            mp.put(name, mp.get(name) + 1);
          else
            mp.put(name, 1);
        }
      }

      for (Map.Entry<String, Integer> entry : mp.entrySet())
        System.out.println(entry.getKey() + ": " + entry.getValue());

    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
