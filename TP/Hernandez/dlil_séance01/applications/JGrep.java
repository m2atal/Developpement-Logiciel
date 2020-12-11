
/**
 * Outil de traitement de fichiers par les expressions régulières.
 * 
 * @author  hernandez
 * 
 * Réference: Daniel Lemire, professeur, pour le cours INF 6460. 14 novembre 2005.
 *
 **/ 

import java.util.regex.*;
import java.io.*;

public class JGrep {

	private static final String usage= "Usage: [-d mode debug] [-l echo the line not only the regex] [-v invert-match] [-i fileName] [-r regex] "; //[-s echo the source file where the regex is found] 

	public static void main(String[] args) {

	

		boolean verbose = false;
		boolean line = false;
		boolean invertMatch = false;
		String inputFilePath ="";
		String regex = "";
		int pos = 0;

		while (pos < args.length) {
			if(args[pos].equals("-d")) {
				verbose = true;
				++pos;
				System.err.println("Mode debug");
			}
			else
				if(args[pos].equals("-l")) {
					line = true;
					++pos;
					if(verbose)  System.err.println("Echo line (not only the regex)");
				}

			/*boolean source = false;
		if(args[pos].equals("-s")) {
			source = true;
			++pos;
			if(verbose)  System.err.println("Echo the source file where the regex is found");
		}*/

				else
					if(args[pos].equals("-v")) {
						invertMatch = true;
						++pos;
						if(verbose)  System.err.println("InvertMatch");
					}
					else 					if(args[pos].equals("-i")) {
						inputFilePath = args[++pos];
						++pos;
						if(verbose)  System.err.println("InvertMatch");
					}
					else if(args[pos].equals("-r")) {
						regex = args[++pos];
						++pos;
						if(verbose)  System.err.println("InvertMatch");
					} else  {
						System.err.println(usage);
						System.exit(1);
					}

		}

		if (regex.equalsIgnoreCase(""))  {
			System.err.println(usage);
			System.exit(1);
		}

		Pattern RegexCompile = Pattern.compile(regex);
		++pos;

		BufferedReader reader = null;
		if (!inputFilePath.equalsIgnoreCase(""))
			try {
				reader = new BufferedReader( new FileReader (args[pos]));
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		else 
			reader = new BufferedReader	(new InputStreamReader(System.in));


		long debut = System.currentTimeMillis();
		//	for(; pos < args.length ; ++pos) {
		try {
			if(verbose) System.err.println("Je traite le fichier: "+args[pos]);
			match(reader,RegexCompile, verbose, line, invertMatch);
			if(verbose) System.err.println("J'ai traité le fichier: "+args[pos]);
		} catch (IOException ioe) {
			System.err.println("Impossible de traiter le fichier: "+args[pos]);
			ioe.printStackTrace();
		}
		//}
		long fin = System.currentTimeMillis();
		if(verbose) System.err.println("Temps écoulé: "+ ((fin-debut)/1000.0)+" s");
	}


	public static void match(BufferedReader reader, Pattern RegexCompile, boolean verbose, boolean line,boolean invertMatch) throws IOException {

		try {
			String ligne;
			boolean trouve = false;
			while((ligne = reader.readLine()) != null) {
				Matcher m = RegexCompile.matcher(ligne);
				if (!invertMatch)  {
					//System.out.println("Debug: Match");
					//		while( m.find() ) {
					if ( m.find() ) {
						trouve = true;
						//	if (source) System.out.print(f.getPath()+": ");
						if (line) System.out.println(ligne);
												else  System.out.println(m.group(m.groupCount()));
						//else  System.out.println(ligne);
					}
				}
				else  {
					//System.out.println("Debug: invertMatch");
					if (! m.find(0) ){
						//if (source) System.out.print(f.getPath()+": ");
						System.out.println(ligne);
					}
				}
			}
			if (!line && invertMatch)         System.err.println("Warning: not specifying -l parameter does not work with -v parameter !");
			if(verbose && !trouve) 
				System.err.println("Le motif n'a pas été trouvé!");
		} finally {
			reader.close();
		}
	}
}



