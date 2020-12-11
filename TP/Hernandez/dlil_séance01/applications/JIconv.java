/**
 *
 * Outil de conversion d'encodage.
 * 
 * N. Hernandez
 * 
 * http://download.oracle.com/javase/tutorial/i18n/text/stream.html
 * http://stackoverflow.com/questions/652161/how-do-i-convert-between-iso-8859-1-and-utf-8-in-java
 * http://stackoverflow.com/questions/655891/converting-utf-8-to-iso-8859-1-in-java-how-to-keep-it-as-single-byte
 *
 *************
 *  Utilisation:
 *
 *


 **/ 

import java.io.*;

public class JIconv {

	/*
	 * 
	 */
	public static void main(String[] args) {
		//

		//
		if(args.length != 6) {
			System.out.println("Usage: -f sourceEncoding -t targetEncoding sourceFileName targetFileName");
			System.out.println("java JIconv -f ISO-8859-1 -t UTF-8 sourceFileName targetFileName");

		}
		else {
			long debut = System.currentTimeMillis();

			String sourceEncoding= args[1];
			String targetEncoding= args[3];
			String sourceFileName = args[4];
			String targetFileName = args[5];


			writeOutput(targetFileName, targetEncoding, readInput(sourceFileName, sourceEncoding));

			long fin = System.currentTimeMillis();
			System.out.println("Temps écoulé: "+ ((fin-debut)/1000.0)+" s");
		}
	}

	/**
	 * 
	 * @param fileName
	 * @param encoding
	 * @return
	 */
	static String readInput(String fileName, String encoding) {

		StringBuffer buffer = new StringBuffer();
		try {
			FileInputStream fis = new FileInputStream(fileName);
			InputStreamReader isr = new InputStreamReader(fis,
					encoding);
			Reader in = new BufferedReader(isr);
			int ch;
			while ((ch = in.read()) > -1) {
				buffer.append((char)ch);
			}
			in.close();
			return buffer.toString();
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}

	static void writeOutput(String fileName, String encoding, String str) {

		try {
			FileOutputStream fos = new FileOutputStream(fileName);
			Writer out = new OutputStreamWriter(fos, encoding);
			out.write(str);
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}


