import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.*;

public class WhatsappCounter {

  public static <K, V> void printMap(Map<K, V> map, int num) {
    for (Map.Entry<K, V> entry : map.entrySet()) {
      System.out.println(entry.getKey() + ": " + entry.getValue());
      if (--num == 0)
        break;
    }
  }

   private static Map<String, Integer> sortByValue(Map<String, Integer> mp) {
    List<Map.Entry<String, Integer>> list = new LinkedList<Map.Entry<String, Integer>>(mp.entrySet());

    Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {
      public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
        return (o2.getValue()).compareTo(o1.getValue());
      }
    });

    Map<String, Integer> sortedMap = new LinkedHashMap<String, Integer>();
    for (Map.Entry<String, Integer> entry : list)
      sortedMap.put(entry.getKey(), entry.getValue());

    return sortedMap;
  }

  public static void main(String[] args) {
    try {
      if (args.length != 2)
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

      mp = sortByValue(mp);
      printMap(mp, Integer.parseInt(args[1]));

    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
