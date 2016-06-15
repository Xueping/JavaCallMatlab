package call.mat.demo;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class MainLoop {
	
	 public static void main(String args[]) {
		 
		 
		 try (BufferedReader br = new BufferedReader(new FileReader("Parameter_List.txt"))) {

				String line;
				
				List<String> paras = new ArrayList<String>();
				while ((line = br.readLine()) != null) {
					paras.add(line);
				}
				
				for(int i = 0; i < paras.size();){
					Thread t1 = new CallMatlabThread(paras.get(i));
					t1.start();
					if (i+1==paras.size()){
						break;
					}
					Thread t2 = new CallMatlabThread(paras.get(i+1));
					t2.start();
					if (i+2==paras.size()){
						break;
					}
					Thread t3 = new CallMatlabThread(paras.get(i+2));
					t3.start();
					while(t1.getState()!=Thread.State.TERMINATED
							||t2.getState()!=Thread.State.TERMINATED
							||t3.getState()!=Thread.State.TERMINATED){ 
						try {
							Thread.sleep(5*1000);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					}
					i = i+3;
				}

			} catch (IOException e) {
				e.printStackTrace();
			}

	   }   
}
