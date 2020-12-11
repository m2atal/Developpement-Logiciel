/**
*
* Outil de traitement de fichiers par les expressions régulières.
* Écrit par Daniel Lemire, professeur, pour le cours INF 6460.
* 14 novembre 2005.
*
*************
*  Utilisation:
*
*   java JSed monexpression mesfichiers
* 
*  par exemple: 
*
*         java JSed '".*"' toto.txt 
*
*  donne tout texte entre paranthèses dans le fichier toto.txt. Le
*  traitement se fait ligne par ligne. Pour avoir le texte sans les 
*  paranthèses, faire 
*
*         java JSed '"(.*)"' toto.txt
*  
*  Pour avoir plus d'information, vous pouvez utiliser le drapeau "-v"
*  comme ceci : 
*
*         java JSed -v '".*"' toto.txt
*
**/ 

import java.util.regex.*;
import java.io.*;

public class JSed {

  private static final String usage= "Usage: java JSed \"regexp\" \"replacement\" * ";

  public static void main(String[] args) {
    boolean verbose = false;
    int pos = 0;

	if (args.length < 1 ) {

	      System.out.println(usage);
	
    }
else {

    if(args[pos].equals("-h")) {
      ++pos;
      System.out.println(usage);
    }



    if(args[pos].equals("-v")) {
      verbose = true;
      ++pos;
      System.out.println("Mode verbose");
    }

    if(verbose) System.out.println("Substitue: "+args[pos]);
    Pattern RegexCompile = Pattern.compile(args[pos]);
    ++pos;

    if(verbose) System.out.println("Avec: "+args[pos]);
    String avec = args[pos];
    ++pos;


    long debut = System.currentTimeMillis();

    if (pos < args.length) {
    for(; pos < args.length ; ++pos) {
      try {
        if(verbose) System.out.println("Je traite le fichier: "+args[pos]);
        match(new File(args[pos]),RegexCompile, avec,verbose);
        if(verbose) System.out.println("J'ai traité le fichier: "+args[pos]);
      } catch (IOException ioe) {
        System.out.println("Impossible de traiter le fichier: "+args[pos]);
        ioe.printStackTrace();
      }
    }
    } 
else {
try {
        if(verbose) System.out.println("Je traite le stdin: ");
        match(RegexCompile, avec,verbose);
        if(verbose) System.out.println("J'ai traité le stdin ");
      } catch (IOException ioe) {
        System.out.println("Impossible de traiter le stdin ");
        ioe.printStackTrace();
      }
	}

    long fin = System.currentTimeMillis();
    if(verbose) System.out.println("Temps écoulé: "+ ((fin-debut)/1000.0)+" s");
}
  }

  public static void match(File f, Pattern RegexCompile, String avec, boolean verbose) throws IOException {
    if(!f.isFile()) return;
    BufferedReader br = new BufferedReader(new FileReader(f));
    try {
      String ligne;
      boolean trouve = false;
      while((ligne = br.readLine()) != null) {
        Matcher m = RegexCompile.matcher(ligne);
	System.out.println(m.replaceAll(avec));
      }
      if(verbose && !trouve) 
        System.out.println("Le motif n'a pas été trouvé!");
    } finally {
      br.close();
    }
  }

public static void match(Pattern RegexCompile, String avec, boolean verbose) throws IOException {
   BufferedReader br = new BufferedReader
      (new InputStreamReader(System.in));
    try {
      String ligne;
      boolean trouve = false;
      while((ligne = br.readLine()) != null) {
        Matcher m = RegexCompile.matcher(ligne);
	System.out.println(m.replaceAll(avec));
      }
      if(verbose && !trouve) 
        System.out.println("Le motif n'a pas été trouvé!");
    } finally {
      br.close();
    }
  }
 // Defines the standard input stream
    BufferedReader stdin = new BufferedReader
      (new InputStreamReader(System.in));
    String message; // Creates a varible called message for input





}



